## 2024-03-27 - [Bash History Security Enhancement]
**Vulnerability:** Bash history default configuration logs sensitive data (secrets, tokens, passwords) entered in the command line if not filtered, which poses a risk of credential leakage.
**Learning:** Development environments often leave shell history un-sanitized, potentially exposing temporary exported secrets or keys used in ad-hoc scripts.
**Prevention:** Always implement `HISTCONTROL=ignoreboth` and `HISTIGNORE='*password*:*secret*:*key*:*token*:*sudo -S*'` in bash dotfiles to prevent commands containing sensitive terms or prefixed with a space from being recorded.

## 2024-05-18 - [Prevent Local Hijacking in Environment Variables]
**Vulnerability:** Assigning `export LD_LIBRARY_PATH=/path:$LD_LIBRARY_PATH` when the variable is initially empty results in a trailing colon. This evaluates to the current working directory, introducing a local library hijacking vulnerability.
**Learning:** Hardcoded `$PATH` or `$LD_LIBRARY_PATH` concatenations often fail to account for the empty state of these variables, silently exposing the system to directory traversal or hijacking risks.
**Prevention:** Always use conditional parameter expansion (e.g., `${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}`) to append to path lists, ensuring colons are only added when the variable is non-empty.
