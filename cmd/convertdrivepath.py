#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title convertDrivePath
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "path (省略時はクリップボードから取得)", "optional": true }

import os
import re
import subprocess
import sys
import unittest

# ---- Configuration ----
WIN_DRIVE = "G:"
# ----------------------


def find_mac_drive_bases():
    """Return candidate Google Drive base paths for the current user.

    Checks ~/Google Drive (symlink or directory) and all GoogleDrive-* entries
    under ~/Library/CloudStorage. Returns all that exist, symlink-style first.
    """
    home = os.path.expanduser("~")
    candidates = []

    # 1. Legacy / symlink path: ~/Google Drive
    symlink_path = os.path.join(home, "Google Drive")
    if os.path.exists(symlink_path):
        candidates.append(symlink_path)
        real_path = os.path.realpath(symlink_path)
        if real_path != symlink_path and os.path.exists(real_path):
            candidates.append(real_path)

    # 2. Google Drive for Desktop: ~/Library/CloudStorage/GoogleDrive-<email>/
    cloud_storage = os.path.join(home, "Library", "CloudStorage")
    if os.path.isdir(cloud_storage):
        for entry in sorted(os.listdir(cloud_storage)):
            if entry.startswith("GoogleDrive-"):
                real_path = os.path.join(cloud_storage, entry)
                if real_path not in candidates and os.path.exists(real_path):
                    candidates.append(real_path)

    return candidates


def get_primary_mac_drive_base():
    bases = find_mac_drive_bases()
    if bases:
        return bases[0]
    return os.path.join(os.path.expanduser("~"), "Google Drive")


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


def win_to_mac(path, mac_base=None):
    """G:\\foo\\bar  →  /Users/.../Google Drive/foo/bar"""
    if mac_base is None:
        mac_base = get_primary_mac_drive_base()
    path = path.replace("/", "\\")
    parts = path.split("\\")
    rel_parts = [p for p in parts[1:] if p]
    return mac_base + "/" + "/".join(rel_parts)


def mac_to_win(path, mac_bases=None):
    """/Users/.../Google Drive/foo/bar  →  G:\\foo\\bar"""
    path = unescape_shell_path(path)

    if mac_bases is None:
        mac_bases = find_mac_drive_bases()

    real_input = os.path.realpath(path)

    matched_base = None
    matched_path = None

    for base in mac_bases:
        if path.startswith(base + "/") or path == base:
            matched_base = base
            matched_path = path
            break
        real_base = os.path.realpath(base)
        if real_input.startswith(real_base + "/") or real_input == real_base:
            matched_base = real_base
            matched_path = real_input
            break

    if matched_base is None:
        bases_str = "\n".join(mac_bases) if mac_bases else "(なし)"
        raise ValueError(
            f"Google Driveのパスではありません。\n"
            f"期待されるベース:\n{bases_str}\n"
            f"入力: {path}"
        )

    rel_path = matched_path[len(matched_base):].lstrip("/")
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
            notify("Win→Mac 変換完了")
        elif path_type == "mac":
            result = mac_to_win(path)
            set_clipboard(result)
            notify("Mac→Win 変換完了")
        else:
            notify(f"不明なパス形式です: {path[:50]}")
    except ValueError as e:
        notify(str(e)[:200])


# ---- Tests ----

_SYMLINK_BASE = "/Users/testuser/Google Drive"
_REAL_BASE = "/Users/testuser/Library/CloudStorage/GoogleDrive-test@example.com"
_TEST_BASES = [_SYMLINK_BASE, _REAL_BASE]


class TestDetectPathType(unittest.TestCase):
    def test_windows_backslash(self):
        self.assertEqual("windows", detect_path_type("G:\\マイドライブ\\Docs"))

    def test_windows_slash(self):
        self.assertEqual("windows", detect_path_type("G:/マイドライブ/Docs"))

    def test_mac(self):
        self.assertEqual("mac", detect_path_type("/Users/someuser/Google Drive/マイドライブ"))

    def test_unknown(self):
        self.assertIsNone(detect_path_type("relative/path"))


