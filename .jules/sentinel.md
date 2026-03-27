## 2024-03-27 - [Bash History Security Enhancement]
**Vulnerability:** Bash history default configuration logs sensitive data (secrets, tokens, passwords) entered in the command line if not filtered, which poses a risk of credential leakage.
**Learning:** Development environments often leave shell history un-sanitized, potentially exposing temporary exported secrets or keys used in ad-hoc scripts.
**Prevention:** Always implement `HISTCONTROL=ignoreboth` and `HISTIGNORE='*password*:*secret*:*key*:*token*:*sudo -S*'` in bash dotfiles to prevent commands containing sensitive terms or prefixed with a space from being recorded.
