return {
    cmd = {
        "sh",
        "-c",
        "if command -v uv >/dev/null 2>&1 && uv run --no-sync ty --version >/dev/null 2>&1; then exec uv run --no-sync ty server; else exec ty server; fi",
    },
}

