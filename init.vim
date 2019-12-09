"---------------------------------
"[start]  基本的な設定
"---------------------------------
"
"{{{
""------------------------------------------------------------------------
" ウインドウの設定
"------------------------------------------------------------------------
set guicursor=a:blinkon0    " カーソルの点滅なし
set linespace=1             " 行間隔
"set columns=70             " ウインドウ幅
"set lines=30                " ウインドウ高
set cmdheight=2             " コマンドライン幅
if has("gui")
    winpos  200  10         " ウインドウ位置
endif
set guioptions-=T           " ツールバー消去
set guioptions-=m           " メニューバー非表示
set display=lastline        " 長い行を省略せずに表示する
set pumheight=10            " 補完リストの高さ
set number
set laststatus=2            " Powerline のため
"set notitle                 " タイトルなし
"set shortmess+=I            " タイトルなし

"------------------------------------------------------------------------
" カラースキーム
"------------------------------------------------------------------------
if has("gui")
    autocmd FocusGained * set transparency=100   " Ubuntu 17.04 で nvim-qt から起動させたが、透けなかった。
endif
colorscheme molokai

"------------------------------------------------------------------------
" 編集に関する設定
"------------------------------------------------------------------------
set ambiwidth=double                    " 2バイト文字でカーソル位置がずれる問題の対策
set iminsert=0 imsearch=0               " 挿入モード・検索モードでのデフォルトのIME状態設定
set expandtab                           " タブ入力時に自動的にスペースに変える
set tabstop=4                           " 1タブの幅
set softtabstop=4                       " 1タブ当たりの半角スペースの個数 (通常入力時)
set shiftwidth=4                        " 1タブ当たりの半角スペースの個数 (コマンドや自動インデント)
"set clipboard=unnamed                   " xterm への S-Insert でのペーストOKだが、firefox にペーストできない (ginit.vim あり)
"set clipboard+=unnamed                  " 同上
"set clipboard=unnamedplus               " firefox などに S-Insert でペーストできるが, xterm へのペーストができない (ginit.vim あり)
set clipboard=unnamed,unnamedplus       " firefox, xterm への S-Insert でのペーストが出来た (ginit.vim あり)
set clipboard+=unnamedplus
inoremap <silent> jj <ESC>              
" ESCの代わりにjjでinsertモードを抜ける
inoremap <C-j> <C-n> 
" 変換候補の移動をctrl+jでやる
set virtualedit=onemore                 " 行末の位置文字先までカーソルを移動させる
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set autoindent                          " 自動的にインデントする (noautoindent:インデントしない)
set backspace=indent,eol,start          " バックスペースでインデントや改行を削除できるようにする
set showmatch matchtime=1               " 入力時対応する括弧に飛ぶ。表示時間 ＝ 0.1 * matchtime (秒)
set autoindent                          " 自動的にインデントする (noautoindent:インデントしない)
set backspace=indent,eol,start          " バックスペースでインデントや改行を削除できるようにする
set showmatch matchtime=1               " 入力時対応する括弧に飛ぶ。表示時間 ＝ 0.1 * matchtime (秒)
set wildmenu                            " コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set nobackup                            " バックアップファイルを作成しない
set noswapfile                          " スワップファイルを作成しない
"set noundofile                          " undoファイル (*.un~) を作成しない
set undodir=$HOME/.config/nvim/undo
nnoremap Y y$                          " Y を y$ と同じにする。(ノーマルモード・再割り当て無し) 
set scrolloff=5                         " スクロールする時に下が見えるようにする
set wildmenu                            " コマンドライン補完するときに強化されたものを使う
" , の後に自動的にスペースを入れる
" inoremap , ,<Space>
" 文字が無い部分でも矩形選択を可能にする
" set virtualedit=block
autocmd BufNewFile *.cpp 0r $HOME/.config/nvim/template/template.cpp

augroup grlcd                           "ファイルを開くと、ファイルがあるディレクトリに移動する
    autocmd!
    autocmd BufEnter * lcd %:p:h
augroup END

if 1    " 4-6. yank した文字列とカーソル位置の単語を置換する
    nnoremap    <silent> cy   ce<C-r>0<ESC>:let@=/=@1<CR>:noh<CR>
    vnoremap    <silent> cy   ce<C-r>0<ESC>:let@=/=@1<CR>:noh<CR>
    nnoremap    <silent> ciy  ciw<C-r>0<ESC>:let@=/=@1<CR>:noh<CR>
endif

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
"------------------------------------------------------------------------
" 検索に関する設定
"------------------------------------------------------------------------
set incsearch                               " 一致したもの全てハイライトする
" 4-16. Esc 2回でハイライトを消す
nnoremap <ESC><ESC> :nohlsearch<CR>
set ignorecase                              " 検索時に大文字小文字を無視 (noignorecase:無視しない)
set smartcase                               " 大文字小文字の両方が含まれている場合は大文字小文字を区別
set wrapscan                                " 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
" 検索した後に移動しない
nnoremap * *N
nnoremap # #N

augroup grepopen                            " vimgrep 実行後に自動的に copen して QuickFix ウインドウを開く。
    autocmd!
    autocmd QuickfixCmdPost vimgrep cw
augroup END


"------------------------------------------------------------------------
" マウス設定
"------------------------------------------------------------------------
set mouse=a       " どのモードでもマウスを使えるようにする
set nomousefocus  " マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set mousehide     " 入力時にマウスポインタを隠す (nomousehide:隠さない)
set guioptions+=a " ビジュアル選択(D&D他)を自動的にクリップボードへ (:help guioptions_a)


