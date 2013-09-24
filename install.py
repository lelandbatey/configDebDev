#!/usr/bin/python
from __future__ import print_function
from subprocess import call
import argparse
import os

actType = "\n\n\t\
safe[default]\n\t\
xbase\n\t\
xfce\n\t\
bashmarks (requires 'prepvim' be run first)\n\t\
prepvim\n"

HOMEDIR = os.path.expanduser('~')
# print(HOMEDIR)


parser = argparse.ArgumentParser(description='Installation script for Leland Batey dotfiles repo. If this your first time running this on a new installation, run this command with the "--act prepvim" flag to properly prepare all the necessary  vim packages.')
parser.add_argument('--act', default='', 
    help='Action to be taken;'+actType)

# Access the results of arguments as stuff stored in 'args'
args = parser.parse_args()



def safeConfigs():
    # .bashrc, .vimrc, .vim/, .dir_colors, .xmobarrc
    call(["cp",".bashrc", HOMEDIR])
    call(["cp",".vimrc", HOMEDIR])
    call(["cp",".dir_colors", HOMEDIR])
    call(["cp",".xmobarrc", HOMEDIR])
    call(["cp","-r",".vim/", HOMEDIR])
    call(["cp",".gitignore_global", HOMEDIR])
    call(["cp",".bash_profile", HOMEDIR])

def xbaseConfigs():
    # .xinitrc, .Xresources, .xmonad/xmonad.hi
    call(["cp","baseConfig/.xinitrc", HOMEDIR])
    call(["cp","baseConfig/.Xresources", HOMEDIR])
    call(["cp","baseConfig/xmonad/xmonad.hs", HOMEDIR+"/.xmonad/"])

def xfceConfigs():
    # xfce/.xsessionrc, xfce/.xmonad/xmonad.hs, userContent.css
    call(["cp","xfce/.xsessionrc", HOMEDIR])
    call(["cp","xfce/.xmonad/xmonad.hs", HOMEDIR+"/.xmonad/"])
    print("You're going to have to copy the 'userContent.css' file to the \
appropriate directory. It should be:\n\t\
~/.mozilla/firefox/<randomString.default>/chrome.\nIf the chrome directory\
 doesn't exist, just make one.")
    
def prepvim():
    call(["git","submodule", "init"])
    call(["git","submodule", "update"])
    call(["git","submodule", "foreach", "git", "submodule", "init"])
    call(["git","submodule", "foreach", "git", "submodule", "update"])
    print("All git submodules properly initialized and updated.")
    
def bashMarks():
    # Installs bashmarks. Requires you to have run "prepvim" prior to this which instantiates all git submodules.
    call(["make","-C","bin/bashmarks/","install"])


def main():

    if args.act == "safe":
        safeConfigs()
    elif args.act == "xbase":
        xbaseConfigs()
    elif args.act == "xfce":
        xfceConfigs()
    elif args.act == "prepvim":
        prepvim()
    elif args.act == "bashmarks":
        bashMarks()
    else:
        print("Specified action ('--act') was not of any of the necessary types:"+actType)

main()
