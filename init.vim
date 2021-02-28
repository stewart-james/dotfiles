let mapleader = "\<Space>"

" Plugins
call plug#begin()

	" Fuzzy
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-rooter'

	" Languages
        Plug 'OmniSharp/omnisharp-vim'

        " Mappings, code-actions available flag and statusline integration
        Plug 'nickspoons/vim-sharpenup'

	" Linters
        Plug 'dense-analysis/ale'

	" Autocompletion
	Plug 'prabirshrestha/asyncomplete.vim'

	" Appearance
	Plug 'gruvbox-community/gruvbox'

        " Statusline
        Plug 'itchyny/lightline.vim'
        Plug 'shinchu/lightline-gruvbox.vim'
        Plug 'maximbaz/lightline-ale'
	

call plug#end()

" Appearance
" <----------------->
" Use truecolor in the terminal, when it is supported
if has('termguicolors')
	set termguicolors
endif

colorscheme gruvbox

"
" Colors: {{{
augroup ColorschemePreferences
	autocmd!

	" These preferences clear some gruvbox background colours, allowing transparency
	autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
	autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
	autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE

	" Link ALE sign highlights to similar equivalents without background colours
	autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
	autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
	autocmd ColorScheme * highlight link ALEInfoSign Identifier
augroup END

" Misc Settings
" <----------------->
filetype indent plugin on
if !exists('g:syntax_on') | syntax enable | endif
set relativenumber
set encoding=utf-8
scriptencoding utf-8
set backspace=indent,eol,start
set autoindent
set noexpandtab
set shiftround
set shiftwidth=4
set softtabstop=-1
set tabstop=4
set textwidth=80
set title
set hidden
set nofixendofline
set nostartofline
set splitbelow
set splitright
set hlsearch
set incsearch
set laststatus=2
set nonumber
set noruler
set noshowmode
set signcolumn=yes
set mouse=a
set updatetime=1000

" Linting
" <----------------->

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'
let g:ale_linters = { 'cs': ['OmniSharp'] }

" Autocomplete
" <----------------->
"let g:asyncomplete_auto_popup = 1
"let g:asyncomplete_auto_completeopt = 0


" Omnisharp
" <----------------->
let g:OmniSharp_popup_position = 'peek'
if has('nvim')
	let g:OmniSharp_popup_options = {
	    \ 'winhl': 'Normal:NormalFloat'
	    \}
else
	let g:OmniSharp_popup_options = {
	\ 'highlight': 'Normal',
	\ 'padding': [0, 0, 0, 0],
	\ 'border': [1]
	\}
endif

let g:OmniSharp_popup_mappings = {
		    \ 'sigNext': '<C-n>',
		    \ 'sigPrev': '<C-p>',
		    \ 'pageDown': ['<C-f>', '<PageDown>'],
		    \ 'pageUp': ['<C-b>', '<PageUp>']
		    \}

let g:OmniSharp_highlight_groups = {
	\ 'ExcludedCode': 'NonText'
	\}

" Finding
" <----------------->

" FZF Config
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.5, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
let $FZF_DEFAULT_OPTS = '--info=inline --preview-window=hidden'

" Lightline
let g:lightline = {
            \ 'colorscheme': 'gruvbox',
            \ 'active': {
            \   'right': [
            \     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
            \     ['lineinfo'], ['percent'],
            \     ['fileformat', 'fileencoding', 'filetype', 'sharpenup']
            \   ]
            \ },
            \ 'inactive': {
            \   'right': [['lineinfo'], ['percent'], ['sharpenup']]
            \ },
            \ 'component': {
            \   'sharpenup': sharpenup#statusline#Build()
            \ },
            \ 'component_expand': {
            \   'linter_checking': 'lightline#ale#checking',
            \   'linter_infos': 'lightline#ale#infos',
            \   'linter_warnings': 'lightline#ale#warnings',
            \   'linter_errors': 'lightline#ale#errors',
            \   'linter_ok': 'lightline#ale#ok'
  \  },
  \ 'component_type': {
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right'
  \  }
  \}
" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

" Bindings
" <----------------->

map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>m :Marks<CR>

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

set background=dark
