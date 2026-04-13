# Chezmoi로 Dotfiles 관리 시작하기

Chezmoi는 수많은 **dotfiles**를 여러 환경과 기기에서 일관되게 관리할 수 있도록 도와주는 강력한 도구입니다. 공식 문서에서 설명하듯이, 단 몇 가지 설정만으로 보안까지 챙길 수 있습니다. Dotfiles가 어디에 있는지, 어디에 있어야 하는지는 전혀 신경 쓸 필요가 없습니다. 우리는 그저 chezmoi에게 관리해야 할 dotfile을 알려주기만 하면 됩니다.

## Chezmoi 설치 (사전 준비)

Chezmoi를 사용하기 전에 먼저 설치해야 합니다. 운영체제에 따라 설치 방법은 다음과 같습니다.

  * **macOS (Homebrew 사용):**
    ```bash
    brew install chezmoi
    ```
  * **Linux (apt 사용):**
    ```bash
    sudo apt install chezmoi
    ```
  * **그 외 운영체제:** 공식 문서([https://www.chezmoi.io/install/](https://www.chezmoi.io/install/))를 참고하여 설치해주세요.

-----

## Chezmoi 기본 사용법

### 1\. Chezmoi 초기화

`chezmoi init` 명령어는 로컬 기기의 `~/.local/share/chezmoi` (chezmoi의 **working directory**)에 dotfiles가 저장될 새로운 Git 저장소를 생성합니다. 기본적으로 chezmoi는 working directory의 수정 내용을 로컬 기기에 반영합니다.

```bash
chezmoi init
```

### 2\. Dotfile 추가

`~/.zshrc` 파일을 chezmoi를 통해 관리하고 싶다면 아래 명령어를 실행합니다.

```bash
chezmoi add ~/.zshrc
```

`~/.zshrc` 파일이 `~/.local/share/chezmoi/dot_zshrc`로 복사된 것을 확인할 수 있습니다. chezmoi는 관리 대상 파일 이름 앞에 `dot_` 프리픽스를 붙여 working directory에 저장합니다.

### 3\. Dotfile 수정

chezmoi가 관리하는 `~/.zshrc`를 수정하려면 아래 명령어를 사용합니다.

```bash
chezmoi edit ~/.zshrc
```

이 명령어는 `~/.local/share/chezmoi/dot_zshrc`를 `$EDITOR`로 열어줍니다. 테스트를 위해 몇 가지를 수정하고 저장합니다.

### 4\. 변경 내용 확인

working directory에서 어떤 내용이 변경되었는지는 아래 명령어로 확인합니다.

```bash
chezmoi diff
```

### 5\. 변경 내용 반영

chezmoi의 변경 내역을 로컬 기기에 반영하고 싶다면 아래 명령어를 사용합니다.

```bash
chezmoi apply -v
```

chezmoi의 모든 명령어는 `-v`(verbose) 옵션을 사용할 수 있습니다. 이 옵션은 어떤 내용이 로컬에 반영되는지를 시각적으로 명확하게 확인할 수 있도록 콘솔에 관련 내용을 출력합니다. `-n`(dry run) 옵션을 사용하면 명령이 실행은 되지만 반영되지는 않습니다. 따라서 `-v` 옵션과 `-n` 옵션을 함께 사용함으로써 잘 모르는 명령어를 실행해야 할 때 어떤 동작이 진행되는지 미리 확인해볼 수 있습니다.

### 6\. 원격 저장소에 Push

이제 직접 소스 디렉터리에 접근해서 chezmoi의 내용을 원격 저장소로 push 해보겠습니다. 저장소의 이름은 `dotfiles`로 하는 것을 추천드리는데, 이유는 뒤에서 다시 설명하겠습니다.

```bash
chezmoi cd
git add .
git commit -m "Initial commit with chezmoi dotfiles"
git remote add origin https://github.com/$GITHUB_USERNAME/dotfiles.git
git push -u origin main
```

  * `chezmoi cd`: chezmoi의 working directory로 이동합니다.
  * `git push -u origin main`: `main` 브랜치로 push하며, 이후 `git push`만으로도 해당 브랜치로 푸시할 수 있도록 업스트림을 설정합니다.

> **Tip:** `chezmoi.toml` 파일을 통해 관련 설정을 작성해주면 저장소 동기화 과정을 자동화하여 조금 더 편리하게 사용할 수 있습니다. (`autoCommit`, `autoPush` 등)

chezmoi의 working directory에서 빠져나오기 위해서는 아래 명령을 사용합니다.

```bash
exit
```

여기까지의 과정을 시각적으로 살펴보면 아래와 같습니다.

-----

## 다른 기기에서 Chezmoi 설정 사용하기

드디어 우리가 chezmoi를 쓰는 이유입니다. 두 번째 기기에서 chezmoi를 사용하여 내용을 가져와 보겠습니다. 저는 SSH를 사용하도록 URL을 입력했습니다. 역시 chezmoi가 미리 설치되어 있다고 가정합니다.

### 1\. 원격 저장소에서 초기화

```bash
chezmoi init git@github.com:$GITHUB_USERNAME/dotfiles.git
```

이렇게 특정 저장소를 지정해서 초기화를 수행하면 해당 저장소에 submodule이나 필요한 외부 소스 파일이 있는지 자동으로 확인하게 되고, 옵션에 따라서 chezmoi config 파일을 자동으로 생성해줍니다.

### 2\. 변경 내용 확인

chezmoi가 두 번째 기기에 어떤 변경을 가져올지 위에서 확인해봤던 `diff`를 통해 살펴봅니다.

```bash
chezmoi diff
```

### 3\. 변경 내용 반영

만약 내용을 전부 반영해도 좋을 것 같다면, 역시 살펴봤던 `apply` 명령을 사용합니다.

```bash
chezmoi apply -v
```

로컬에 반영하기 전 일부 파일은 수정해야겠다면 `edit`을 사용해주세요.

```bash
chezmoi edit $FILE
```

또는 merge tool을 사용하여 마치 Git 병합을 사용하는 것처럼 로컬에 변경 내용을 반영할 수도 있습니다.

```bash
chezmoi merge $FILE
```

> **Tip:** `chezmoi merge-all`을 사용하면 병합이 필요한 모든 파일을 대상으로 merge가 동작합니다.

### 4\. 모든 과정을 한 번에 수행

아래 명령어를 사용하면 이 모든 과정을 한 번에 수행합니다.

```bash
chezmoi update -v
```

역시 시각적으로 살펴보면 아래와 같습니다.

### 5\. 초기화 시점에 한 번에 적용

두 번째 기기에서 수행해야 했던 모든 과정을 초기화 시점에 한 번에 적용할 수도 있습니다\! 만약 두 번째 기기가 이제 막 새로 산 기기라면 굉장히 유용할 것 같네요.

```bash
chezmoi init --apply https://github.com/$GITHUB_USERNAME/dotfiles.git
```

제가 앞서 저장소의 이름을 `dotfiles`로 할 것을 추천드렸는데요, 저장소의 이름이 `dotfiles`라면 좀 전의 명령어의 축약형을 사용할 수 있기 때문입니다.

```bash
chezmoi init --apply $GITHUB_USERNAME
```

정말이지, 굉장히 편리합니다\! 가히 2023년에 알게 된 오픈소스 중 최고의 오픈소스가 될 것이라고 말할 수 있을 것 같네요.

-----

## Conclusion (기본 사용법)

chezmoi는 감탄스러울 정도로 문서화가 잘 되어 있고, 상당히 활발하게 개발이 진행되고 있습니다. Golang으로 개발되어서인지 괜히 속도도 빠른 것 같은 느낌이 드네요 😄. 또한 shell script에 대해 어느 정도 지식이 있다면 상당히 수준 높은 자동화도 구현할 수 있어서 여러 기기 간 설정에 있어서 정말 손댈 게 없을 정도로 편리한 환경을 만들 수 있습니다.

이번 글에서는 기본적인 사용법에 대해 다루었으니, 다음 글에서는 기본적인 chezmoi의 설정 파일 관리 및 보안성 유지에 대해서 살펴보겠습니다.

-----

# Chezmoi, 본격적으로 활용하기

어떻게 사용해야 할까요? chezmoi의 명령어 사용법은 `chezmoi help` 및 공식 문서에서 확인할 수 있으니, 이 글에서는 chezmoi를 좀 더 편리하게 사용하기 위한 응용을 설명해봅니다.

-----

## Settings

chezmoi는 `~/.config/chezmoi/chezmoi.toml` 파일을 설정으로 사용합니다. 만약 툴 관련 설정이 필요하다면 이 파일을 사용하여 정의해주면 되고, TOML뿐만 아니라 YAML, JSON까지 지원하니 익숙한 포맷으로 작성해주면 됩니다. 공식 문서에는 TOML로 가이드하기 때문에 저도 TOML을 기본으로 설명합니다.

### 1\. Merge Tool 및 기본 에디터 설정

chezmoi는 기본 에디터로 `vi`를 사용합니다. 저는 `nvim`을 주로 사용하기 때문에 기본 에디터로 `nvim`이 실행되도록 수정해보겠습니다.

```bash
chezmoi edit-config
```

`~/.config/chezmoi/chezmoi.toml` 파일에 다음 내용을 추가하거나 수정합니다.

```toml
[edit]
    command = "nvim"

[merge]
    command = "nvim"
    args = ["-d", "{{ .Destination }}", "{{ .Source }}", "{{ .Target }}"]
```

VS Code를 사용하신다면 아래처럼 설정해주시면 됩니다.

```toml
[edit]
    command = "code"
    args = ["--wait"]
```

### 2\. 템플릿을 활용한 Git 설정 관리

가끔은 통일된 설정이 아닌 분리된 설정이 필요할 수 있습니다. 예를 들면 회사와 개인 환경의 `gitconfig` 같은 경우가 있겠네요. 전체적으로는 비슷하지만 특정 부분의 데이터만 분리되어야 하는 경우, 이럴 때를 위해 chezmoi에서는 **템플릿**이라고 부르는 일종의 환경 변수 주입 방식을 통해 제어할 수 있습니다.

먼저 `gitconfig` 파일을 만들어줍니다.

```bash
mkdir -p ~/.config/git
touch ~/.config/git/config
```

`gitconfig`를 템플릿으로 등록하여 변수를 사용할 수 있도록 해줍니다.

```bash
chezmoi add --template ~/.config/git/config
```

데이터 치환이 필요한 부분을 작성해줍니다.

```bash
chezmoi edit ~/.config/git/config
```

파일 내용은 다음과 같이 작성합니다.

```
[user]
    name = {{ .name }}
    email = {{ .email }}
```

이 중괄호는 로컬 환경에서 정의한 변수가 들어가게 됩니다. 기본 변수 목록은 `chezmoi data`로 확인할 수 있습니다.

변수는 `chezmoi.toml`에 작성해줍니다.

```bash
# chezmoi edit-config 가 아닌 로컬 설정을 작성해줍니다.
vi ~/.config/chezmoi/chezmoi.toml
```

파일 내용은 다음과 같이 작성합니다.

```toml
[data]
    name = "privateUser"
    email = "private@gmail.com"
```

다 작성한 후 `chezmoi apply -vn` 혹은 `chezmoi init -vn`을 사용해보면 템플릿 변수에 data 값으로 채워져서 config 파일이 생성되는 것을 확인할 수 있습니다.

### 3\. 자동 Commit 및 Push 설정

`chezmoi edit`을 사용해 dotfile을 수정한다고 해서 로컬 저장소의 Git에 자동으로 반영되지는 않습니다.

```bash
# 수작업으로 해줘야 합니다.
chezmoi cd
git add .
git commit -m "update something"
git push
```

이 과정을 자동으로 하기 위해서는 `chezmoi.toml`에 설정을 추가해줘야 합니다.

```bash
# ~/.config/chezmoi/chezmoi.toml
[git]
    # autoAdd = true # 파일을 자동으로 추가합니다.
    autoCommit = true # add + commit을 자동으로 수행합니다.
    autoPush = true # commit 후 자동으로 push 합니다.
```

다만 push까지 자동으로 할 경우, 보안에 민감한 파일이 실수로 원격 저장소에 올라갈 수 있어서 개인적으로는 commit까지만 `auto` 옵션을 활성화하시는 것을 추천드립니다.

### 4\. Brew 패키지 관리

회사에서 업무 중 좋은 툴을 찾았다면, 잊지 말고 개인 환경에서도 설치해줘야 하죠. chezmoi로 관리해봅니다.

```bash
chezmoi cd
vi run_once_before_install-packages-darwin.sh.tmpl
```

`run_once_`는 chezmoi가 사용하는 스크립트 키워드입니다. 이전에 실행된 적이 없을 때만 실행시키고 싶을 때 사용합니다. `before_` 키워드를 사용하면 dotfiles 생성 이전에 스크립트를 먼저 동작시킵니다. 이 키워드들을 사용하여 작성된 스크립트가 실행되는 경우는 2가지 경우가 있습니다.

1.  한 번도 실행된 적이 없는 경우 (최초 설정)
2.  스크립트 자체가 수정되었을 경우 (업데이트)

이 동작을 응용하여 `brew bundle`을 스크립팅해두면 모든 환경에서 통일된 brew package를 사용할 수 있게 됩니다. 다음은 제가 사용하고 있는 스크립트입니다.

```
# MacOS 에서만 실행
{{- if eq .chezmoi.os "darwin" -}}
#!/bin/bash

PACKAGES=(
    asdf
    exa
    ranger
    chezmoi
    difftastic
    gnupg
    fzf
    gh
    glab
    htop
    httpie
    neovim
    nmap
    starship
    daipeihust/tap/im-select
)

CASKS=(
    alt-tab
    shottr
    raycast
    docker
    hammerspoon
    hiddenbar
    karabiner-elements
    obsidian
    notion
    slack
    stats
    visual-studio-code
    warp
    wireshark
    google-chrome
)

# If Homebrew is not installed on the system, it will be installed here
if ! command -v brew >/dev/null 2>&1; then
   printf '\n\n\e[33mHomebrew not found. \e[0mInstalling Homebrew...'
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
 printf '\n\n\e[0mHomebrew found. Continuing...'
fi

# Update homebrew packages
printf '\nInitiating Homebrew update...\n'
brew update

printf '\nInstalling packages...\n'
brew install "${PACKAGES[@]}"

printf '\n\nRemoving out of date packages...\n'
brew cleanup

printf '\n\nInstalling cask apps...\n'
brew install --cask "${CASKS[@]}"

{{ end -}}
```

`sh`에 익숙하지 않더라도 이해하기 크게 어렵지 않으리라 생각합니다. `PACKAGES` 목록은 `brew install`로 설치하는 패키지들을, `CASKS`에는 `brew install --cask`로 설치하는 애플리케이션들을 정의해주시면 이후 스크립트에 의해 설치 과정이 진행됩니다.

스크립트는 chezmoi로 사용할 수 있는 기능 중에 상대적으로 복잡한 편입니다. 다양한 응용 방식이 있고 같은 기능을 다르게 정의할 수도 있습니다. 좀 더 자세한 사용방법은 공식 문서를 참고해주세요.

-----

## Conclusion (활용)

이번 글에서는 기본 사용법을 설명했던 지난 글에 이어, chezmoi의 유용한 설정들에 대해 정리해보았습니다. 마지막에 소개해드린 스크립트 사용법은 기본 설정이라는 타이틀이 무색하게도 다소 복잡한 내용이지만, 적용해두면 굉장히 편리하게 사용할 수 있어서 넣어보았습니다.

-----

## Reference

  * [https://haril.dev/blog/2023/03/26/chezmoi-awesome-dotfile-manager](https://haril.dev/blog/2023/03/26/chezmoi-awesome-dotfile-manager)
