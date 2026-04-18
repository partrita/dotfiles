" ~/.vimrc: Vim 편집기 설정 파일

" --- 기본 설정 ---
syntax on             " 구문 강조 켜기
set encoding=utf-8    " 파일 인코딩을 UTF-8로 설정
set fileencodings=utf-8,euc-kr " 여러 인코딩 지원
set nu                " 줄 번호 표시 (set number 와 동일)
set relativenumber    " 상대적 줄 번호 표시 (커서 위치 기준)
set cursorline        " 현재 커서가 있는 줄 강조
set ruler             " 현재 커서 위치 (행, 열) 표시
set showcmd           " 입력 중인 명령어 표시
set laststatus=2      " 항상 상태 표시줄 표시

" --- 들여쓰기 및 탭 설정 ---
set tabstop=4         " 탭 문자를 4칸 공백으로 표시
set shiftwidth=4      " 자동 들여쓰기 시 4칸 사용
set expandtab         " 탭 입력 시 공백으로 변환
set autoindent        " 새 줄 시작 시 이전 줄의 들여쓰기 유지
set smartindent       " 더 지능적인 자동 들여쓰기 (C 스타일 파일에 유용)
" set cindent           " C 프로그램 스타일 들여쓰기 (smartindent 와 함께 사용 가능)

" --- 검색 설정 ---
set hlsearch          " 검색 결과 강조 표시
set incsearch         " 점진적 검색 (입력하는 동안 검색)
set ignorecase        " 검색 시 대소문자 무시
set smartcase         " 검색어에 대문자가 포함된 경우 대소문자 구분

" --- UI 및 편의 기능 ---
set showmatch         " 일치하는 괄호 강조
set matchtime=1       " 괄호 강조 시간 (0.1초)
set visualbell        " 경고 시 화면 깜빡임 (소리 대신)
set scrolloff=5       " 커서가 화면 가장자리에서 5줄 이상 떨어지도록 스크롤
set wildmenu          " 명령어 자동 완성 시 메뉴 형태로 표시
set wildmode=longest,list,full " 자동 완성 방식 설정
" set mouse=a           " 모든 모드에서 마우스 사용 가능 (터미널 환경에 따라 동작 다름)

" --- 백업 및 스왑 파일 설정 ---
" set nobackup          " 백업 파일 생성 안 함
" set nowritebackup     " 쓰기 전에 백업 파일 생성 안 함 (데이터 유실 위험 약간 증가)
" set noswapfile        " 스왑 파일 (.swp) 생성 안 함 (복구 기능 비활성화)
" 백업, 스왑 및 언두 파일 저장 위치 지정 (보안: 프로젝트 폴더 내 민감 정보 유출 방지)
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo
set undofile

" --- Python 개발 환경 설정 (선택 사항) ---
" autocmd FileType python setlocal textwidth=79    " PEP 8 에 따라 코드 너비 79자로 제한
" autocmd FileType python setlocal tabstop=4
" autocmd FileType python setlocal shiftwidth=4
" autocmd FileType python setlocal expandtab
" autocmd FileType python map <F5> :!python %<CR> " F5 키로 현재 Python 파일 실행

" --- 플러그인 관리 (예: Vundle 또는 vim-plug) ---
" 플러그인 매니저를 사용하는 경우 여기에 관련 설정을 추가합니다.
" 예시 (vim-plug):
" call plug#begin('~/.vim/plugged')
" Plug 'junegunn/vim-easy-align'
" Plug 'scrooloose/nerdtree'
" Plug 'tpope/vim-fugitive'
" call plug#end()

" --- 파일 타입별 설정 ---
filetype plugin indent on " 파일 타입에 따른 플러그인 및 들여쓰기 규칙 활성화

" --- 개인적인 추가 설정 ---
" 예: 특정 색상 테마 설정
" colorscheme desert

" 이 파일은 Vim 편집기의 기본적인 설정을 포함하고 있습니다.
" 사용자의 취향과 필요에 맞게 주석을 해제하거나 값을 변경하여 사용하세요.
set nomodeline
