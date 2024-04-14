#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title convertDrivePath
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder", "optional": true }

from enum import Enum
import subprocess
import sys

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
            self.__mode = None
            #TODO: error
            print("mode_error")
        
        self.__input_path = subprocess.run('pbpaste', capture_output=True, text=True).stdout
        # self.__input_path = "/Users/juryokun/Google\ Drive/マイドライブ/Docs/obsidian\(test\)/lll"
        # self.__input_path = "G:\\マイドライブ\\Docs\\obsidian"

        if self.__input_path == "":
            #TODO: error
            print("path_error")

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



def main():
    arg = sys.argv[1]
    if arg == "":
        arg = "0"
    converter = PathConverter(arg)
    converter.convert()
    converter.output()

if __name__ == "__main__":
    main()
