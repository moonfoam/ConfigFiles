## About

My [Vim] config file works with [Vundle] - a plugin manager.

## Quick Start

1. What you need:
   
   Installation requires [Git] and triggers [`git clone`] for each configured repository to `~/.vim/bundle/` by default.
   Curl is required for search.
   
2. Set up [Vundle]:

   `$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

3. Clone the repositorie and copy the Config file:

   ```
   $ git clone https://github.com/moonfoam/ConfigFiles.git ~/.ConfigFiles
   $ cp ~/.ConfigFiles/Vim/.vimrc ~/.vimrc
   ```

4. Install Plugins:

   Launch `vim` and run `:PluginInstall`

   To install from command line: `vim +PluginInstall +qall`

## TODO:

[Vundle]:http://github.com/VundleVim/Vundle.vim
[Vim]:http://www.vim.org
[Git]:http://git-scm.com
[`git clone`]:http://gitref.org/creating/#clone
