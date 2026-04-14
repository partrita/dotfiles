# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# 셸 옵션 설정
# 히스토리 크기 설정
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# Security: Require verification before executing history expansion (e.g., !!)
shopt -s histverify

# Security: Ignore history logging of commands starting with space or containing sensitive keywords
HISTCONTROL=ignoreboth
HISTIGNORE='*password*:*secret*:*key*:*token*:*sudo -S*'

# Security: Add timestamps to history for audit logging and flush immediately
export HISTTIMEFORMAT="%F %T "
export PROMPT_COMMAND="history -a; ${PROMPT_COMMAND:-}"

# Security: Prevent tampering with history variables by making them readonly
for var in HISTFILE HISTSIZE HISTFILESIZE HISTIGNORE HISTCONTROL HISTTIMEFORMAT; do
    if ! readonly -p | grep -q "^declare -[^ =]*r[^ =]* ${var}="; then
        readonly ${var}
    fi
done

# Security: Set default file permissions (readable/writable by user, readable by group, inaccessible by others)
umask 027

# Security: Auto-logout idle sessions after 10 minutes
if ! readonly -p | grep -q "^declare -[^ =]*r[^ =]* TMOUT="; then
    TMOUT=600
    readonly TMOUT
    export TMOUT
fi

# Security: Disable core dumps to prevent sensitive data exposure from process memory on crash
ulimit -S -c 0

# 프롬프트 설정 (사용자명@호스트명:현재경로$)
PS1='\[\e[32m\]\u@\h\[\e[00m\]:\[\e[34m\]\w\[\e[00m\]\$ '

# 자주 사용하는 명령어 alias 설정
alias ll='ls -alF' # 자세히 보기
alias la='ls -A'   # 숨김 파일 포함
alias l='ls -CF'   # 컬러 출력

# Jupyter Notebook 기본 설정
# 자동완성 기능 활성화 (Tab 키)
# (Jupyter 자체 설정 파일에서 주로 관리하지만, 편의상 bashrc에 추가적인 설정을 넣을 수도 있습니다.)
# 예: 특정 가상환경 자동 활성화
# source ~/myenv/bin/activate

# Pandas DataFrame 출력 옵션
# (Python 스크립트나 Jupyter Notebook 내에서 설정하는 것이 일반적입니다.)
# 예: pd.set_option('display.max_rows', 500)
#     pd.set_option('display.max_columns', 500)

# Matplotlib/Seaborn 스타일 설정
# (Python 스크립트나 Jupyter Notebook 내에서 설정하는 것이 일반적입니다.)
# 예: import matplotlib.pyplot as plt
#     plt.style.use('ggplot')

# 기본 편집기 설정
export EDITOR=nvim
# export EDITOR=vim # Neovim을 기본으로 사용하고, vim은 주석 처리

# PATH 환경변수 추가 (필요시)
# export PATH="/usr/local/opt/python/libexec/bin${PATH:+:${PATH}}"

# 데이터 사이언스 프로젝트용 디렉토리 바로가기 (예시)
alias cdproject='cd ~/projects/datascience'

# Git 관련 alias
alias gco='git checkout'
alias gbr='git branch'
alias gst='git status'
alias gadd='git add .'
alias gcmsg='git commit -m'

# Anaconda/Miniconda 초기화 (설치된 경우)
# if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
#     . "$HOME/anaconda3/etc/profile.d/conda.sh"
# else
#     if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "$HOME/miniconda3/etc/profile.d/conda.sh"
#     fi
# fi
# unset __conda_setup # 주석 처리 또는 삭제하여 conda 자동 활성화 방지 가능

# Jupyter Notebook 설정 파일 생성 (jupyter_notebook_config.py)
# 이 파일은 보통 `jupyter notebook --generate-config` 명령으로 생성됩니다.
# 아래는 예시이며, 실제 적용은 해당 파일을 직접 수정해야 합니다.
# c = get_config()
# c.NotebookApp.open_browser = False  # 노트북 실행 시 브라우저 자동 실행 방지
# c.NotebookApp.port = 8889  # 기본 포트 변경
# c.NotebookApp.notebook_dir = '~/notebooks' # 기본 노트북 디렉토리 변경
# c.InteractiveShellApp.matplotlib = 'inline' # Matplotlib 그림을 노트북 내에 표시

# ~/.vimrc 또는 ~/.config/nvim/init.lua 예시 (Vim/Neovim 사용자를 위한 설정)
# 이 설정들은 각 편집기의 설정 파일에서 관리하는 것이 좋습니다.
# .bashrc 에서는 주로 셸 환경과 관련된 별칭, 환경 변수, 셸 옵션 등을 다룹니다.

# 이 파일은 예시이며, 사용자의 환경과 필요에 맞게 수정해야 합니다.
# 특히 Python 라이브러리(Pandas, Matplotlib 등) 설정은
# Python 스크립트나 Jupyter Notebook 내부에서 하는 것이 일반적입니다.

# i3, WezTerm, Neovim 사용 시 추가적인 셸 설정 (예: 환경 변수)
# if type i3 > /dev/null 2>&1; then
#   # i3 관련 셸 설정
#   # 예: export SOME_VAR_FOR_I3="value"
# fi

# if type wezterm > /dev/null 2>&1; then
#   # WezTerm 관련 셸 설정
# fi

# if type nvim > /dev/null 2>&1; then
#   # Neovim 관련 셸 설정
#   # Neovim 플러그인 관리를 위한 PATH 설정 등
#   # export PATH="$HOME/.local/share/nvim/mason/bin${PATH:+:${PATH}}" # Mason LSP 설치 경로 (예시)
# fi
