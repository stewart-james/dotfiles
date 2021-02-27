" -- vundle start
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'

	Plugin 'flazz/vim-colorschemes'

call vundle#end()

filetype plugin indent on
" -- vundle end


" Disable annoying temp backup files
set nobackup
set noswapfile

" Appearance
colorscheme gruvbox
