#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title convertDrivePath
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "path (省略時はクリップボードから取得)", "optional": true }

import re
import subprocess
import sys
import unittest

# ---- Configuration ----
WIN_DRIVE = "G:"
MAC_DRIVE_BASE = "/Users/juryokun/Google Drive"
# Newer Google Drive for Desktop path (uncomment if migrated):
# MAC_DRIVE_BASE = "/Users/juryokun/Library/CloudStorage/GoogleDrive-<your-gmail>"
# ----------------------


def get_clipboard():
    return subprocess.run("pbpaste", capture_output=True, text=True).stdout.strip()


def set_clipboard(text):
    subprocess.run("pbcopy", input=text, text=True)


def notify(message):
    script = f'display notification "{message}" with title "convertDrivePath"'
    subprocess.run(["osascript", "-e", script])


def unescape_shell_path(path):
    """Remove shell escaping (e.g. Google\\ Drive → Google Drive, \\( → ()."""
    return re.sub(r"\\(.)", r"\1", path)


def detect_path_type(path):
    """Return 'windows', 'mac', or None."""
    if re.match(r"^[A-Za-z]:[\\\/]", path):
        return "windows"
    if path.startswith("/"):
        return "mac"
    return None


def win_to_mac(path):
    """G:\\foo\\bar  →  /Users/.../Google Drive/foo/bar"""
    # Normalize mixed separators
    path = path.replace("/", "\\")
    parts = path.split("\\")
    # parts[0] = drive letter (G:), parts[1:] = actual segments
    rel_parts = [p for p in parts[1:] if p]
    return MAC_DRIVE_BASE + "/" + "/".join(rel_parts)


def mac_to_win(path):
    """/Users/.../Google Drive/foo/bar  →  G:\\foo\\bar"""
    # Normalize shell-escaped input first
    path = unescape_shell_path(path)

    if not path.startswith(MAC_DRIVE_BASE):
        raise ValueError(
            f"Google Driveのパスではありません。\n"
            f"期待されるベース: {MAC_DRIVE_BASE}\n"
            f"入力: {path}"
        )

    rel_path = path[len(MAC_DRIVE_BASE):].lstrip("/")
    parts = [p for p in rel_path.split("/") if p]
    return WIN_DRIVE + "\\" + "\\".join(parts)


def main():
    if len(sys.argv) > 1 and sys.argv[1]:
        path = sys.argv[1].strip()
    else:
        path = get_clipboard()

    if not path:
        notify("パスが指定されていません（引数またはクリップボードから取得）")
        return

    path_type = detect_path_type(path)

    try:
        if path_type == "windows":
            result = win_to_mac(path)
            set_clipboard(result)
            notify(f"Win→Mac 変換完了")
        elif path_type == "mac":
            result = mac_to_win(path)
            set_clipboard(result)
            notify(f"Mac→Win 変換完了")
        else:
            notify(f"不明なパス形式です: {path[:50]}")
    except ValueError as e:
        notify(str(e)[:200])


# ---- Tests ----

class TestDetectPathType(unittest.TestCase):
    def test_windows_backslash(self):
        self.assertEqual("windows", detect_path_type("G:\\マイドライブ\\Docs"))

    def test_windows_slash(self):
        self.assertEqual("windows", detect_path_type("G:/マイドライブ/Docs"))

    def test_mac(self):
        self.assertEqual("mac", detect_path_type("/Users/juryokun/Google Drive/マイドライブ"))

    def test_unknown(self):
        self.assertIsNone(detect_path_type("relative/path"))


class TestWinToMac(unittest.TestCase):
    def test_basic(self):
        path = "G:\\マイドライブ\\Docs\\obsidian\\lll"
        expected = "/Users/juryokun/Google Drive/マイドライブ/Docs/obsidian/lll"
        self.assertEqual(expected, win_to_mac(path))

    def test_with_parens(self):
        path = "G:\\マイドライブ\\Docs\\obsidian(test)\\lll"
        expected = "/Users/juryokun/Google Drive/マイドライブ/Docs/obsidian(test)/lll"
        self.assertEqual(expected, win_to_mac(path))

    def test_with_spaces(self):
        path = "G:\\マイドライブ\\My Folder\\file name.pdf"
        expected = "/Users/juryokun/Google Drive/マイドライブ/My Folder/file name.pdf"
        self.assertEqual(expected, win_to_mac(path))

    def test_mixed_separators(self):
        path = "G:/マイドライブ/Docs/file"
        expected = "/Users/juryokun/Google Drive/マイドライブ/Docs/file"
        self.assertEqual(expected, win_to_mac(path))


class TestMacToWin(unittest.TestCase):
    def test_basic(self):
        path = "/Users/juryokun/Google Drive/マイドライブ/Docs/obsidian/lll"
        expected = "G:\\マイドライブ\\Docs\\obsidian\\lll"
        self.assertEqual(expected, mac_to_win(path))

    def test_with_parens(self):
        path = "/Users/juryokun/Google Drive/マイドライブ/Docs/obsidian(test)/lll"
        expected = "G:\\マイドライブ\\Docs\\obsidian(test)\\lll"
        self.assertEqual(expected, mac_to_win(path))

    def test_shell_escaped_input(self):
        # Shell-escaped path (copied from terminal)
        path = "/Users/juryokun/Google\\ Drive/マイドライブ/Docs/obsidian\\(test\\)/lll"
        expected = "G:\\マイドライブ\\Docs\\obsidian(test)\\lll"
        self.assertEqual(expected, mac_to_win(path))

    def test_shell_escaped_spaces(self):
        path = "/Users/juryokun/Google\\ Drive/マイドライブ/My\\ Folder/file\\ name.pdf"
        expected = "G:\\マイドライブ\\My Folder\\file name.pdf"
        self.assertEqual(expected, mac_to_win(path))

    def test_wrong_base_raises(self):
        path = "/Users/juryokun/Dropbox/file"
        with self.assertRaises(ValueError):
            mac_to_win(path)


class TestRoundTrip(unittest.TestCase):
    def test_win_mac_win(self):
        original = "G:\\マイドライブ\\Docs\\folder (v2)\\file.pdf"
        mac = win_to_mac(original)
        back = mac_to_win(mac)
        self.assertEqual(original, back)

    def test_mac_win_mac(self):
        original = "/Users/juryokun/Google Drive/マイドライブ/Docs/folder (v2)/file.pdf"
        win = mac_to_win(original)
        back = win_to_mac(win)
        self.assertEqual(original, back)


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "test":
        sys.argv.pop(1)
        unittest.main()
    else:
        main()
