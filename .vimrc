" --------------------------------------------------------------------------
" 基本設定 Basics
"---------------------------------------------------------------------------
set autoindent                       " 改行時に半角スペース8文字を自動挿入する。
set clipboard+=unnamed               " macvimでCtrl-VとCtrl-Cを使う
set tabstop=2                        " 画面上でtabが占める幅
set shiftwidth=2                     " 自動インデントでずれる幅
set softtabstop=0                    " softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set expandtab                        " tab入力を複数の空白入力に置き換える
set hidden                           " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start       " バックスペースでなんでも消せるように
set showcmd                          " コマンドをステータス行に表示
set showmode                         " 現在のモードを表示
set notitle                          " vimを使ってくれてありがとう
set noundofile                       " undo file (*.un~)を作らない
set ruler                            " ルーラーを表示 (noruler:非表示)
set nolist                           " タブや改行を表示 (list:表示)
set wrap                             " 長い行を折り返して表示 (nowrap:折り返さない)
set laststatus=2                     " 常にステータス行を表示 (詳細は:he laststatus)
set nobackup                         " バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set noswapfile                       "swpファイル出力無効
autocmd BufWritePre * :%s/\s\+$//ge  " 行末の無駄なスペース削除
"---------------------------------------------------------------------------
" 表示 Apperance
"---------------------------------------------------------------------------
set showmatch         " 括弧の対応をハイライト
set number            " 行番号表示
set list              " 不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=uhex      " 印字不可能文字を16進数で表示

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" インサートモードに入った時にカーソル行(列)の色を変更する
augroup vimrc_change_cursorline_color
  autocmd!
  autocmd InsertEnter * highlight CursorLine term=underline cterm=underline ctermbg=240 gui=underline guibg=#666666 | highlight CursorColumn ctermfg=231 ctermbg=31 gui=bold guifg=#ffffff guibg=#0087af
  autocmd InsertLeave * highlight CursorLine term=underline cterm=underline ctermbg=235 gui=underline guibg=#333333 | highlight CursorColumn term=reverse ctermbg=235 guibg=#333333
augroup END

"-------------------------------------------------------------------------------
" カラー関連 Colors
"-------------------------------------------------------------------------------

" colorscheme mrkn256
"colorscheme yuroyoro256

" ターミナルタイプによるカラー設定
if &term =~ "xterm-256color" || "screen-256color"
  " 256色
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

"ポップアップメニューのカラーを設定
"hi Pmenu guibg=#666666
"hi PmenuSel guibg=#8cd0d3 guifg=#666666
"hi PmenuSbar guibg=#333333

" ハイライト on
syntax enable
" 補完候補の色づけ for vim7
" hi Pmenu ctermbg=255 ctermfg=0 guifg=#000000 guibg=#999999
" hi PmenuSel ctermbg=blue ctermfg=black
hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c
" hi PmenuSbar ctermbg=0 ctermfg=9
" hi PmenuSbar ctermbg=255 ctermfg=0 guifg=#000000 guibg=#FFFFFF

" Highlight the go 'error'
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/

autocmd FileType javascript :highlight jsColonAtTail  cterm=underline ctermfg=lightblue guibg=darkgray
autocmd FileType javascript :match jsColonAtTail /:$/

" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

"-------------------------------------------------------------------------------
" 編集関連 Edit
"-------------------------------------------------------------------------------

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
"
" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ"
map <silent> [Tag]p :tabprevious<CR>
" インサートモードでjjをたたくとesc
inoremap <silent> jj <ESC>
" 対応する括弧や引用符を自動補完する
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
" 既に対応する引用符が存在するときは保管しないようする
function! QuotesCompletion(char)
    let counter = 0
        let line = getline(".")
    for i in range(strlen(line))
            if line[i] == a:char
                let counter += 1
        endif
    endfor
        if counter % 2 == 0
return a:char.a:char."\<Left>"
    else
            return a:char
        end
endfunction

inoremap <silent> <expr> " QuotesCompletion("\"")
inoremap <silent> <expr> ' QuotesCompletion("\'")

"-------------------------------------------------------------------------------
" エンコーディング関連 Encoding
"-------------------------------------------------------------------------------
set ffs=unix,dos,mac  " 改行文字
set encoding=utf-8    " デフォルトエンコーディング

" ワイルドカードで表示するときに優先度を低くする拡張子
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc


"-------------------------------------------------------------------------------
" 検索 Searching
"-------------------------------------------------------------------------------
" 検索時に大文字小文字を無視noignorecase:無視しない
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" 検索すると自動的にヒット数を表示する
nnoremap <expr> / _(":%s/<Cursor>/&/gn")

function! s:move_cursor_pos_mapping(str, ...)
    let left = get(a:, 1, "<Left>")
    let lefts = join(map(split(matchstr(a:str, '.*<Cursor>\zs.*\ze'), '.\zs'), 'left'), "")
    return substitute(a:str, '<Cursor>', '', '') . lefts
endfunction

function! _(str)
    return s:move_cursor_pos_mapping(a:str, "\<Left>")
endfunction


"-------------------------------------------------------------------------------
" プラグイン Plugin
"-------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" previm：マークダウンプレビューツール
Plug 'https://github.com/previm/previm.git'
" open-browser：ブラウザでURLの内容を閲覧できるツール"
Plug 'tyru/open-browser.vim'

call plug#end()


"-------------------------------------------------------------------------------
" previm
"-------------------------------------------------------------------------------
let g:previm_open_cmd = ''
nnoremap [previm] <Nop>
nmap <Space>p [previm]
nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>


"-------------------------------------------------------------------------------
" open-browser
"-------------------------------------------------------------------------------
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
