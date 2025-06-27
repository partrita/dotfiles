-- WezTerm 설정 파일
-- ~/.config/wezterm/wezterm.lua

local wezterm = require 'wezterm'
local act = wezterm.action

local config = {}

-- WezTerm 최신 버전에서는 config 객체를 직접 수정하는 대신
-- wezterm.on('event-name', handler) 와 같은 이벤트 기반 설정을 사용할 수 있습니다.
-- 하지만 기존 방식도 여전히 유효합니다.
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- --- 기본 설정 ---
config.term = 'wezterm' -- 터미널 타입 설정
config.window_decorations = "RESIZE" -- 창 장식 (RESIZE 핸들만 표시)
-- config.window_decorations = "NONE" -- 창 장식 없음 (타일링 매니저와 사용 시 유용)
-- config.window_decorations = "FULL" -- 전체 창 장식

-- --- 글꼴 설정 ---
config.font = wezterm.font('JetBrains Mono', { weight = 'Regular', stretch='Normal', style='Normal'})
-- Nerd Font 사용 시 (아이콘 표시)
-- config.font = wezterm.font('Hack Nerd Font Mono', {weight='Regular', stretch='Normal', style='Normal'})
config.font_size = 12.0
-- config.line_height = 1.2 -- 줄 간격

-- --- 색상 테마 ---
-- 내장 테마 사용 예시
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = 'Tokyo Night Storm'
config.color_scheme = 'Catppuccin Mocha' -- 예시: Catppuccin 테마
-- 사용자 정의 테마 (아래 colors 섹션 참조)

-- config.colors = {
--   foreground = '#d8d8d8',
--   background = '#181818',
--   cursor_bg = '#c0c0c0',
--   cursor_fg = '#181818',
--   -- ... 기타 색상 설정 ...
--   -- ANSI 색상
--   ansi = {
--     '#000000', -- 검정
--     '#cc0000', -- 빨강
--     '#4e9a06', -- 초록
--     '#c4a000', -- 노랑
--     '#3465a4', -- 파랑
--     '#75507b', -- 자홍
--     '#06989a', -- 청록
--     '#d3d7cf', -- 밝은 회색
--   },
--   brights = {
--     '#555753', -- 어두운 회색
--     '#ef2929', -- 밝은 빨강
--     '#8ae234', -- 밝은 초록
--     '#fce94f', -- 밝은 노랑
--     '#729fcf', -- 밝은 파랑
--     '#ad7fa8', -- 밝은 자홍
--     '#34e2e2', -- 밝은 청록
--     '#eeeeec', -- 흰색
--   },
-- }

-- --- 창 및 탭 설정 ---
config.enable_tab_bar = true -- 탭 바 표시 여부
config.hide_tab_bar_if_only_one_tab = true -- 탭이 하나일 때 탭 바 숨기기
config.window_padding = { -- 창 내부 여백
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}
-- config.inactive_pane_hsb = { -- 비활성 창의 색조, 채도, 밝기 조정
--   saturation = 0.9,
--   brightness = 0.7,
-- }

