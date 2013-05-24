        __  __     __         _______ __         
       / / / /__  / /___     / ____(_) /__  _____
      / /_/ / _ \/ / __ \   / /_  / / / _ \/ ___/
     / __  /  __/ / /_/ /  / __/ / / /  __(__  ) 
    /_/ /_/\___/_/ .___/  /_/   /_/_/\___/____/  
                /_/                              

Author: Leland Batey

This help file is going to be primarilly written using markdown as an organizational tool. It won't be rendered markdown, but since markdown is a nice and human readable format, it makes this easier.


### How to reconnect to an interupted screen session. Useful for when a terminal quits on you. ####
	- use "screen -D" to force a disconnect, then reconnect normally (using "screen -r")

### Alternate way to add network interfaces for Ubuntu ####
There is some kind of bug in Ubuntu, you can't add interfaces very well. To add and interface, use this command:

	sudo ifconfig eth0:0 199.21.222.23 netmask 255.255.255.240 up

substitute different values as needed, but that is the basic way it should go.

### Connecting to the RaspberyPi with RaspBMC installed ####
Connection details:

	username : pi
	password : raspberry

Use "nmap -sP '192.168.2.*'" to find it in the group of IP's.
Even better, use "nmap 192.168.2.1-254" to scan all ports on all ip addresses.

### Installing Easy_Install with Python3 on Ubuntu ####
Run `"sudo apt-get install python3-setuptools"`
From there, you can install Pip with:

	"python3 -m easy_install pip"

### Installing Xmobar with DWM on Ubuntu Server ####
Installing Xmobar normally seems to fail with the error: 

	checking for X11/extensions/Xinerama.h... yes
	checking X11/extensions/Xrandr.h usability... no
	checking X11/extensions/Xrandr.h presence... no
	checking for X11/extensions/Xrandr.h... no
	configure: error: X11/extensions/Xrandr.h (from libXrandr) is required
	cabal: Error: some packages failed to install:
	X11-1.6.0.2 failed during the configure step. The exception was:
	ExitFailure 1
	xmobar-0.15 depends on X11-1.6.0.2 which failed to install.

The problem is that there aren't certain Xrandr development files installed. To resolve this, run:

	"sudo apt-get install libxrandr-dev"

This will install the appropriate files for Xmobar to be installed.

### Using Irssi Linux IRC Client ####
Irssi operates in a way similar to screen/xmonad in that it creates many virtual "windows" to manage things. Additionally, the switching of windows is done using a "modkey" (is generally ALT, although the ESC key will also always work).

> A great guide on using IRSSI can be found at http://carina.org.uk/screenirssi.shtml
The following is a list of commands and tips for using IRSSI:

