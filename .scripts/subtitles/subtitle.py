"""change subtitle files' name to movies' name."""
import os
import re


class Subtitle(object):
    """class for presenting a subtitle file."""
    def __init__(self):
        self._folder = None
        self._file_name = None
        self._suffix = None

    @property
    def path(self) -> str:
        return os.path.join(self._folder, self._file_name + self._suffix)

    @path.setter
    def path(self, path: str) -> None:
        if not os.path.exists(path) or not os.path.isfile(path):
            raise Exception(f"{path} is an invalid path!")
        self._folder, self._file_name = os.path.split(path)
        self._file_name, self._suffix = os.path.splitext(self._file_name)

    def add_local_suffix(self, suffix: str = 'zh-cn') -> None:
        self._suffix = f'.{suffix}{self._suffix}'

    def replace_file_name(self, origin: str, target: str) -> None:
        self._file_name = self._file_name.replace(origin, target)


class SubParser(object):
    """class for handling subtitle."""
    def __init__(self, config: dict):
        """read config from a dictionary."""
        self.folder = config['dir']
        self.replace_list = config.get('replace')
        self.local = config.get('local')

    def fetch_subtitles(self) -> list:
        """get subtitle files in target folder."""
        for item in os.listdir(self.folder):
            filename, suffix = os.path.splitext(item)
            if suffix in ['.srt', '.ass']:
                yield os.path.join(self.folder, item)

    def run(self) -> None:
        """set target folder which will be processed."""
        sub = Subtitle()
        for path in self.fetch_subtitles():
            sub.path = path

            if self.replace_list:
                [sub.replace_file_name(*item) for item in self.replace_list]

            if self.local:
                sub.add_local_suffix(self.local)

            os.rename(path, sub.path)
