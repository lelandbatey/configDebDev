#!/usr/bin/python
"""Python file for the installation of dotfiles."""

from __future__ import print_function
from subprocess import call
import argparse
import os

ACTION_TYPE = "\n\n\t\
safe[default]\n\t\
xbase\n\t\
xfce\n\t\
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



def safe_configs():
    """Installs the "safe" configuration files.

    These files should be "safe" in that they won't stop an existing system
    from working. They are:

        .bashrc, .vimrc, .vim/, .dir_colors, .xmobarrc
    """

    call(["cp", ".bashrc", HOMEDIR])
    call(["cp", ".vimrc", HOMEDIR])
    call(["cp", ".dir_colors", HOMEDIR])
    call(["cp", ".xmobarrc", HOMEDIR])
    # For compatibility with OS X, use the capital R option with `cp` and don't
	# have a trailing slash in the name of the folder. On OS X, there is no
	# lowercase 'r' option, and the uppercase 'R' will only copy the contents
	# of a directory if it has a trailing slash. GNU `cp` maps `-r` and `-R`
	# as the same, so behavior there is unchanged.
    call(["cp", "-R", ".vim", HOMEDIR])
    call(["cp", ".gitignore_global", HOMEDIR])
    call(["cp", ".bash_profile", HOMEDIR])

def x_base_configs():
    """These are the basic files for configuring an X/Desktop environment.

    These files are not "safe" to install blindly, as they may make your
    Desktop environment cease to function. These files are:

        .xinitrc, .Xresources, .xmonad/xmonad.hi
    """

    call(["cp", "baseConfig/.xinitrc", HOMEDIR])
    call(["cp", "baseConfig/.Xresources", HOMEDIR])
    call(["cp", "baseConfig/xmonad/xmonad.hs", HOMEDIR+"/.xmonad/"])

def xfce_config():
    """These configuration files are for XFCE.

    They are:

        xfce/.xsessionrc, xfce/.xmonad/xmonad.hs, userContent.css
    """

    call(["cp", "xfce/.xsessionrc", HOMEDIR])
    call(["cp", "xfce/.xmonad/xmonad.hs", HOMEDIR+"/.xmonad/"])
    print("You're going to have to copy the 'userContent.css' file to the \
appropriate directory. It should be:\n\t\
~/.mozilla/firefox/<randomString.default>/chrome.\nIf the chrome directory\
 doesn't exist, just make one.")

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
    elif ARGS.act == "xbase":
        x_base_configs()
    elif ARGS.act == "xfce":
        xfce_config()
    elif ARGS.act == "prepvim":
        prepvim()
    elif ARGS.act == "bashmarks":
        install_bashmarks()
    else:
        errstr = "Specified action ('--act') \
was not of any of the necessary types:"+ACTION_TYPE
        print(errstr)

main()