- To join a channel, use the command "/j #&lt;channelname&gt;" (the # is important!)
- The modkey is either the ALT key or the ESC key. I use ESC because ALT is used for Xmonad.
- To switch between windows, press the modkey and the number of the window you want to switch to.
- To list all the users in a channel, type "/names" or the shorthand, "/n"

### Using SSH with Authorization Keys ####
To make use of authorization keys, the basics are that you need to append your rsa/dsa public key to the "authorized_keys" file on the machine you want to connect to. When you connect, the server creates a problem using your public key, that only the private key will solve. You recieve this data, solve it with your private key, and you send it back to the server. Then, the server knows you are who you say you are, and lets you connect. (This is pretty much taken straight out of the Arch Wiki https://wiki.archlinux.org/index.php/SSH_Keys#Background)

The following is the basics on using ssh keys with a server.

1. On the host machine (the desktop) create an rsa/dsa pair.
2. Log into the remote machine (server) and append the rsa/dsa .PUB (!!!) to the end of the "authorized_keys" file on the server.
3. At this point, you may have to run the command "exec ssh-agent /bin/bash" on the host (desktop) machine to get the ssh service working correctly.
4. Now connect to the server with "ssh &lt;hostname here&gt;"
5. If you need to connect with a user other than the one on the host machine, use "ssh -l &lt;remote machine username&gt; &lt;remote hostname here&gt;"

It is important to note that on the client machine, the name of the public/private key pair needs to be "rsa/dsa_id(.pub)" to work by default. Otherwise, you have to specify if something is using an alternateley named key pair.

### Using "Sets" in Python ####
In Python, a "set" is nearly exactly like a list, however it is not ordered. That means that referencing anything via placement (i.e. myList[0]) will not work. However, checking the membership of an item in a set is much much faster than checking the membership of an item in a list. For this reason, it is worthwhile to convert large lists to sets before checking for membership in one of those lists/sets.

> (I should note that I ran across this tip while working on my TorrentTxt project. The web page that started this all is: http://stackoverflow.com/questions/10005367/python-set-difference )

### Using Virtual Environments (virtualenv) in Python ####
So virtualenvs seem pretty awesome. However, something to note is that they cannot be moved. That means that if they move at all, they break. So if you rename a parent directory, then they're broken. Something to be aware of.

### Stopping Access/Hotlinking Using .Htaccess by Checking the Referer ####
To restrict access according to a websites referer, this is how the .htaccess needs to look like this:

    RewriteEngine On
    RewriteCond %{HTTP_REFERER} !^http://(.+\.)?allowedSite\.com/ [NC]
    RewriteCond %{HTTP_REFERER} !^$
    RewriteRule .* - [F]

Mod_rewrite works by comparing the incoming referer against the specified (regular expression) rules for referers. If all of the (regular expression) rules return True, then it acts out the "RewriteRule". For example:

	RewriteCond %{HTTP_REFERER} !^http://(.+\.)?allowedSite\.com/ [NC]

>> Returns TRUE if the referer does not come from "allowedSite.com"
	
	RewriteCond %{HTTP_REFERER} !^$

>> Returns TRUE if the referer is not blank (null).

It then applies the rule, which in this case is to deny access.

### Deleting Old Kernels from a Full /boot partition ####
I have found that on my Ubuntu servers I frequently run out of space on my /boot partition. Normally you'd empty that out by using the "sudo apt-get autoremove" command, but it will fail because that partition is full and that partition is used as a temporary extraction point by apt-get. Here are the steps involved:
> Use the command "dpkg -l | grep linux-image" to show a list of all installed linux kernels
> Use "uname -r" to show the current kernel
> Now you can remove and old kernels with the command "sudo apt-get purge linux-image-&lt;kernel number here&gt;"
>> I recommend only getting rid of old kernels and only just enough to allow you to run "sudo apt-get autoremove"

#### Using Bootstrap Javascript and Jquery ####
I had gone into this trying to set up a simple dropdown for the frontpage of adrenl.in. However, I could not for the life of me figure out why the bootstrap javascript wasn't working. After tons of trial and error, this is what I eventually learned:

    1. Placement of javascript "&lt;script&gt;" notifications matters. These will not work if called in the "head", they must be called in the "body" of the page.
    2. The *order* of the javascript files matters. In my case, bootstrap requires jquery to already be loaded, so jquery must come BEFORE bootstrap.

Once I'd done both of those, everything worked great!

### Converting video's to animated GIF's ###
So, converting a video to an animated gif is semi-easy, but mostly not. Here's how it goes:

Make sure you have the following tools install:
    
    ffmpeg
    gifsicle

Both of which can be gotten via "sudo apt-get install &lt;name&gt;".

Now for the fun part! For whatever reason, the built in video -> .gif convertion function of ffmpeg is super garbage. So, instead we do things a little bit better:

    First, we split apart every single frame of the video into it's own gif frame, with an appropriate file name to put it in the correct order.
    Second, we use gifsicle to combine all these .gif frames into a single animated gif.

Here's the command to split up the video into the gif frames:
    
    ffmpeg -i file_to_be_input.mp4 out%04d.gif

Note the weird name specified for the output gif. For whatever reason, this seems to be important. It apparently makes sure each frame has the correct/appropriate number.

Alright, now you've got this big long list of individual frames, but no animated gif :( NEVER FEAR, all shall be well. To combine them into a single animated gif, this is the command:

    gifsicle --delay=4 --loop *.gif > anim.gif

This will combine every ".gif" file in the current working directory into a single animated gif, in the order of the file name (lowest is first frame, highest is last frame).

Also note the `--delay=4` option. What this option is doing is specifying the delay in miliseconds between frames. I found that for a ~25 fps video, which most video is, this will produce a reasonably "normal speed" gif.

For further gif awesomeness, you can shrink the size of your gif using the `imagemagick` software package (also installable via apt-get). The command to remember is:

    convert -layers Optimize input.gif output_optimized.gif

And that's all. I was able to shrink a gif from 8mb to 2.1mb by doing this.

### Converting Video to .gif (Continued) ###
So, after fidling with that a bunch more, I found out some interesting things:

The first is that you don't need gifsicle at all. Imagemagick is able to do all of the necessary operations (and seems to be able to do them better!). To combine the composite frames into a .gif, use the following:

    convert -delay 4 out*.gif anim.gif

However, this is actually not the only improvement. After messing around with this some more, I found a way to produce even higher quality (yet larger) .gifs. The only different step is instead of telling ffmpeg to export the frames as .gif's, have it export them as .png's. This lets Imagemagick handle the conversion to .gif, and it does a much better job of making the .gif look nice. The only thing is that it produces much larger .gif's. Here is a comparison:

[.gif converted via ffmpeg](http://i.imgur.com/DWc4OdD.gif)

[.gif converted via imagemagick](http://i.imgur.com/OdojPSo.gif)

Notice that while the imagemagick .gif looks better, the one created by ffmpeg is **half as big.** This may be relevant info if you're trying to upload a file to say, imgur, which has a 5mb limit on .gifs.

To actually do this, switch your ffmpeg line from this:

    ffmpeg -i $1 out%04d.gif

to this:

    ffmpeg -i $1 out%04d.png

Now FFMPEG will output high quality .png's as the individual frames. Then, you'll also have to change the imagemagick line to this:

    convert -delay 4 out*.png anim.gif

In the end, this is what the whole script looks like:

    #!/bin/bash
    
    # NOTE: the "$1" in the line below this means "command line argument #1 is inserted here". If you're running these manually, replace the $1 with the name of your video file.
    ffmpeg -i $1 out%04d.png # Extracts each frame of the video as a single gif
    convert -delay 4 out*.png anim.gif # Combines all the frames into one very nicely animated gif.
    convert -layers Optimize anim.gif optimized_output.gif # Optimizes the gif using imagemagick
     
    # vvvvv Cleans up the leftovers
    rm out*
    rm anim.gif

And that's how you convert a video to a .gif file!

### Further Details on Converting Video to .GIF ###

So, after *EVEN MOAR* messing around with .gifs and videos, I have found a nice and easy way to also do reverse .gifs! This script needs to be run between the `ffmpeg` step and the `convert` step:

    image=( out*.png )
    MAX=${#image[*]}
    echo $MAX
    for i in ${image[*]}
    do
        num=${i:5:3} # grab the digits
        compliment=$(printf '%04d' $(echo 2*$MAX-$num+1 | bc))
        echo $num $i $compliment
        ln $i out$compliment.png
    done

Btw, [this is where I found this script](http://stackoverflow.com/questions/7136222/bash-script-to-copy-numbered-files-in-reverse-order) though I've done a lot of adapting it to my needs.

#### Anyway, here's an explanation of what the above is doing:

Here's an abstract look at what it acomplishes.

    For a set of files named `out*.png` it counts how many there are, then copys them in reverse order, renaming them sequentially, continuing with the numbering of the existing photos.

    So, if we had 5 frames named like so:

        out0001.png
        out0002.png
        out0003.png
        out0004.png
        out0005.png

    Then it would create the following:

        out0001.png
        out0002.png
        out0003.png
        out0004.png
        out0005.png out0006.png <- Is actually a renamed out0005.png out0007.png <- renamed out0004.png out0008.png <- renamed out0003.png out0009.png <- etc out0010.png What this does is make the .gif go forwards, then backwards (then it loops, continuing to go backwards then forwards). So you get a nice smooth effect. Sometimes it's nice!  

### Resize .gif while making this conversion

You can also resize the gif that you create automatically. Like so:

    convert -delay 4 out*.png -resize %50 anim.gif

This'll resize it to %50 of it's previous size, maintaining the aspect ratio.

### List Fonts in Ubuntu

If you want to list fonts in Ubuntu, use the command `fc-list` which will list all the fonts on your system. Then use `grep` to check for certain versions.

### Xmonad, Xresources, and Fonts

Xresources can be an absolute pain (they were for me). So, this a bit of help:

> First of all, the way that fonts are generally handled in Xmonad is through `XFT`. Xft is the [X FreeType Interface library](http://en.wikipedia.org/wiki/Xft) and is a library that handles the actual rendering of fonts in Xmonad/urxvt (Xresources specifies a bunch of resources to things that launch under the X window manager. Settings for individual programs are specified in Xresources like so: `Urxvt.background:{background settins here}`).

> Anyway, fonts are set using this syntax in `Xresources`:

    urxvt*font:xft:{your font name goes here}:size={the size of the font goes here},xft:{fall-back font #1 goes here}

> So, thats the most basic part of fonts in urxvt specified via Xresources.

### Fixing ~/.ssh/ Permissions in Cygwin

In Cygwin on Windows I found that I could not set the permissions of my `~/.ssh/ folder` to be 0600, as is required for ssh to allow you to use keys. The symptom I had was that I no matter what I did, it always modfied the owner **and** the group permissions for a file and folder. So if I entered `chmod 0600 id_rsa` it would instead set the permissions of `id_rsa` to 0660 instead of 0600 (this is bad because it gives the owner of the file **and** anyone in the same group as the owner read access to this key file. Which means anyone who's in the same group as the owner could use it to log into a remote system).

After much Googling, I found that the problem was the setting of a `None` group as the group for all files in Cygwin. For whatever reason, since all files where part of the `None` group their owner and group permissions where linked. The fix was to assign a group to the files. I did it like so:

    chgrp Users *

This added all the files in the current folder to the user-group called "`Users`". From there, I was able to set the permissions normally.

### Jquery Parameters - Odd Behaviour Explained

Something that I noticed in the Jquery documentation was that there were odd inconsistencies with the parameters being passed to various functions. For example, according to the Jquery documentation, the method `$.getJSON` takes these arguments: `jQuery.getJSON( url [, data ] [, success(data, textStatus, jqXHR) ] )`

That seems to make plenty of sense; it requires the URL to get the JSON from, any additional data that needs to be sent along with that request, and an anonymous function that will happen when/if fetching the data is successful. However, in the documentation they give this example:

    $.getJSON('ajax/test.json', function(data) {
        var items = [];
             
        $.each(data, function(key, val) {
            items.push('<li id="' + key + '">' + val + '</li>');
        });
                      
        $('<ul/>', {
            'class': 'my-new-list',
            html: items.join('')
        }).appendTo('body');
    });

What I noticed about this was that the documentation seems to skip an extremely important step here: **it includes the first argument, skips the second, and then includes the third!** How is that possible? How can you omit an argument in the middle of your list of arguments? Doesn't that break everything after it?

The answer is: no, that's valid in Jquery. I searched for quite a while, and [I did eventually find an explanation.](http://stackoverflow.com/a/6865331) It turns out that Jquery basically uses logic to figure out what you intend to do. I'll pick on `$.getJSON` as an example:

> `$.getJSON` has 3 different variables, and most importantly, *each variable is of a differnt type.* What this means is that if you only pass two variables (a string and a function) then Jquery can match up the variables based on type. It's a pretty smart system.

### Gemfiles, RVM, and Ruby

Alright, the following is a rant that I wrote in my .bash_profile, after just trying to **install** RVM:
    
    ### RVM Startup! ###
    # By default RVM puts this next line into the .bash_profile line. However, 
    # this is a STUPID IDEA because .bash_profile is only exectuted for "login"
    # shells. By default, most shells opened once you've actually logged in are
    # NOT login shells. So URXVT, Gnome Terminal, etc are all non-login shells 
    # by default. However, they are interactive shells, which should be the
    # distinction. But, because the Ruby community seems to only ever do
    # anything on OS X and they don't care at all about how stuff works, they
    # plopped this down in .bash_profile and said that the way to fix this is
    # to change your terminal emulator to log in as a login shell.
    # Which is just INCREDIBLY stupid. They need to get their crap together.
    # Douchebags.

Ok, so while that may have been a little bit heavy handed, it's something that I find really frequently *every single time* I have to use something involving Ruby. It seems like the VAST majority of their tools are pretty low quality, or very bad implentations of tools used by other languages.

The RVM example is just one. Another thing that is quite annoying: RVM seems like it's trying to be virtualenv, but sucks at it. With virtualenv, you have a single directory that acts as it's own self contained instance of python. It has lots of standard tools that make using it really easy (like pip, which is *rock solid*) and it's location gives it context for what it's doing. For instance, in `~/projects` you might have a virtualenv that you use for development (or several). You may have another in `~/scraps` that you install stuff into willy-nilly for experimentation purposes. However, it integrates with existing tools and makes design choices that make lots of sense (like location as context).

RVM though does no such thing. Everything goes in one place, your `rvm` folder which could be in one of many locations (though frequently it's in `~/.rvm`). From there, you must choose which version of Ruby to use. Once you've done so, you pick which "gemset" to use. The gemset is at the heart the virtualenv: what's in that is what actually matters. By default you're in the `default` gemset and if you install anything while "in" this gemset then it is added to the gemset.Something quite bothersome with this is that `rvm` doesn't do anything to give you feedback about what's going on at any given time. Virtualenv does this right by adding a `(virtualenv name here)` string to the beginning of the shell prompt, so you always know if you're in a virtual environment and which one you're in. That's really helpful, and it'd be great if `rvm` did the same.

Alright, ranting over. I have a feeling in about two weeks I'm going to look back at myself and say how stupid this is. Oh well :)

#### Bash Color Characters / Escape Sequences

In messing with Ruby and RVM, I found that I wanted to use a more modified terminal prompt. I wanted color, and most of what I actually write to be on a new line. This is what I originally created:

    export PS1='\e[0;36m${debian_chroot:+($debian_chroot)}\u@\e[0;35m\h:\e[0;32m\n\w\e[0m $ '

Which on first glance does seem to work. However, if you are typing in the Terminal and you hit the edge of the screen, instead of wrapping around to the next line on the terminal, it would instead jump back to the beginning of the current line and start to over-write it. All your commands would be still be typed as you originally wrote them, but you couldn't read things.

After some searching I learned that I'd made a classic newbie mistake: you need to wrap all escaped color codes in "escaped square-braces", nameley `\[` and `\]`. So now it looks like this:

    export PS1='\[\e[0;36m\]${debian_chroot:+($debian_chroot)}\u@\[\e[0;35m\]\h:\[\e[0;32m\]\n\w\[\e[0m\] $ '

Problem solved!

### Finding files in *Nix

I figured I'd finally take the time to actually write down some of the great commands I've found that you can use to find and manipulate files en-mass!

    find . -type d -name "*venv*" -prune -o -type f -name "*.py" -exec cat {} \; >> combinedworks.txt

> *Short primer on **find**:* The structure of the parameters passed into find is awfully odd. Here's what it looks like:

> 1. `find .` this is setting up the find command and telling it to search in the current directory.
> 2. `-type d -name "*venv*" -prune` a conditional specifying that if there is a *directory* (the `-type d`) with the name "venv" anywhere inside it, then that directory is the be "pruned", or removed from the search criteria.
> 3. `-o -type f -name "*.py" -exec cat {} \; >> combinedworks.txt` another conditional. The `-o` is an `or` comparison. The `-type f -name "*.py"` says "if the thing you find is of the type `file` (as opposed to, say, a directory) and it's name ends in `.py`", while `-exec cat {} \; >> combinedworks.txt` is the instruction saying what to do if the prior if statement is true.

> So, given all that, I'll write out the pseudo code for the logic happening in this `find` command:

    if ( the thing that we are looking at directory with the word "venv" in it ) then:
        prune that directory from the list of things to search and don't search there
    else if ( the thing that we are looking at is a file that ends in ".py") then:
        use the command "cat" to concatenate that file onto the end of "combinedworks.txt"

So that's that explanation. Here's another command I found really useful:

    find . -path ./Lumen\ Gaming -prune -o -path ./conflict -prune -o -name '*_conflict-*' -print -exec mv {} ./conflict/ \;

> I'll just write out the pseudo code for this:

    if (the_thing_we're_looking_at == the path "./Lumen\ Gaming") then:
        prune that from the searchable area
    else if (the_thing_we're_looking_at == the path "./conflict") then:
        prune that from the searchable area
    else if (the_thing_we're_looking_at has the name "_conflict-" anywhere in it) then:
        print the name of that file
        use the move command to move it to the directory called "./conflict"

That's all for my favorite find commands right now. I'll add more later if need be.

### Dealing with programs that don't play well with \*nix pipes

I found that there are actually a pretty decent amount of programs that don't really play well with traditional Unix pipes. In fact, that reason is why I ended up having to create Veiled, which uses pseudo-terminals to totally get in front of the input/output of various programs and control them, even if they don't want to play nice.

However, what if you just need to script somthing? For example, I found that the first time the `hldsupdate` program is run on *nix is doesn't play well and will send a force close *directly* to it's controlling terminal, circumventing any terminals. This is the way I found to get around this:

    ./yourProgram || true

This puts a logical or there, and is the equivenlent of saying `some_thing_which_is_always_false OR true` and thus it will always be able to continue. Huzzah!


### Various things to remember about Vim (and all of your plugins for it)

*Vanilla Vim Stuff:*

> `F - <some character>`: Will jump the the next-previous instance of the entered character on the line you are on.

> Split Windows:

>> Vertical split: `Ctrl-w-v`

>> Horizontal split: `Ctrl-w-s`

>> Close current window: `Ctrl-w-q`

#### Vim, Buffers, and Windows: What?

I'll attempt here to record how buffers and windows work in Vim, hopefully outlining the correct "mental model" for how this operates.

> *Note: when I say "windows" in this next description, I'm NOT talking about windows as used by the operating system. Instead I'm refering to the internal "windows" used by the given text editor.*

First off, windows: unlike in many other editors, windows in Vim are a bit lower on the organizational tree than usual. I'll use Sublime Text 2 as an example for how other editors operate; in ST2, a window acts as an organizational distinguisher. In the heirarchy of organization, you've got the window, then the tab, then the actual veiwing area for that tab.

However, in Vim, the window is purely a veiwing area. Nothing is organized within it. All it does is provide an interface to edit and manipulate one buffer.

Having said that, the next logical topic is: buffers. In Vim, buffers are just that: they are buffers that contain a file. It's a copy of a given file in memory that you can edit using Vim.

*Pydoc plugin:*

> This plugin will look up the built in documentation for various python modules. By built in, I mean that it can only access documentation that has been installed into the `man pages` of a system. Generally, that rather centralized storage of info can only be added to by a very structured installer like pip, apt-get, etc. So use this for big important stuff, but not for your own work.


