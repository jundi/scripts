#!/bin/env python
# PYTHON_ARGCOMPLETE_OK
"""Replace remote url in git repository"""

import argparse

import argcomplete
import git


def main():
    """Main function"""
    parser = argparse.ArgumentParser("Replace remote urls in git repository"
                                     " if matching urls is found.")
    parser.add_argument('repository', nargs='+',
                        help="Path to repository")
    parser.add_argument('--source-prefix', required=True,
                        help='Prefix of old url')
    parser.add_argument('--source-suffix', default="",
                        help='Suffix of old url')
    parser.add_argument('--dest-prefix', required=True,
                        help='Prefix of new url')
    parser.add_argument('--dest-suffix', default=None,
                        help='Optional suffix added to new url. Old suffix is '
                             'copied by default. Use empty string to remove '
                             'the suffix.')
    parser.add_argument('--dry-run', action='store_true',
                        help='Do not write changes, only print what would'
                             ' happen.')

    argcomplete.autocomplete(parser)
    args = parser.parse_args()

    # Suffix is copied from old url, if new suffix if not defined
    if args.dest_suffix is None:
        args.dest_suffix = args.source_suffix

    for path in args.repository:

        try:
            repository = git.Repo(path)
        except git.InvalidGitRepositoryError:
            print(f"{path} is not valid git repository")
            continue

        for remote in repository.remotes:
            old_url = next(remote.urls)

            if old_url.startswith(args.source_prefix) \
                    and old_url.endswith(args.source_suffix):

                # Create new url
                base_url = old_url[
                    len(args.source_prefix):-len(args.source_suffix) or None
                ]
                new_url = f"{args.dest_prefix}{base_url}{args.dest_suffix}"

                # Set url
                if not args.dry_run:
                    remote.set_url(new_url)
                print(f"Url of {remote} in {path} was replaced:\n"
                      f"    {old_url} → {new_url}")

            else:
                print(f"Url of {remote} in {path} does not match: {old_url}")


if __name__ == "__main__":
    main()
