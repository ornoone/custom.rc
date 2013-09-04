
" reglages commun {{{1

set softtabstop=2
"taille des tabulation
set ts=2
"affiche numero de ligne
set nu 

let mapleader = "<space>""
"active l'indentation en fonction du fichier
filetype indent on
filetype plugin indent on
"transforme les espace d'indentation en tabulation
set expandtab
"no compatible
set nocp
"
set shiftwidth=2
"encode les edition en utf-8
set encoding=utf-8
"encode les fichier en UTF-8
set fileencoding=utf-8
"active la syntax
syntax on
"fond d'ecrant en sombre
set background=dark 
"??
set backspace=indent,eol,start
"active les backup
set backup

set history=100

" undo, pour revenir en arrière
set undolevels=150

" Suffixes à cacher
set suffixes=.jpg,.png,.jpeg,.gif,.bak,~,.swp,.swo,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo

" Quand un fichier est changé en dehors de Vim, il est relu automatiquement
set autoread

" Aucun son ou affichage lors des erreurs
set errorbells
set novisualbell
set t_vb=

colorscheme inkpot
set t_Co=256

" Quand une fermeture de parenthèse est entrée par l'utilisateur,
" l'éditeur saute rapidement vers l'ouverture pour montrer où se
" trouve l'autre parenthèse. Cette fonction active aussi un petit
" beep quand une erreur se trouve dans la syntaxe.
set showmatch
set matchtime=1
let g:pydiction_location='/home/darius/.vim/complete-dict'

au BufWinLeave * mkview
au BufWinEnter * silent loadview

" Afficher la barre d'état
set laststatus=2
" }}}1
set wildmode=longest,list,full
set wildmenu

" {{{2 reglages plugins

" minibuffer explorer map calvier
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 

" }}}2

" backups {{{2
" Backup dans ~/.vim/backup
if filewritable(expand("~/.vim/backup")) == 2
    " comme le répertoire est accessible en écriture,
    " on va l'utiliser.
  set backupdir=$HOME/.vim/backup
else
  if has("unix") || has("win32unix")
        " C'est c'est un système compatible UNIX, on
        " va créer le répertoire et l'utiliser.
    call system("mkdir $HOME/.vim/backup -p")
    set backupdir=$HOME/.vim/backup
  endif
endif

" Inclusion d'un autre fichier avec des options
if filereadable(expand("~/.vimrc_local.vim"))
    source ~/.vimrc_local.vim
endif

" }}}2

" Options de recherche {{{2 

" Tout ce qui concerne la recherche. Incrémentale
" avec un highlight. Elle prend en compte la
" différence entre majuscule/minuscule.
set incsearch
set noignorecase
set infercase

" Quand la rechercher atteint la fin du fichier, pas
" la peine de la refaire depuis le début du fichier
set hlsearch

" }}}2

" Options d'affichage texte {{{2

" Ne pas nous afficher un message quand on enregistre un readonly
set writeany

" Afficher les commandes incomplètes
set showcmd

" Afficher la position du curseur
set ruler

" Désactiver le wrapping"{{{"}}}
set nowrap

" Options folding
" set foldmethod=marker

" Format the statusline
set statusline=%F%m\ %r\ Line:%l\/%L,%c\ %p%%

" }}}2

" Options d'affichage GUI {{{2

" Configuration de la souris en mode console
" ="" pas de souris par défaut
"set mouse=a

" Améliore l'affichage en disant à vim que nous utilisons un terminal rapide
set ttyfast

" Lazy redraw permet de ne pas mettre à jour l'écran
" quand un script vim est entrain de faire une opération
set lazyredraw
" }}}2

" options edition zip {{{2
set autochdir
if has("autocmd")

 augroup gzip
  " Supprime toutes les autocommandes gzip
  au!

  " Active l'édition des fichiers gzippés
  " Active le mode binaire avant de lire le fichier
  autocmd BufReadPre,FileReadPre        *.gz,*.bz2 set bin
  autocmd BufReadPost,FileReadPost      *.gz call GZIP_read("gunzip")
  autocmd BufReadPost,FileReadPost      *.bz2 call GZIP_read("bunzip2")
  autocmd BufWritePost,FileWritePost    *.gz call GZIP_write("gzip")
  autocmd BufWritePost,FileWritePost    *.bz2 call GZIP_write("bzip2")
  autocmd FileAppendPre                 *.gz call GZIP_appre("gunzip")
  autocmd FileAppendPre                 *.bz2 call GZIP_appre("bunzip2")
  autocmd FileAppendPost                *.gz call GZIP_write("gzip")
  autocmd FileAppendPost                *.bz2 call GZIP_write("bzip2")

  " Après la lecture du fichier compressé : décompresse le texte dans le
  " buffer avec "cmd"
  fun! GZIP_read(cmd)
    let ch_save = &ch
    set ch=2
    execute "'[,']!" . a:cmd
    set nobin
    let &ch = ch_save
    execute ":doautocmd BufReadPost " . expand("%:r")
  endfun

  " Après l'écriture du fichier compressé : compresse le fichier écrit avec "cmd"
  fun! GZIP_write(cmd)
    if rename(expand("<afile>"), expand("<afile>:r")) == 0
      execute "!" . a:cmd . " <afile>:r"
    endif
  endfun

  " Avant l'ajout au fichier compressé : décompresser le fichier avec "cmd"
  fun! GZIP_appre(cmd)
    execute "!" . a:cmd . " <afile>"
    call rename(expand("<afile>:r"), expand("<afile>"))
  endfun

  augroup END

  augroup templates
    au!
    " read in template files
    autocmd BufNewFile *.* silent! execute '0r $HOME/.vim/templates/skeleton.'.expand("<afile>:e")
    au bufNewFile *templates/*form.html 0r ~/.vim/templates/djangohtml_form.html
    au bufNewFile *templates/*.html 0r ~/.vim/templates/skeleton.djangohtml
    " parse special text in the templates after the read
    autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
  augroup END

endif " has("autocmd")

"
" }}}2

" map clavier {{{2

" map <right> <esc>
" map <left> <esc>
" map <up> <esc>
" map <down> <esc>
nmap ,t :ToggleWord<CR> 
nmap t  :TlistToggle<CR>

" }}}2

" mes fonction {{{2

" }}}2
call pathogen#infect()


" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/stl
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4
set tags+=~/.vim/tags/python

" build tags of your own project with CTRL+F12
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
noremap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
inoremap <F12> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
