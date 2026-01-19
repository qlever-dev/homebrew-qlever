#!/usr/bin/env python3
"""Fix up the generated qlever-control formula."""

import re
from pathlib import Path

formula_path = Path("Formula/qlever-control.rb")
content = formula_path.read_text()

# Rename class from Qlever to QleverControl
content = re.sub(
    r"class Qlever <",
    "class QleverControl <",
    content
)

# Fix description
content = re.sub(
    r'desc "Shiny new formula"',
    'desc "Command-line tool for QLever graph database"',
    content
)

# Fix homepage
content = re.sub(
    r'homepage ".*?"',
    'homepage "https://github.com/ad-freiburg/qlever-control"',
    content
)

# Add license after homepage if not present
if 'license "' not in content:
    content = re.sub(
        r'(homepage "https://github.com/ad-freiburg/qlever-control")',
        r'\1\n  license "Apache-2.0"',
        content
    )

# Fix test block (poet generates "test do\n    false\n  end")
content = re.sub(
    r'test do.*?end',
    'test do\n    assert_match version.to_s, shell_output("#{bin}/qlever --version")\n  end',
    content,
    flags=re.DOTALL
)

formula_path.write_text(content)
print("Formula fixed successfully")