-- --- 키 바인딩 ---
config.keys = {
  -- 탭 관련
  { key = 't', mods = 'CMD', action = act.SpawnTab 'CurrentPaneDomain' }, -- 새 탭 (macOS CMD, 다른 OS는 SUPER 또는 CTRL)
  { key = 'w', mods = 'CMD', action = act.CloseCurrentTab { confirm = true } }, -- 현재 탭 닫기
  { key = ']', mods = 'CMD', action = act.ActivateTabRelative(1) }, -- 다음 탭으로 이동
  { key = '[', mods = 'CMD', action = act.ActivateTabRelative(-1) }, -- 이전 탭으로 이동
  -- CMD + 숫자 로 특정 탭 이동 (1부터 9까지)
  -- { key = '1', mods = 'CMD', action = act.ActivateTab(0) },
  -- { key = '2', mods = 'CMD', action = act.ActivateTab(1) },
  -- ...

  -- 창 분할 (Pane)
  { key = 'd', mods = 'CMD', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- 가로 분할
  { key = 'D', mods = 'CMD|SHIFT', action = act.SplitVertical { domain = 'CurrentPaneDomain' } }, -- 세로 분할 (Shift+Cmd+D)
  { key = 'x', mods = 'CMD', action = act.CloseCurrentPane { confirm = true } }, -- 현재 창 닫기

  -- 창 이동
  { key = 'h', mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'j', mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'l', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },

  -- 복사 및 붙여넣기 (기본값으로도 잘 동작하지만, 명시적으로 설정 가능)
  { key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },

  -- 텍스트 크기 조절
  { key = '=', mods = 'CMD', action = act.IncreaseFontSize },
  { key = '-', mods = 'CMD', action = act.DecreaseFontSize },
  { key = '0', mods = 'CMD', action = act.ResetFontSize },

  -- 명령 팔레트
  { key = 'P', mods = 'CMD|SHIFT', action = act.ShowLauncher },

  -- 데이터 과학 작업에 유용한 단축키 (예시)
  -- {
  --   key = 'j', mods = 'CTRL|SHIFT',
  --   action = act.SpawnCommandInNewTab {
  --     args = { 'jupyter', 'lab', '--no-browser' },
  --     -- cwd = '/path/to/my/projects' -- 작업 디렉토리 설정 (선택 사항)
  --   }
  -- },
  -- {
  --   key = 'n', mods = 'CTRL|SHIFT',
  --   action = act.SpawnCommandInNewWindow {
  --     args = { 'nvim' },
  --   }
  -- },
}

-- macOS 사용자를 위한 CMD 키 설정 (다른 OS는 mods를 'CTRL' 또는 'SUPER' 등으로 변경)
if wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin" then
  config.leader = { key = 'a', mods = 'CMD', timeout_milliseconds = 1000 }

  -- 기존 CMD 키 조합을 유지하면서 다른 조합을 추가하고 싶을 경우,
  -- 위 config.keys 테이블에 직접 mods = 'CMD' 로 추가하면 됩니다.
  -- 만약 다른 OS 와 설정을 공유하고 싶다면, OS 별로 mods 를 다르게 설정하는 로직이 필요합니다.
  -- 예: local cmd_mod = wezterm.target_triple:find("apple") and "CMD" or "CTRL"
  --     { key = 't', mods = cmd_mod, action = act.SpawnTab 'CurrentPaneDomain' },
end


-- --- URL 클릭 시 동작 ---
-- 기본적으로 WezTerm이 URL을 감지하고 열 수 있도록 합니다.
-- 특정 URL 패턴에 대해 다른 동작을 지정할 수도 있습니다.
-- config.hyperlink_rules = {
--   {
--     regex = '\\b\\w+://[\\w.-]+(?:\\.[a-zA-Z]{2,}){1,}(?:/[^\\s]*)?',
--     format = '$0',
--     action = wezterm.action.OpenLink,
--   },
-- }

-- --- 마우스 설정 ---
-- config.mouse_bindings = {
--   -- 예: 오른쪽 클릭으로 메뉴 열기 (기본값)
--   {
--     event = { Up = { streak = 1, button = 'Right' } },
--     mods = 'NONE',
--     action = wezterm.action.SpawnContextMenu,
--   },
--   -- 예: Ctrl + 마우스 휠로 글꼴 크기 조절
--   {
--     event = { Wheel = { direction = 'Up' } },
--     mods = 'CTRL',
--     action = wezterm.action.IncreaseFontSize,
--   },
--   {
--     event = { Wheel = { direction = 'Down' } },
--     mods = 'CTRL',
--     action = wezterm.action.DecreaseFontSize,
--   },
-- }

-- --- 스크롤백 설정 ---
config.scrollback_lines = 5000 -- 스크롤백 라인 수

-- --- 기본 프로그램 설정 ---
-- WezTerm 시작 시 실행될 기본 프로그램 (예: zsh, bash)
-- config.default_prog = {'/bin/zsh', '-l'}
-- config.default_prog = {'/bin/bash', '-l'}

-- --- 창 제목 설정 ---
-- wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
--   local title = tab.active_pane.title
--   return "[" .. tab.tab_index + 1 .. "] " .. title
-- end)

-- --- 도메인 설정 (SSH 연결 등) ---
-- config.ssh_domains = {
--   {
--     name = 'my-server', -- WezTerm 내에서 사용할 이름
--     remote_address = 'user@hostname_or_ip', -- 실제 SSH 주소
--     -- ssh_config_file = '~/.ssh/config', -- SSH 설정 파일 경로 (선택 사항)
--     -- wezterm_access_token = '...', -- WezTerm multiplexing 토큰 (선택 사항)
--   },
-- }
-- -- 사용법: wezterm connect my-server

-- --- 시작 시 실행할 명령어 ---
-- config.launch_menu = {
--   { label = 'Neovim', args = {'nvim'} },
--   { label = 'LazyGit', args = {'lazygit'} },
--   { label = 'Bash', args = {'bash', '-l'} },
--   {
--     label = 'Jupyter Lab (no browser)',
--     args = {'jupyter', 'lab', '--no-browser'},
--     -- cwd = '~/projects/datascience' -- 시작 디렉토리
--   },
-- }


wezterm.log_error('WezTerm 설정 (wezterm.lua) 로드 완료!')
return config
