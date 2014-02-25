
## Supported OSes

The VIM config itself, should work everywhere, but the ``vimplugs.py`` script
assumes the underlaying OS supports symbolic links, so \*nix and OSX.
Unfortunately, windows is unable to do this, so Windows users will have to
copy the plugins from by hand.

## Installing

Clone the repository, as an example I will use a ``~/dotfiles`` directory.
After cloning, you need to initialize submodules and fetch them, then
run ``vimplugs.py`` to enable all plugins.

    $ mkdir ~/dotfiles
    $ cd ~/dotfiles
    $ git clone git://github.com/novopl/vimcfg
    $ cd vimcfg
    $ git submodule update --init --recursive
    $ ./vimplugs.py

After all those steps, the only thing left is to symlink the vim configuration
files, for VIM to use them:

    $ ln -s ~/dotfiles/vimcfg/vim ~/.vim
    $ ln -s ~/dotfiles/vimcfg/vimrc ~/.vimrc

## Enabling/disabling plugins

To manage which plugins are enabled, use the plugins.conf file. Each line
starts with the option marker(+/-/^) where ``+`` means the plugin is enabled,
``-`` means the plugin is disabled, but will be cloned anyway (makes enabling
the plugin easy) and ``^`` means the plugin is diabled and won't be fetched.
The last option is usefull when we plan to experiment with the plugin in the
future, but don't wan't any extra files currently - something like a bookmark
for later use.

The option marker is followed by the plugin name, then a colon and a URL to
git repository hosting the plugin. If ``vimplugs.py`` detected a newly
cloned repository, it will automatically run
``git submodule update --init --recursive`` to download all of the plugin
dependencies.
