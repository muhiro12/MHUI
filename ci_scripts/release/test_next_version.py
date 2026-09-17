"""Regression coverage for published version selection."""

import unittest

from next_version import next_version, parse_version


class ReleaseVersionTests(unittest.TestCase):
    def test_legacy_history_moves_to_semver(self):
        self.assertEqual(next_version(["1.9", "1.18", "1.19"], []), "1.20.0")

    def test_numeric_order_and_patch_reset(self):
        self.assertEqual(next_version(["1.9.9", "1.20.12", "1.19"], []), "1.21.0")

    def test_major_is_preserved(self):
        self.assertEqual(next_version(["1.99.0", "2.0.4"], []), "2.1.0")

    def test_explicit_major_or_patch_tag_is_respected(self):
        for tag in ["2.0.0", "1.20.1"]:
            with self.subTest(tag=tag):
                self.assertEqual(next_version(["1.20.0", tag], [tag]), tag)

    def test_retry_reuses_existing_release(self):
        for tag in ["1.19", "1.20.0"]:
            with self.subTest(tag=tag):
                self.assertEqual(next_version([tag], [tag]), tag)

    def test_semver_spelling_wins_a_legacy_tie(self):
        self.assertEqual(next_version(["1.19", "1.19.0"], ["1.19", "1.19.0"]), "1.19.0")

    def test_non_release_tags_are_ignored(self):
        self.assertEqual(next_version(["1.19", "2.0.0-rc.1", "999", "v3.0.0"], []), "1.20.0")
        for tag in ["01.2.3", "1.02", "1.2.03", "1.2.3.4", "1.2.3+build"]:
            with self.subTest(tag=tag):
                self.assertIsNone(parse_version(tag))

    def test_initial_release(self):
        self.assertEqual(next_version([], []), "1.0.0")


if __name__ == "__main__":
    unittest.main()
