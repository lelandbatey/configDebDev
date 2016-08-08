#!/usr/bin/python
"""Python file for the installation of dotfiles."""

from __future__ import print_function
from subprocess import call
import datetime
import argparse
import os.path
import shutil
import os

ACTION_TYPE = "\n\n\t\
safe[default]\n\t\
bashmarks (requires 'prepvim' be run first)\n\t\
prepvim\n"

HOMEDIR = os.path.expanduser('~')

DESC = """Installation script for Leland Batey dotfiles repo. If this your \
first time running this on a new installation, run this command with the "--\
act prepvim" flag to properly prepare all the necessary  vim packages."""

PARSER = argparse.ArgumentParser(description=DESC)
PARSER.add_argument('--act', default='', help='Action to be taken;'+ACTION_TYPE)

# Access the results of arguments as stuff stored in 'ARGS'
ARGS = PARSER.parse_args()

ARCHIVE_DIR = os.path.join(HOMEDIR, "dotfiles_backup", datetime.datetime.now().strftime('%Y-%m-%d--%H.%M.%S'))

def install_component(*args):
    """Installs a 'component' within this repository into it's cooresponding
    location in the home directory of this current user. Does this by creating
    a symlink to the file in this repository."""
    repo_path = ""
    dest_path = ""

    if len(args) == 1:
        repo_path = args[0]
        dest_path = HOMEDIR
    elif len(args) == 2:
        repo_path = args[0]
        dest_path = args[1]
    else:
        print("Cannot understand arguments:", args)
        return

    dest_path = os.path.join(dest_path, repo_path)
    # Assumes that the current working directory is within the repository.
    repo_path = os.path.join(os.getcwd(), repo_path)

    if not os.path.lexists(repo_path):
        print("The repository path '{}' does not exist, ignoring component '{}'".format(repo_path, args))
        return

    # Check if there's already something that exists where we want to place the
    # link to the component. If it exists, move it to an archive directory for
    # safekeeping, but proceed with the install.
    if os.path.lexists(dest_path):
        if os.path.islink(dest_path):
            # Check if there's already a link to the repopath where there
            # should be for this component. If there is, then this install has
            # already happened, and we can move on.
            conflict_link_dest = os.path.realpath(dest_path)
            if conflict_link_dest == os.path.realpath(repo_path):
                print("'{}' is already installed, skipping".format(repo_path))
                return
        if not os.path.lexists(ARCHIVE_DIR):
            os.makedirs(ARCHIVE_DIR)
        print("Moving existing file/folder '{}' to the archive folder '{}'".format(dest_path, ARCHIVE_DIR))
        shutil.move(dest_path, ARCHIVE_DIR)

    # Create the symlink, thus installing the file
    os.symlink(repo_path, dest_path)
    print("Created symlink from target '{}' to '{}'".format(repo_path, dest_path))




def safe_configs():
    """Installs the "safe" configuration files.

    These files should be "safe" in that they won't stop an existing system
    from working. They are:

        .bashrc, .vimrc, .vim/, .dir_colors, .gitignore_global
    """
    install_component('.bashrc')
    install_component('.vimrc')
    install_component('.dir_colors')
    install_component('.vim')
    install_component('.gitignore_global')
    install_component('.bash_profile')

def prepvim():
    """Installs all the submodules. This is mostly for Vim."""
    call(["git", "submodule", "init"])
    call(["git", "submodule", "update"])
    call(["git", "submodule", "foreach", "git", "submodule", "init"])
    call(["git", "submodule", "foreach", "git", "submodule", "update"])
    print("All git submodules properly initialized and updated.")

def install_bashmarks():
    """Installs bashmarks. Requires you to have run "prepvim" prior to this
    which instantiates all git submodules."""

    call(["make", "-C", "bin/bashmarks/", "install"])


def main():
    """Routing logic for arguments."""

    if ARGS.act == "safe":
        safe_configs()
    elif ARGS.act == "prepvim":
        prepvim()
    elif ARGS.act == "bashmarks":
        install_bashmarks()
    else:
        errstr = "Specified action ('--act') \
was not of any of the necessary types:"+ACTION_TYPE
        print(errstr)

if __name__ == '__main__':
    main()
