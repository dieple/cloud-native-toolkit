import os
import fnmatch

try:
    from os import scandir, walk
except ImportError:
    from scandir import scandir, walk

from .tfprompts import *


def find(pattern, path):
    result = []
    for root, dirs, files in os.walk(path):
        for name in files:
            if fnmatch.fnmatch(name, pattern):
                if "/initial/" not in os.path.join(root) and ".terraform" not in os.path.join(root):
                    result.append(os.path.join(root))
    return result


def find_modules(dir_names):
    """
    Fetch list of directories (modules) currently supported
    :param dir_names: The name of directory contains all terraform modules
    :return: list of directory modules
    """

    modules_to_build = []
    for dir in dir_names:
        modules_to_build = find('main.tf', './' + dir)

    return modules_to_build


def prompt_modules(iterable_data):
    """
    Display and prompt user to select module(s) to build
    This is a multi selection enabled prompt.
    :param iterable_data: Modules to select
    :return: Selected module(s)
    """
    modules_options = {"multi": True,
                       "mouse": False,
                       "prompt": "(shift-tab key for multi select module to build)> "}

    return prompt_user(iterable_data, **modules_options)

