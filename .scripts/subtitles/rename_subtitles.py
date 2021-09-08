"""change subtitle files' name to movies' name."""
import os
import re


class Subtitle(object):
    """class for handling subtitles' name."""
    def run(self, folder: str) -> None:
        """set target folder which will be processed."""
        for item in os.listdir(folder):
            filename, suffix = os.path.splitext(item)
            if suffix in ['.srt']:
                if (matched_str := re.search(r'S(\d+)E(\d+)', filename)):
                    season, episode = matched_str.groups()
                    target = f'friends_s{season}e{episode}_720p_bluray_x264-sujaidr.zh-cn.srt'
                    os.rename(os.path.join(folder, item), os.path.join(folder, target))


if __name__ == '__main__':
    app = Subtitle()
    app.run('/disk1/TV/Friends Season 1 COMPLETE 720p.BRrip.sujaidr (pimprg)')
