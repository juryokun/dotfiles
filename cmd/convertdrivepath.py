#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title convertDrivePath
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "MacToWinFlag", "optional": true }

from enum import Enum
import subprocess
import sys
import unittest

class Mode(Enum):
    WIN_TO_MAC = "0"
    MAC_TO_WIN = "1"

class Separator(Enum):
    WIN_SEPARATOR = "\\"
    MAC_SEPARATOR = "/"

class SkipCount(Enum):
    WIN_TO_MAC_SKIP_COUNT = 1
    MAC_TO_WIN_SKIP_COUNT = 4

class DrivePath(Enum):
    WIN_PATH = "G:"
    MAC_PATH = "/Users/juryokun/Google\ Drive"

class WinToMacMode:
    mode = Mode.WIN_TO_MAC
    split_separator = Separator.WIN_SEPARATOR.value
    join_separator = Separator.MAC_SEPARATOR.value
    skip_count = SkipCount.WIN_TO_MAC_SKIP_COUNT.value
    drive_path = DrivePath.MAC_PATH.value

    def convert(self, path):
        return path.replace("(", "\(").replace(")", "\)")


class MacToWinMode:
    mode = Mode.MAC_TO_WIN
    split_separator = Separator.MAC_SEPARATOR.value
    join_separator = Separator.WIN_SEPARATOR.value
    skip_count = SkipCount.MAC_TO_WIN_SKIP_COUNT.value
    drive_path = DrivePath.WIN_PATH.value

    def convert(self, path):
        return path.replace("\(", "(").replace("\)", ")")

class PathConverter:

    # __init__で代入
    __mode = None
    __input_path = ""
    __parsed_path = []
    __output_path = ""

    def __init__(self, mode = "0"):
        if mode == Mode.WIN_TO_MAC.value:
            self.__mode = WinToMacMode()
        elif mode == Mode.MAC_TO_WIN.value:
            self.__mode = MacToWinMode()
        else:
            raise ValueError("mode_error. mode: {}".format(mode))
        
        self.__input_path = subprocess.run('pbpaste', capture_output=True, text=True).stdout

        if self.__input_path == "":
            raise ValueError("path_error")

        self.__parse_directory()


    def __parse_directory(self):
        parse_string = self.__input_path
        separator = self.__mode.split_separator

        self.__parsed_path = parse_string.split(separator)
        

    def convert(self):
        separator = self.__mode.join_separator
        joined_path = self.__mode.drive_path
        for path in self.__parsed_path[self.__mode.skip_count:]:
            joined_path += separator + self.__mode.convert(path)
        self.__output_path = joined_path.rstrip("\n")


    def output(self):
        subprocess.run('pbcopy', input=self.__output_path, text=True)

    # for test
    def get_parsed_path(self):
        return self.__parsed_path

    # for test
    def get_mode(self):
        return self.__mode

    # for test
    def get_output(self):
        return self.__output_path


class TestFunc(unittest.TestCase):
    def test_win_to_mac1(self):
        mode = Mode.WIN_TO_MAC.value
        path = "G:\マイドライブ\Docs\obsidian\lll"
        expected_path = ["G:","マイドライブ","Docs","obsidian","lll"]
        expected_mode = Mode.WIN_TO_MAC
        expected_output = "/Users/juryokun/Google\ Drive/マイドライブ/Docs/obsidian/lll"

        subprocess.run('pbcopy', input=path, text=True)
        converter = PathConverter(mode)
        converter.convert()

        self.assertEqual(expected_path, converter.get_parsed_path())
        self.assertEqual(expected_mode, converter.get_mode().mode)
        self.assertEqual(expected_output, converter.get_output())

    def test_win_to_mac2(self):
        mode = Mode.WIN_TO_MAC.value
        path = "G:\マイドライブ\Docs\obsidian(test)\lll"
        expected_path = ["G:","マイドライブ","Docs","obsidian(test)","lll"]
        expected_mode = Mode.WIN_TO_MAC
        expected_output = "/Users/juryokun/Google\ Drive/マイドライブ/Docs/obsidian\(test\)/lll"

        subprocess.run('pbcopy', input=path, text=True)
        converter = PathConverter(mode)
        converter.convert()

        self.assertEqual(expected_path, converter.get_parsed_path())
        self.assertEqual(expected_mode, converter.get_mode().mode)
        self.assertEqual(expected_output, converter.get_output())

    def test_mac_to_win1(self):
        mode = Mode.MAC_TO_WIN.value
        path = "/Users/juryokun/Google\ Drive/マイドライブ/Docs/obsidian/lll"
        expected_path = ["", "Users", "juryokun","Google\ Drive" ,"マイドライブ","Docs","obsidian","lll"]
        expected_mode = Mode.MAC_TO_WIN
        expected_output = "G:\マイドライブ\Docs\obsidian\lll"

        subprocess.run('pbcopy', input=path, text=True)
        converter = PathConverter(mode)
        converter.convert()

        self.assertEqual(expected_path, converter.get_parsed_path())
        self.assertEqual(expected_mode, converter.get_mode().mode)
        self.assertEqual(expected_output, converter.get_output())

    def test_mac_to_win2(self):
        mode = Mode.MAC_TO_WIN.value
        path = "/Users/juryokun/Google\ Drive/マイドライブ/Docs/obsidian\(test\)/lll"
        expected_path = ["", "Users", "juryokun","Google\ Drive" ,"マイドライブ","Docs","obsidian\(test\)","lll"]
        expected_mode = Mode.MAC_TO_WIN
        expected_output = "G:\マイドライブ\Docs\obsidian(test)\lll"

        subprocess.run('pbcopy', input=path, text=True)
        converter = PathConverter(mode)
        converter.convert()

        self.assertEqual(expected_path, converter.get_parsed_path())
        self.assertEqual(expected_mode, converter.get_mode().mode)
        self.assertEqual(expected_output, converter.get_output())

    def test_path_error(self):
        mode = Mode.MAC_TO_WIN.value
        subprocess.run('pbcopy', input="", text=True)
        with self.assertRaises(ValueError, msg="path_error"):
            converter = PathConverter(mode)

    def test_mode_error(self):
        mode = "3"
        subprocess.run('pbcopy', input="", text=True)
        with self.assertRaises(ValueError, msg="mode_error. mode: 4"):
            converter = PathConverter(mode)





def main():
    if len(sys.argv) > 1 and sys.argv[1] == "1":
        arg = "1"
    else:
        arg = "0"
    converter = PathConverter(arg)
    converter.convert()
    converter.output()

if __name__ == "__main__":
    try:
        # unittest.main()
        main()
    except Exception as err:
        ValueError(err)
