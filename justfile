set windows-shell := ["powershell.exe", "-NoLogo", "-NoProfile", "-ExecutionPolicy", "Bypass", "-Command"]

default:
    just --list

# Build the Mod Portal zip under ./target.
build:
    python build_personal_respawn_anchor.py

# Build and copy the zip into the local server manager mods directory.
install-local:
    python build_personal_respawn_anchor.py --install-local

# Run public-repo safety checks.
secrets:
    uvx pre-commit run gitleaks --all-files

# Run all pre-commit checks.
precommit:
    uvx pre-commit run --all-files

# Install git hooks.
hook-install:
    uvx pre-commit install
