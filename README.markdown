Collection of Jamie Wong's dotfiles (mostly vim stuff)

You'll need git to get some of this stuff working nicely.

Usage
-----

To install this, clone the repo then run `make` in the root directory.

    git clone git://github.com/phleet/dotfiles.git
    cd dotfiles
    make

This will ink `.vimrc` and `.vim` (it won't overwrite yours if they already exist).

If you want to use the `.bash_profile` on top of yours, you can add

    source path/to/dotfiles/.bash_profile

to the top of your real `.bash_profile` or `.bashrc`

Plugin Management
-----------------

I'm using [Vundle][] for plugin management here.

To manage plugins, edit `.vim/.vundle`

To install all the plugins I'm using, boot up vim after
running `make` and run
    
    :BundleInstall

Some of the plugins require native extensions. To install these, run

    make native
    

[Vundle]: https://github.com/gmarik/vundle