"------------------------------------------------------------------------
" diffopt 設定
"------------------------------------------------------------------------
" diffモードでの操作
"   [c → 次の違いがある場所にジャンプ
"   ]c → 前の違いがある場所にジャンプ
"   do → 今開いているバッファに別バッファの差分を取り込む (:diffget)
"   dp → 別バッファに今開いているバッファの差分を入れる   (:diffput)
"
"   http://qiita.com/purini-to/items/1209e467eb9ca73e529b
if has("gui")
    " カレント行ハイライトON
    " 横方向。ただし Ubuntu 17.04 の nvim-qt はハイライトになるが、nvim では下線になるので注意。
    set cursorline
endif
" アンダーラインを引く(color terminal)
"highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
" アンダーラインを引く(gui)
"highlight CursorLine gui=underline guifg=NONE guibg=NONE
set diffopt+=filler     " 差分が無い箇所を '-' で埋めない
set diffopt+=icase      " 大小文字の違いは無視する
set diffopt+=iwhite     " 半角スペースの個数の違いは無視する
set diffopt+=vertical
nnoremap <C-c><C-c> ]c
nnoremap <C-c><C-k> [c
nnoremap <Leader>df :<C-u>diffsplit %
nnoremap <Leader>do :<C-u>diffsplit %.orig <CR>
"}}}
"---------------------------------
"[end]     基本的な設定
"---------------------------------

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif


" Required:
set runtimepath+=/home/wakimiko/.config/nvim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/wakimiko/.config/nvim/')
  call dein#begin('/home/wakimiko/.config/nvim/')

  " Let dein manage dein
  " Required:
  call dein#add('/home/wakimiko/.config/nvim/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  "------------------------------
  "[start]  dein によるプラグイン管理
  "------------------------------
  call dein#add('Shougo/vimproc')
  call dein#add('Shougo/neocomplcache.vim')  " NeoComlcache
  call dein#add('equalsraf/neovim-qt')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/vimfiler.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/vinarise.vim')     " バイナリファイル編集"
  call dein#add('AndrewRadev/linediff.vim') "行範囲のdiff
  call dein#add('LeafCage/yankround.vim')  " ヤンクバッファ
  call dein#add('junegunn/vim-easy-align')   " コードの自動整形
  call dein#add('Lokaltog/vim-easymotion')   " 高速移動
  call dein#add('nathanaelkane/vim-indent-guides')   " インデントガイド
  call dein#add('Yggdroot/indentLine')   " インデントライン
  call dein#add('itchyny/thumbnail.vim') " バッファセレクタ
  call dein#add('yonchu/accelerated-smooth-scroll') " 加速バッファセレクタ
  call dein#add('itchyny/lightline.vim')
  call dein#add('tyru/open-browser.vim')
  call dein#add('tyru/capture.vim') " コマンドの結果をキャプチャする (例) :Capture map
  call dein#add('fuenor/qfixgrep')
  call dein#add('thinca/vim-qfreplace')
  call dein#add('AndrewRadev/linediff.vim')
  call dein#add('houtsnip/vim-emacscommandline')  " コマンドラインで emacs 操作をする
  call dein#add('AndrewRadev/linediff.vim')
  call dein#add('tpope/vim-surround') "surround
  call dein#add('tpope/vim-repeat') "repeat surround
  call dein#add('neoclide/coc.nvim')

  "[ref] http://wakame.hatenablog.jp/entry/2016/10/09/174035
  "[ref] http://wakame.hatenablog.jp/entry/2017/05/04/144550
  " call dein#load_toml('~/.config/nvim/userautoload/dein/plugins.toml', {'lazy': 0})
  " call dein#load_toml('~/.config/nvim/userautoload/dein/plugins-lazy.toml', {'lazy': 1})

  "------------------------------
  "[end]    dein によるプラグイン管理
  "------------------------------
  
  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"---------------------------------
"[start]   プラグインインストール後の設定
"---------------------------------
let my_plugin_list = [
\ "$HOME/.config/nvim/userautoload/plugins/plugin_neocomplcache.vim"      ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_easyalign.vim"          ,
\ "$HOME/.config/nvim/userautoload/plugins/plugins-unite.vim"             ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_indentguides.vim"       ,
\ "$HOME/.config/nvim/userautoload/plugins/local_keymap.vim"              ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_yankround.vim"          ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_easymotion.vim"         ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_thumbnail.vim"          ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_textmanip.vim"          ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_lightline.vim"          ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_vim_open_browser.vim"   ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_qfixgrep.vim" ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_neosnippet.vim"           ,
\ "$HOME/.config/nvim/userautoload/plugins/plugin_vimfiler.vim"
\ ]

let i = 0
while i < len(my_plugin_list)
    let f = my_plugin_list[i]
    if filereadable(expand(f))
        source `=f`
    endif
    let i = i + 1
endwhile

"{{{
" ---------------------------------------------------------------
" easyalign の使い方メモ
" ---------------------------------------------------------------
" コードの自動整形 (ビジュアルモードで範囲選択 → Enter → * → =)
" http://baqamore.hatenablog.com/entry/2015/06/27/074459
" vim-textmanip (矩形のコピーや移動)

"}}}
"---------------------------------
"[end]     プラグインインストール後の設定
"---------------------------------
"End dein Scripts-------------------------
" vim: foldmethod=marker 
