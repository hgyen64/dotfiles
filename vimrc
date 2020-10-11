set nocompatible              " required for Vundle
filetype off                  " required for Vundle

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nanotech/jellybeans.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-syntastic/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'skammer/vim-css-color'
Plugin 'tpope/vim-commentary'
Plugin 'alvan/vim-closetag'
Plugin 'Valloric/MatchTagAlways'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'danilo-augusto/vim-afterglow'
Plugin 'romainl/flattened'
Plugin 'jiangmiao/auto-pairs'
Plugin 'davidhalter/jedi-vim'
" Plugin 'ycm-core/YouCompleteMe'
" Plugin 'justmao945/vim-clang'

call vundle#end()            " required for Vundle
filetype plugin indent on    " required for Vundle

"""""""""""""""""""" PLUGINS SETTINGS


" jedi-vim
" let g:jedi#auto_initialization = 1
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 1
let g:jedi#popup_on_dot = 1
let g:jedi#show_call_signatures = "0"
" let g:jedi#force_py_version = 3
let g:jedi#use_splits_not_buffers = "top"
let g:jedi#use_tabs_not_buffers = 1
let g:pymode_rope = 0
autocmd FileType python setlocal completeopt-=preview

" vim-colors-solarized
syntax enable
set background=dark
let g:solarized_termtrans = 1
let g:solarized_termcolors=256
set t_Co=256
set background=dark
colorscheme solarized
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen

"vim-airline
function! AirlineInit()
	let g:airline_mode_map = {
				\ '__' : '-',
				\ 'n' : 'N',
				\ 'i' : 'I',
				\ 'R' : 'R',
				\ 'c' : 'C',
				\ 'v' : 'V',
				\ 'V' : 'V',
				\ 's' : 'S',
				\ 'S' : 'S',
				\ }
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep= ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_section_a = airline#section#create(['mode'])
	let g:airline_section_b = airline#section#create(['%f'])
	let g:airline_section_c = airline#section#create([''])
	let g:airline_section_x = airline#section#create_right([''])
	let g:airline_section_y = airline#section#create_right([''])
	let g:airline_section_z = airline#section#create_right(['%l %c'])
    let g:airline_detect_whitespace=0
    AirlineToggleWhitespace
	AirlineTheme jellybeans

endfunction
autocmd VimEnter * call AirlineInit()

" NERDTREE
map <F3> :NERDTreeToggle<CR>
let NERDTreeChDirMode=2      " auto refresh directory change
let NERDTreeIgnore = ['\.pyc$']

" VIM-EASY-ALIGN
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" CTRLP
map <C-p> :CtrlP<CR><F5>
let g:ctrlp_custom_ignore = {
	\ 'dir': '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(pyc|swp)$',
	\ 'link': '',
	\ }

" vim-clang
" let g:clang_c_options = '-std=g++17'
" let g:clang_cpp_options = '-std=c++17 -stdlib=libc++'

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = 'g++-9'
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options = ' -std=c++17'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--ignore=E501"

let g:syntastic_mode_map = {
     \ "mode": "active",
     \ "active_filetypes": ["python", "ruby", "php"],
     \ "passive_filetypes": ["php", "cpp", "h"] }
nnoremap <C-w>e :SyntasticCheck<CR>
nnoremap <C-w>f :SyntasticToggleMode<CR>
" set laststatus=2
" set t_Co=256

" VIM-CSS-COLOR
" updatetime value
" let g:cssColorVimDoNotMessMyUpdatetime = 1


"""""""""""""""""""" CONFIGURATIONS

" display
syntax on                                " enable syntax highlighting
set bg=dark                              " background dark
set nu                                   " show line numbers

" convenience
set clipboard=unnamed,unnamedplus        " use system clipboard
" set mouse=a                              " use mouse
set autoread                             " auto re-read changes outside vim
set autowrite                            " auto save before make / execute

" indentation + tab
set autoindent cindent                   " C-style indentation
set bs=2                                 " backspace should work as expected
set expandtab                            " Use space instead of tab
set tabstop=4 shiftwidth=4 softtabstop=4 " Set tab to 4

" searching
set incsearch hlsearch                   " Highlight search
set smartcase ignorecase                 " Ignore case unless search term has upper-cased

" code folding
set foldmethod=syntax
set foldlevel=15

" " Disable Arrow keys in Escape mode
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

" " Disable Arrow keys in Insert mode
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>
"
autocmd FileType cpp        call CPPSET()
function! CPPSET()
  set makeprg=if\ \[\ -f\ \"Makefile\"\ \];then\ make\ $*;else\ if\ \[\ -f\ \"makefile\"\ \];then\ make\ $*;else\ g++\ -std=gnu++0x\ -O2\ -g\ -Wall\ -Wextra\ -o\ %<\ %;fi;fi
  set cindent
  set wrap
  " nnoremap <buffer> <F9> :w<cr>:!g++ -O2 % -o %< -std=c++11 -I ./<cr>:!./%<<cr>
  " nnoremap <buffer> <F8> :w<cr>:!g++ -O2 % -o %< -std=c++11 -I ./<cr>
  nnoremap <buffer> <F9> <cr>:!cd ./build && cmake .. && make && ./tests/tests<cr>
endfunction

autocmd FileType python        call PYSET()
function! PYSET()
  set wrap
  nnoremap <buffer> <F9> :w<cr>:!source env/bin/activate && green -vv<cr>
endfunction

au BufEnter /private/tmp/crontab.* setl backupcopy=yes

" <Tab> at the end of a word should attempt to complete it using tokens from the current file: {{{
function! MyTabCompletion()
	if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
		return "\<C-P>"
	else
		return "\<Tab>"
	endif
endfunction
inoremap <Tab> <C-R>=MyTabCompletion()<CR>
" }}}

" setlocal indentexpr=
