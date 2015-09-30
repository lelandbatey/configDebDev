Configuration Files
===================

This is my unified set of configuration files that I use for my Ubuntu-based development environment (basically it's a dotfiles repo).

Further Explanation (as of September, 2013)
-------------------------------------------

### Original Approach

Originally, I was planning on doing most of my development in Linux environments running as guests under Windows. This allowed me to stay close to all that I know and love in Windows, while also letting me get work done in Linux. Because I was going to be running Linux under virtualbox, I opted to go for a maximally-minimalist approach towards use of resources. That meant that the "base" installation was an Ubuntu server install that I then put `X Server` on, followed by vanilla `xmonad`. This led to a very, very light installation, but it was not very featureful, for instance there was no sound or graphical ability to speak of.

### Updated aproach

I've now gotten to the point where I want to be dual-booting between Windows and Linux. This means my Linux install will have available to it all the power of my hardware, with the caveat that I'd have to manage a lot more software to get it all to work. So, instead of taking a minimalist install and building it up to a fully featured setup, I've decided to take a rather chunky install (vanilla Ubuntu) and pair it down till it does what I want. I'm not concerned with use of resources, since my computer is quite powerful, so having a more full featured OS won't take up to much of it's resources. However, this means I'm having to make some major changes to these dotfiles, and how I manage the different Linux environments.

### Basic structure:

The basic layout of the dotfiles repo is as follows: there are a bunch of files that are pretty much environment-agnostic. These files include `.bashrc`, `.vimrc`, and the `.vim/` folder. This stuff goes in the root of the repo.

Next up are the things that *are* liable to cause some problems if just blindly copied into your home folder. These are things like the `.xinitrc`, the `.Xresources`, the `.xmonad/xmonad.hs`. These are meant to be installed as part of my original "base" setup (a server environment with a minimal gui). Because they're intended to stand on their own, they're in the `baseConfig` folder.

The other directories are named for their uses, for example `xfceConfig` holds all the files that are particular to using xfce(/xmonad).

Additionally, I'll be editing the installation script to accommodate and allow for different types of installations.

Prerequisites
-------------

	1. For use with Xmonad and xmobar
	2. Assumes that Xmonad and xmobar are already installed.
	3. Xmobar has to be installed via Cabal, and located in the ~/.cabal/bin directory

This is pretty much it. Simply run the "installConfig.sh" script to install. Be aware, this will copy over all existing files without double checking.

<sup>The idea for this, as well as some parts of some configuration files, is taken from the awesome work by Lane Aasen (https://github.com/aaasen/config). I have attempted to give proper attribution for all specific borrowed configurations.</sup>

<sup><sup>All original parts of this project are licensed under the GPLv3. All work done by others is under their own respective licenses.</sup></sup>
