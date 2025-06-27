# Jupyter Notebook 설정 파일입니다.
# `jupyter notebook --generate-config` 명령으로 생성할 수 있습니다.

c = get_config()

# --- 서버 설정 ---
# c.NotebookApp.allow_origin = '*' # 모든 출처에서의 접근 허용 (보안에 유의)
# c.NotebookApp.allow_remote_access = True # 원격 접속 허용 (보안에 유의)
# c.NotebookApp.ip = '0.0.0.0' # 모든 IP에서 접속 허용 (원격 접속 시 필요)
c.NotebookApp.open_browser = False # 노트북 실행 시 브라우저 자동 실행 방지
c.NotebookApp.port = 8888 # 기본 Jupyter Notebook 실행 포트
# c.NotebookApp.password = 'sha1:...' # 암호 설정 (jupyter notebook password 명령으로 생성)
# c.NotebookApp.notebook_dir = '~/my_notebooks' # 기본 노트북 디렉토리 설정
# c.NotebookApp.token = '' # 토큰 인증 비활성화 (보안에 매우 유의, 암호 설정 권장)

# --- 커널 설정 ---
# c.MappingKernelManager.default_kernel_name = 'python3' # 기본 커널 설정

# --- 출력 설정 ---
c.InteractiveShellApp.matplotlib = 'inline' # Matplotlib 그래프를 노트북 내에 인라인으로 표시
# c.InteractiveShellApp.extensions = [ # 자동 로드할 확장 기능
#     'autoreload'
# ]
# c.InteractiveShellApp.exec_lines = [ # 시작 시 실행할 코드
#     '%autoreload 2',
#     'import pandas as pd',
#     'import numpy as np',
#     'import matplotlib.pyplot as plt',
#     'import seaborn as sns',
#     "print('Pandas, NumPy, Matplotlib, Seaborn loaded.')"
# ]

# --- 파일 저장 설정 ---
# c.FileContentsManager.autosave_interval = 120 # 자동 저장 간격 (초)
# c.FileCheckpoints.checkpoint_dir = '.checkpoints' # 체크포인트 저장 디렉토리

# --- 테마 및 UI 설정 (확장 기능 필요) ---
# 예: JupyterLab 테마 설정
# c.LabApp.theme = 'JupyterLab Dark'

# --- 기타 유용한 설정 ---
# c.NotebookApp.iopub_data_rate_limit = 10000000 # 데이터 전송률 제한 늘리기 (큰 데이터셋 처리 시)
# c.ContentsManager.preferred_dir = '.' # 파일 브라우저 시작 위치 (현재 디렉토리)

# 이 설정들은 예시이며, 필요에 따라 주석을 해제하거나 값을 변경하여 사용하세요.
# 설정을 변경한 후에는 Jupyter Notebook 서버를 재시작해야 적용됩니다.
