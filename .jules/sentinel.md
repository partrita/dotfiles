## 2024-03-27 - [Bash History Security Enhancement]
**Vulnerability:** Bash history default configuration logs sensitive data (secrets, tokens, passwords) entered in the command line if not filtered, which poses a risk of credential leakage.
**Learning:** Development environments often leave shell history un-sanitized, potentially exposing temporary exported secrets or keys used in ad-hoc scripts.
**Prevention:** Always implement `HISTCONTROL=ignoreboth` and `HISTIGNORE='*password*:*secret*:*key*:*token*:*sudo -S*'` in bash dotfiles to prevent commands containing sensitive terms or prefixed with a space from being recorded.

## 2024-05-18 - [Prevent Local Hijacking in Environment Variables]
**Vulnerability:** Assigning `export LD_LIBRARY_PATH=/path:$LD_LIBRARY_PATH` when the variable is initially empty results in a trailing colon. This evaluates to the current working directory, introducing a local library hijacking vulnerability.
**Learning:** Hardcoded `$PATH` or `$LD_LIBRARY_PATH` concatenations often fail to account for the empty state of these variables, silently exposing the system to directory traversal or hijacking risks.
**Prevention:** Always use conditional parameter expansion (e.g., `${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}`) to append to path lists, ensuring colons are only added when the variable is non-empty.

## 2024-04-02 - [Prevent Re-sourcing Errors with Readonly Variables]
**Vulnerability:** Assigning `readonly` to a variable like `TMOUT` without checking if it is already read-only causes the bash script to error and stop execution when re-sourced. Using naive checks like `readonly -p | grep -qw TMOUT` or `[[ ! "$(declare -p TMOUT)" =~ "declare -r" ]]` introduces a bypass because they match substrings in the entire output, including other variables' values (e.g. `declare -r MYVAR="TMOUT"` or `export TMOUT="declare -r"`).
**Learning:** Checking for `readonly` status requires strict matching to avoid value spoofing and correctly handle alphabetical flag ordering.
**Prevention:** Always use `readonly -p | grep -q "^declare -[^ =]*r[^ =]* VAR_NAME="` to strictly verify if a variable is marked as read-only by matching only the declaration part. Example: `if ! readonly -p | grep -q "^declare -[^ =]*r[^ =]* TMOUT="; then TMOUT=600; readonly TMOUT; export TMOUT; fi`.

## 2024-04-06 - Enforce Audit Logging Integrity
**Vulnerability:** Bash history variables (`HISTFILE`, `HISTSIZE`, `HISTIGNORE`, `HISTCONTROL`, `HISTTIMEFORMAT`) were mutable. A local attacker or malicious script could unset or modify them (e.g., `export HISTFILE=/dev/null`) to cover their tracks and bypass audit logging.
**Learning:** Setting security-critical bash variables is insufficient if they can be easily overridden later in the session.
**Prevention:** Apply `readonly` to history-related variables to ensure audit logging remains active and cannot be tampered with. Check if they are already readonly before applying to allow re-sourcing of the file without errors.

## 2026-04-07 - [Bash Array Expansion Security]
**Vulnerability:** Unquoted array expansions (e.g., `${ARRAY[@]}`) in shell scripts allow word splitting. This can lead to unintended package installations or command injection if an array contains strings with spaces.
**Learning:** Even when arrays contain seemingly static data, they should be quoted defensively to prevent vulnerabilities during future modifications or if they eventually handle dynamic data.
**Prevention:** Always use `"${ARRAY[@]}"` instead of `${ARRAY[@]}` to preserve elements as single words.

## 2024-04-08 - [Disable Core Dumps to Prevent Information Disclosure]
**Vulnerability:** By default, Linux systems might be configured to generate core dumps when a program crashes. These files contain the memory state of the process at the time of the crash. If a process handling sensitive data (passwords, API keys, private keys, authentication tokens) crashes, this sensitive information can be written to disk in plain text within the core dump file, making it accessible to anyone with read access to the file.
**Learning:** Development and general user environments often overlook process memory lifecycle. While debugging symbols and memory dumps are useful for developers, leaving them enabled globally in dotfiles poses a significant and unnecessary risk of post-crash credential exposure.
**Prevention:** Disable core dump generation at the shell level in startup scripts (e.g., `.bashrc`, `dot_bashrc`) by adding `ulimit -S -c 0`. This acts as a defense-in-depth measure, ensuring that even if an application fails securely in code, its memory footprint isn't inadvertently leaked to the file system.

## 2024-04-09 - [Prevent Data Leakage via Editor Swap and Backup Files]
**Vulnerability:** By default, Vim and Neovim often create `.swp`, backup (`~`), and undo files in the current working directory. If a user edits sensitive files (e.g., `.env`, `credentials.json`) in a webroot or git repository, a crash or interrupted session can leave these temporary files behind. These files contain sensitive plaintext data and can be accidentally committed to source control or exposed directly over the web if the directory is publicly accessible.
**Learning:** Default editor behaviors prioritize local recovery over data compartmentalization. Leaving state files in the same directory as the target file is a classic vector for accidental information disclosure.
**Prevention:** Explicitly configure editor profiles (`.vimrc` and `init.lua`) to centralize all backup, swap, and undo files in a dedicated, out-of-band directory (e.g., `~/.vim/swap` or `~/.local/share/nvim/swap`) rather than the working directory.
