# uv Quick Reference

`uv` is a fast Python package manager written in Rust. It's 10-100x faster than pip.

## Installation

Already installed at: `~/.local/bin/uv`

## Common Commands

### Project Management
```bash
# Create a new Python project
uv init my-project

# Navigate and create virtual environment
cd my-project
uv venv

# Add a dependency
uv add requests

# Add a dev dependency
uv add --dev pytest

# Remove a dependency
uv remove requests

# Sync dependencies (install from pyproject.toml)
uv sync

# Update all dependencies
uv lock --upgrade
```

### Running Code
```bash
# Run a Python script in the project environment
uv run script.py

# Run a command
uv run python -m pytest

# Run a one-off tool (like pipx)
uvx black .
uvx ruff check
uvx mypy .
```

### Python Version Management
```bash
# Install a specific Python version
uv python install 3.12

# List installed Python versions
uv python list

# Pin project to specific Python version
uv python pin 3.12
```

### Direct pip Replacement
```bash
# Install package (creates/uses .venv)
uv pip install requests

# Install from requirements.txt
uv pip install -r requirements.txt

# Freeze dependencies
uv pip freeze > requirements.txt

# Uninstall package
uv pip uninstall requests
```

### Tool Management (pipx replacement)
```bash
# Install and run a tool once
uvx black .
uvx ruff check
uvx mypy src/

# Install a tool globally
uv tool install black
uv tool install ruff

# List installed tools
uv tool list

# Uninstall a tool
uv tool uninstall black
```

## Migration Guide

### From pip
```bash
# Old
pip install requests
pip install -r requirements.txt
pip freeze > requirements.txt

# New
uv add requests
uv sync
uv pip freeze > requirements.txt
```

### From pipx
```bash
# Old
pipx install black
pipx run black .

# New
uv tool install black
uvx black .
```

### From poetry/pdm
```bash
# uv supports pyproject.toml and works similarly
uv add requests    # poetry add / pdm add
uv sync            # poetry install / pdm install
uv run pytest      # poetry run / pdm run
```

## Project Structure

When you create a project with `uv init`, you get:

```
my-project/
├── .python-version    # Pinned Python version
├── pyproject.toml     # Project metadata + dependencies
├── uv.lock           # Locked dependencies (like poetry.lock)
├── .venv/            # Virtual environment
└── src/
    └── my_project/
        └── __init__.py
```

## Advantages

- **Speed:** 10-100x faster than pip
- **Modern:** Built-in lock files, virtual env management
- **Compatibility:** Works with existing pyproject.toml, requirements.txt
- **All-in-one:** Replaces pip, pip-tools, pipx, poetry, pyenv
- **Reliable:** Reproducible installs with lock files

## Configuration

uv reads from `pyproject.toml` and supports standard Python packaging conventions.

Example `pyproject.toml`:
```toml
[project]
name = "my-project"
version = "0.1.0"
requires-python = ">=3.10"
dependencies = [
    "requests>=2.31.0",
    "fastapi>=0.104.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.4.0",
    "black>=23.0.0",
    "ruff>=0.1.0",
]

[tool.uv]
dev-dependencies = [
    "pytest>=7.4.0",
]
```

## Shell Aliases

Available in your shell:
- `uvr` = `uv run`
- `uvi` = `uv init`
- `uva` = `uv add`

## Learn More

- GitHub: https://github.com/astral-sh/uv
- Docs: https://docs.astral.sh/uv/
