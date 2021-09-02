"""Crawl bing history wallpaper from bing.ioliu.cn"""
from urllib.parse import urljoin
import asyncio
import os
import platform
import re

from lxml import etree
import aiohttp

if platform.system() == 'Windows':
    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())
else:
    import uvloop
    asyncio.set_event_loop_policy(uvloop.EventLoopPolicy())


TARGET_DOWNLOAD_FOLDER = '~/.feh'
DOWNLOAD_IMAGE_MAX_COUNT = 20


class BingHistoryWallpaper(object):
    """class for crawling bing wallpaper from internet."""
    def __init__(self):
        self.home_url = 'https://bing.ioliu.cn'
        self.session = None

        # create target folder if it dose not exist
        self.target_folder = os.path.expanduser(TARGET_DOWNLOAD_FOLDER)
        if not os.path.exists(self.target_folder) or \
                not os.path.isdir(self.target_folder):
            os.mkdir(self.target_folder)

        self.threshold = DOWNLOAD_IMAGE_MAX_COUNT
        self.current_count = 0

    async def _create_session(self) -> None:
        """create session if session dose not exist."""
        if not self.session:
            conn = aiohttp.connector.TCPConnector(
                force_close=True, enable_cleanup_closed=True, ssl=False
            )
            self.session = aiohttp.ClientSession(
                connector=conn, trust_env=True
            )

    async def _close_session(self) -> None:
        """close session if session exists."""
        if self.session:
            await self.session.close()

    async def run(self) -> None:
        """process control of web crawler."""
        await self._create_session()

        # start with bing wallpaper mirror website's home page
        await self.parse_html(self.home_url)
        await self._close_session()

    async def parse_html(self, url: str) -> None:
        """download images contained in url, generate a new url and recursive.

        Args:
            url: target url.
        """
        async with self.session.get(url=url) as r:
            resp = await r.text()
        html = etree.HTML(resp)

        tasks = []
        for item in html.xpath('//a[@class="mark"]/@href'):
            img_url = urljoin(self.home_url, urljoin(item, '?force=download'))
            if self.current_count < self.threshold:
                tasks.append(self._download_img(img_url))
                self.current_count += 1
            else:
                await asyncio.gather(*tasks)
                return

        await asyncio.gather(*tasks)

        next_url = html.xpath('//div[@class="page"]/a[2]/@href')[0]
        if next_url != url:
            await self.parse_html(urljoin(self.home_url, next_url))

    async def _download_img(self, url: str) -> None:
        """download a single image to default location.

        Args:
            url: image's target url.
        """
        async with self.session.get(url=url) as r:
            content = await r.read()

        name = re.search(r'photo/(.*?)_', url).group(1) + '.jpg'
        with open(os.path.join(self.target_folder, name), 'wb') as f:
            f.write(content)

        print(f'{url} saved!')


if __name__ == '__main__':
    app = BingHistoryWallpaper()
    asyncio.run(app.run())
