" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Cyrillic symbols displaying
source $VIMRUNTIME/delmenu.vim
set langmenu=ru_RU.UTF-8
source $VIMRUNTIME/menu.vim


" Add python
set pythonhome=C:\Users\User\AppData\Local\Programs\Python\python-2.7.5
set pythondll=C:\Users\User\AppData\Local\Programs\Python\python-2.7.5\python27.dll
set pythonthreehome=C:\Users\User\AppData\Local\Programs\Python\Python310-32
set pythonthreedll=C:\Users\User\AppData\Local\Programs\Python\Python310-32\python310.dll

" Mouse behavior (the Windows way)
behave mswin

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

call plug#begin()

  Plug 'https://github.com/sainnhe/gruvbox-material.git'
  Plug 'https://github.com/sainnhe/everforest.git'
  Plug 'https://github.com/sainnhe/sonokai.git'
  Plug 'https://github.com/xavierd/clang_complete.git'
  Plug 'https://github.com/preservim/nerdtree.git'

call plug#end()


" Displaying line numbers
set nu

" Setting colorscheme
colorscheme everforest

set encoding=utf-8
set fileencoding=utf-8

"  NERDTree key mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Splited windows settings
set noequalalways
set winheight=20

" Clang-completer     
" path to directory where library can be found
let g:clang_library_path='C:/Program Files (x86)/LLVM/lib'                                                      
" Additional tips    
let g:clang_snippets=1       
" Auto-generated templates tips                                                                                            
" let g:clang_snippets_engine = 'ultisnips'                                       
" Auto error detection                                   
let g:clang_periodic_quickfix=1                                                 
" Highlight errors                                                           
let g:clang_hl_errors=1
" Close tips menu automatically             
let g:clang_close_preview=1                                              
" Check errors on Ctrl+F                              
map <c-f> :call g:ClangUpdateQuickFix()<cr>

let g:clang_user_options='|| exit 0'
let g:clang_complete_auto = 1
let g:clang_complete_copen = 1