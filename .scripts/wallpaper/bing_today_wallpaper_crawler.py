"""Crawl bing today wallpaper from Bing's API."""
from urllib.parse import urljoin
import datetime
import os
import re
import time

import requests


TARGET_DOWNLOAD_FOLDER = '~/.feh'
IMAGE_MAX_COUNT = 40


class BingWallpaper(object):
    """class for crawling bing today wallpaper from internet."""
    def __init__(self):
        # create target folder if it dose not exist
        self.target_folder = os.path.expanduser(TARGET_DOWNLOAD_FOLDER)
        if not os.path.exists(self.target_folder) or \
                not os.path.isdir(self.target_folder):
            os.mkdir(self.target_folder)

        self.session = requests.Session()
        self.api_url = 'https://cn.bing.com/HPImageArchive.aspx?format=js&n=1'

        self.threshold_count = IMAGE_MAX_COUNT

    def _need_download(self) -> bool:
        """should I download picture right now?"""
        today = datetime.datetime.now().strftime(r'%Y-%m-%d')
        today_tm = time.mktime(time.strptime(today, r'%Y-%m-%d'))

        for item in os.listdir(self.target_folder):
            path = os.path.join(self.target_folder, item)
            tm = os.path.getctime(path)
            if tm >= today_tm:
                return False

        return True

    def download_wallpaper(self):
        """download wallpaper from Bing's API."""
        if not self._need_download():
            return

        resp = self.session.get(url=self.api_url).json()
        url = urljoin(self.api_url, resp['images'][0]['url'])

        image_name = re.search(r'OHR\.(.*?)_', url).group(1) + '.jpg'
        with open(os.path.join(self.target_folder, image_name), 'wb') as f:
            f.write(self.session.get(url=url).content)

        self._delete_extra_images()

    def _delete_extra_images(self) -> None:
        """delete oldest images when images' count exceeds threshold."""
        images_list = os.listdir(self.target_folder)
        if len(images_list) <= self.threshold_count:
            return

        images_list = [
            os.path.join(self.target_folder, item) for item in images_list
        ]

        # pylint: disable=W0108
        images_list.sort(key=lambda item: os.path.getctime(item))
        for item in images_list[:-self.threshold_count]:
            os.remove(item)


if __name__ == '__main__':
    app = BingWallpaper()
    app.download_wallpaper()
