return {
  -- Prefer the repository root over nested Python package roots. This keeps
  -- workspace venvs like ~/dev/evaluation/.venv visible to basedpyright.
  root_markers = {
    "pyrightconfig.json",
    ".git",
    "uv.lock",
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
  },
  before_init = function(_, config)
    local python = config.root_dir and (config.root_dir .. "/.venv/bin/python") or nil
    if python and vim.uv.fs_stat(python) then
      config.settings = config.settings or {}
      config.settings.python = config.settings.python or {}
      config.settings.python.defaultInterpreterPath = python
      config.settings.python.pythonPath = python
    end
  end,
  settings = {
    basedpyright = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        indexing = true,
        typeCheckingMode = "standard",
      },
    },
    python = {
      -- basedpyright resolves "venv" relative to "venvPath".
      venvPath = ".",
      venv = ".venv",
    },
  },
}

