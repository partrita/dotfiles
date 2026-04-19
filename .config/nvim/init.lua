-- Neovim 설정 파일 (init.lua)
-- ~/.config/nvim/init.lua

-- --- 기본 설정 ---
-- 보안: 파일 내부에 삽입된 Vim 명령어(modeline) 자동 실행 방지 (임의 코드 실행 취약점 방어)
vim.opt.modeline = false
vim.opt.encoding = 'utf-8' -- 파일 인코딩 UTF-8
vim.opt.number = true -- 줄 번호 표시
vim.opt.relativenumber = true -- 상대적 줄 번호 표시
vim.opt.cursorline = true -- 현재 커서 줄 강조
vim.opt.ruler = true -- 현재 커서 위치 표시
vim.opt.showcmd = true -- 입력 중인 명령어 표시
vim.opt.laststatus = 2 -- 항상 상태 표시줄 표시

-- 들여쓰기 및 탭
vim.opt.tabstop = 4 -- 탭 크기 (공백 4칸)
vim.opt.shiftwidth = 4 -- 자동 들여쓰기 크기
vim.opt.expandtab = true -- 탭을 공백으로 변환
vim.opt.autoindent = true -- 자동 들여쓰기
vim.opt.smartindent = true -- 지능형 들여쓰기

-- 검색
vim.opt.hlsearch = true -- 검색 결과 강조
vim.opt.incsearch = true -- 점진적 검색
vim.opt.ignorecase = true -- 검색 시 대소문자 무시
vim.opt.smartcase = true -- 검색어에 대문자 포함 시 대소문자 구분

-- UI 및 편의 기능
vim.opt.showmatch = true -- 일치하는 괄호 강조
vim.opt.matchtime = 1 -- 괄호 강조 시간 (0.1초)
vim.opt.scrolloff = 8 -- 커서가 화면 가장자리에서 8줄 이상 떨어지도록 스크롤
vim.opt.sidescrolloff = 8 -- 가로 스크롤 시 여백
vim.opt.termguicolors = true -- 터미널 트루컬러 사용
vim.opt.splitright = true -- 새 세로 분할 창을 오른쪽에 생성
vim.opt.splitbelow = true -- 새 가로 분할 창을 아래쪽에 생성
vim.opt.clipboard = 'unnamedplus' -- 시스템 클립보드 사용 (+ 레지스터)

-- 백업 및 스왑 파일 (필요에 따라 주석 해제 또는 경로 수정)
-- vim.opt.backup = false
-- vim.opt.writebackup = false
-- vim.opt.swapfile = false
vim.opt.backupdir = vim.fn.stdpath('data') .. '/backup'
vim.opt.directory = vim.fn.stdpath('data') .. '/swap'
vim.opt.undodir = vim.fn.stdpath('data') .. '/undo'
vim.opt.undofile = true

-- --- 키매핑 ---
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- 리더 키 설정 (예: 스페이스)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 창 이동
map('n', '<C-h>', '<C-w>h', opts) -- 왼쪽 창으로 이동
map('n', '<C-j>', '<C-w>j', opts) -- 아래쪽 창으로 이동
map('n', '<C-k>', '<C-w>k', opts) -- 위쪽 창으로 이동
map('n', '<C-l>', '<C-w>l', opts) -- 오른쪽 창으로 이동

-- 버퍼 이동
map('n', '<S-l>', ':bnext<CR>', opts) -- 다음 버퍼
map('n', '<S-h>', ':bprevious<CR>', opts) -- 이전 버퍼
map('n', '<leader>bd', ':bdelete<CR>', opts) -- 버퍼 닫기

-- 터미널
-- map('n', '<leader>t', ':split term://bash<CR>', opts) -- 새 터미널 열기
-- map('t', '<Esc>', '<C-\\><C-n>', opts) -- 터미널 모드에서 Esc로 Normal 모드 전환

-- --- 플러그인 매니저 (예: packer.nvim) ---
-- Packer를 사용하려면 먼저 설치해야 합니다.
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim\
--  ~/.local/share/nvim/site/pack/packer/start/packer.nvim

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