class TestWinToMac(unittest.TestCase):
    def test_basic(self):
        path = "G:\\マイドライブ\\Docs\\obsidian\\lll"
        expected = f"{_SYMLINK_BASE}/マイドライブ/Docs/obsidian/lll"
        self.assertEqual(expected, win_to_mac(path, mac_base=_SYMLINK_BASE))

    def test_with_parens(self):
        path = "G:\\マイドライブ\\Docs\\obsidian(test)\\lll"
        expected = f"{_SYMLINK_BASE}/マイドライブ/Docs/obsidian(test)/lll"
        self.assertEqual(expected, win_to_mac(path, mac_base=_SYMLINK_BASE))

    def test_with_spaces(self):
        path = "G:\\マイドライブ\\My Folder\\file name.pdf"
        expected = f"{_SYMLINK_BASE}/マイドライブ/My Folder/file name.pdf"
        self.assertEqual(expected, win_to_mac(path, mac_base=_SYMLINK_BASE))

    def test_mixed_separators(self):
        path = "G:/マイドライブ/Docs/file"
        expected = f"{_SYMLINK_BASE}/マイドライブ/Docs/file"
        self.assertEqual(expected, win_to_mac(path, mac_base=_SYMLINK_BASE))

    def test_real_base(self):
        path = "G:\\マイドライブ\\Docs\\file.pdf"
        expected = f"{_REAL_BASE}/マイドライブ/Docs/file.pdf"
        self.assertEqual(expected, win_to_mac(path, mac_base=_REAL_BASE))


class TestMacToWin(unittest.TestCase):
    def test_basic_symlink_path(self):
        path = f"{_SYMLINK_BASE}/マイドライブ/Docs/obsidian/lll"
        expected = "G:\\マイドライブ\\Docs\\obsidian\\lll"
        self.assertEqual(expected, mac_to_win(path, mac_bases=_TEST_BASES))

    def test_basic_real_path(self):
        path = f"{_REAL_BASE}/マイドライブ/Docs/obsidian/lll"
        expected = "G:\\マイドライブ\\Docs\\obsidian\\lll"
        self.assertEqual(expected, mac_to_win(path, mac_bases=_TEST_BASES))

    def test_with_parens(self):
        path = f"{_SYMLINK_BASE}/マイドライブ/Docs/obsidian(test)/lll"
        expected = "G:\\マイドライブ\\Docs\\obsidian(test)\\lll"
        self.assertEqual(expected, mac_to_win(path, mac_bases=_TEST_BASES))

    def test_shell_escaped_symlink_path(self):
        path = "/Users/testuser/Google\\ Drive/マイドライブ/Docs/obsidian\\(test\\)/lll"
        expected = "G:\\マイドライブ\\Docs\\obsidian(test)\\lll"
        self.assertEqual(expected, mac_to_win(path, mac_bases=_TEST_BASES))

    def test_shell_escaped_spaces(self):
        path = "/Users/testuser/Google\\ Drive/マイドライブ/My\\ Folder/file\\ name.pdf"
        expected = "G:\\マイドライブ\\My Folder\\file name.pdf"
        self.assertEqual(expected, mac_to_win(path, mac_bases=_TEST_BASES))

    def test_wrong_base_raises(self):
        path = "/Users/testuser/Dropbox/file"
        with self.assertRaises(ValueError):
            mac_to_win(path, mac_bases=_TEST_BASES)


class TestRoundTrip(unittest.TestCase):
    def test_win_mac_win(self):
        original = "G:\\マイドライブ\\Docs\\folder (v2)\\file.pdf"
        mac = win_to_mac(original, mac_base=_SYMLINK_BASE)
        back = mac_to_win(mac, mac_bases=_TEST_BASES)
        self.assertEqual(original, back)

    def test_mac_win_mac(self):
        original = f"{_SYMLINK_BASE}/マイドライブ/Docs/folder (v2)/file.pdf"
        win = mac_to_win(original, mac_bases=_TEST_BASES)
        back = win_to_mac(win, mac_base=_SYMLINK_BASE)
        self.assertEqual(original, back)

    def test_real_path_round_trip(self):
        original = f"{_REAL_BASE}/マイドライブ/Docs/folder/file.pdf"
        win = mac_to_win(original, mac_bases=_TEST_BASES)
        back = win_to_mac(win, mac_base=_REAL_BASE)
        self.assertEqual(original, back)


if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "test":
        sys.argv.pop(1)
        unittest.main()
    else:
        main()
