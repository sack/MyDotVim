" -*- coding: UTF8 -*-
set enc=utf-8
set fenc=utf-8

call pathogen#runtime_append_all_bundles() 
"call pathogen#helptags() 

syntax enable

"num lines
"set nu

" A utiliser en live, paste désactive l'indentation automatique (entre autre)
" et nopaste le contraire
set nopaste

" Toujours laisser des lignes visibles (içi 3) au dessus/en dessous du curseur quand on
" atteint le début ou la fin de l'écran :
set scrolloff=3

" Tenter de rester toujours sur la même colonne lors de changements de lignes :
set nostartofline

set laststatus=1


"dict for autocomplete ctrl-x ctrl-k...
set dictionary+=/usr/share/dict/french

"mon theme en 256 couleurs
if $TERM == "rxvt" || $TERM == "screen-bce" || $TERM == "screen-256color-bce" || $TERM == "xterm-256color"
"   let xterm16bg_Normal = 'none'
   set t_Co=256
"   colorscheme xterm16
    colorscheme desert256
endif

"let g:btm_rainbow_color=1
"if exists("g:btm_rainbow_color") && g:btm_rainbow_color
"   call rainbow_parenthsis#LoadSquare ()
"   call rainbow_parenthsis#LoadRound ()
"   call rainbow_parenthsis#Activate ()
"endif


autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit

if hostname() == "st-si9"
   if v:version > 702
      set relativenumber
   endif
endif

" Include DokuVimKi Configuration
if filereadable($HOME."/.vim/dokuvimkirc")
  source $HOME/.vim/dokuvimkirc
endif

" looks for DokuWiki headlines in the first 20 lines
" of the current buffer
fun IsDokuWiki()
    if match(getline(0,20),'^ \=\(=\{2,6}\).\+\1 *$') >= 0
        set textwidth=80
        set wrap
        set linebreak
        set filetype=dokuwiki
        "source ~/demo.vim
        " remap save commands for convenience
        nmap <S-z><S-z> :DWSend<CR>
        nmap :w :DWSend<CR>
        function! MyDokuwikiSave()
            call inputsave()
            let name = input('Message de commit : ')
            call inputrestore()
            echo name
            DWSend name
        endfunction
        "nmap :w :call MyDokuwikiSave()<CR>
        " map quelques raccourcis
        map _m1 i======   ======<esc>7hi
        map _m2 i=====   =====<esc>6hi
        map _m3 i====   ====<esc>5hi
        map _m4 i===   ===<esc>4hi
        map _m5 i==   ==<esc>3hi
        map _m+ <home>i=<esc><end>i=<esc>
        map _m- <home>x<end>x
    endif
endfun

" check for dokuwiki syntax
autocmd BufWinEnter *.txt call IsDokuWiki()


