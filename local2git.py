"""copy dotfiles of local machine to git."""
import os
import subprocess


def copy_dotfiles():
    """copy dotfiles to git."""
    git_root_directory = os.path.dirname(__file__)
    blocked_list = ['.gitignore', '.git', '.vim']

    for item in os.listdir(git_root_directory):
        if item in blocked_list or not item.startswith('.'):
            continue

        path = os.path.join(git_root_directory, item)
        origin_path = os.path.expanduser(f'~/{item}')

        # copy dotfiles of home directory
        if os.path.isfile(path):
            try:
                subprocess.run(['cp', origin_path, path], check=True)
            except subprocess.CalledProcessError as e:
                print(e)
            else:
                print(f'{origin_path} copied!')

        # copy dotfiles of subdirectory of home directory
        elif os.path.isdir(path):
            origin_path = os.path.join(origin_path, '.')
            path = os.path.join(path, '.')
            try:
                subprocess.run(['cp', '-a', origin_path, path], check=True)
            except subprocess.CalledProcessError as e:
                print(e)
            else:
                print(f'{origin_path} copied!')

        else:
            raise NotImplementedError


if __name__ == '__main__':
    copy_dotfiles()