packer.startup(function(use)
  -- Packer 자신
  use 'wbthomason/packer.nvim'

  -- 테마
  use 'folke/tokyonight.nvim'
  -- use 'ellisonleao/gruvbox.nvim'

  -- 파일 탐색기
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- 상태 표시줄
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- 자동 완성
  use 'hrsh7th/nvim-cmp' -- 기본 자동완성 엔진
  use 'hrsh7th/cmp-nvim-lsp' -- LSP 소스
  use 'hrsh7th/cmp-buffer' -- 버퍼 소스
  use 'hrsh7th/cmp-path' -- 경로 소스
  use 'hrsh7th/cmp-cmdline' -- 커맨드라인 소스
  use 'saadparwaiz1/cmp_luasnip' -- 스니펫 소스
  use 'L3MON4D3/LuaSnip' -- 스니펫 엔진

  -- LSP (Language Server Protocol)
  use 'neovim/nvim-lspconfig' -- LSP 설정 도우미
  use 'williamboman/mason.nvim' -- LSP 서버 설치 관리
  use 'williamboman/mason-lspconfig.nvim' -- Mason과 lspconfig 연결

  -- 주석 처리
  use 'numToStr/Comment.nvim'

  -- 괄호 자동 완성 및 강조
  use 'windwp/nvim-autopairs'
  use 'p00f/nvim-ts-rainbow' -- (Tree-sitter 필요)

  -- Git 통합
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive' -- Git 명령어 사용

  -- Tree-sitter (더 나은 구문 강조 및 분석)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- 데이터 과학 관련 (선택 사항)
  -- use 'jupyter-vim/jupyter-vim' -- Jupyter 노트북 연동 (설정 복잡할 수 있음)
  -- use 'jpalardy/vim-slime' -- 터미널로 코드 전송 (tmux 또는 다른 터미널 멀티플렉서와 함께 사용)

  -- 자동 Packer 동기화
  if packer_bootstrap then
    packer.sync()
  end
end)

-- --- 플러그인 설정 ---

-- 테마 설정 (예: tokyonight)
local tokyonight_status_ok, tokyonight = pcall(require, "tokyonight")
if not tokyonight_status_ok then
  return
end
tokyonight.setup({ style = "night" }) -- night, storm, day, moon
vim.cmd[[colorscheme tokyonight]]

-- NvimTree 설정
local nvimtree_status_ok, nvimtree = pcall(require, "nvim-tree")
if not nvimtree_status_ok then
  return
end
nvimtree.setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
map('n', '<leader>e', ':NvimTreeToggle<CR>', opts) -- NvimTree 토글

-- Lualine 설정
local lualine_status_ok, lualine = pcall(require, "lualine")
if not lualine_status_ok then
  return
end
lualine.setup {
  options = {
    theme = 'tokyonight',
    -- theme = 'gruvbox',
  }
}

-- Comment.nvim 설정
local comment_status_ok, comment = pcall(require, "Comment")
if not comment_status_ok then
  return
end
comment.setup()

-- nvim-autopairs 설정
local autopairs_status_ok, autopairs = pcall(require, "nvim-autopairs")
if not autopairs_status_ok then
  return
end
autopairs.setup({})

-- Gitsigns 설정
local gitsigns_status_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_status_ok then
  return
end
gitsigns.setup()

-- LSP 설정
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end
local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end
local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

-- LSP 서버 목록 (필요에 따라 추가/제거)
local servers = { "pyright", "bashls", "lua_ls", "jsonls", "yamlls" }

mason.setup()
mason_lspconfig.setup({
  ensure_installed = servers,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- LSP 관련 키매핑
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      map('n', 'gD', vim.lsp.buf.declaration, bufopts) -- 선언으로 이동
      map('n', 'gd', vim.lsp.buf.definition, bufopts) -- 정의로 이동
      map('n', 'K', vim.lsp.buf.hover, bufopts) -- 도움말 표시
      map('n', 'gi', vim.lsp.buf.implementation, bufopts) -- 구현으로 이동
      map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts) -- 작업 공간 폴더 추가
      map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts) -- 작업 공간 폴더 제거
      map('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts) -- 작업 공간 폴더 목록
      map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts) -- 타입 정의로 이동
      map('n', '<leader>rn', vim.lsp.buf.rename, bufopts) -- 이름 변경
      map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts) -- 코드 액션
      map('n', 'gr', vim.lsp.buf.references, bufopts) -- 참조 찾기
      map('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts) -- 코드 포맷팅
    end,
  }
end

-- nvim-cmp (자동완성) 설정
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
  return
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- 위로 스크롤
    ['<C-f>'] = cmp.mapping.scroll_docs(4), -- 아래로 스크롤
    ['<C-Space>'] = cmp.mapping.complete(), -- 자동완성 실행
    ['<C-e>'] = cmp.mapping.abort(), -- 자동완성 닫기
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 선택 항목 확인
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- Tree-sitter 설정
local treesitter_status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status_ok then
  return
end
treesitter.setup {
  ensure_installed = { "python", "lua", "vim", "bash", "json", "yaml", "markdown" }, -- 파서 설치
  sync_install = false, -- 자동으로 파서 설치 (Neovim 시작 시)
  auto_install = true,
  highlight = {
    enable = true, -- 구문 강조 활성화
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true }, -- Tree-sitter 기반 들여쓰기
  rainbow = { -- nvim-ts-rainbow 설정
    enable = true,
    extended_mode = true, -- 더 많은 괄호 종류 지원
    max_file_lines = nil, -- 파일 라인 수 제한 없음
  }
}

-- 데이터 과학을 위한 Python 설정 (예시)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    -- Python 파일 타입일 때만 적용되는 설정
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
    -- 예: F5로 현재 파일 실행 (터미널 필요)
    -- map('n', '<F5>', ':w<CR>:term python %<CR>', {noremap=true, silent=true, buffer=true})
  end
})

print("Neovim 설정 (init.lua) 로드 완료!")
