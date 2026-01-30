#!/usr/bin/env python3
"""Fix up the generated qlever-control formula."""

import re
import subprocess
from pathlib import Path

formula_path = Path("Formula/qlever-control.rb")
patches_dir = Path("Patches")
content = formula_path.read_text()

# Rename class from Qlever to QleverControl
content = re.sub(r"class Qlever <", "class QleverControl <", content)

# Fix description
content = re.sub(
    r'desc "Shiny new formula"',
    'desc "Command-line tool for QLever graph database"',
    content,
)

# Fix homepage
content = re.sub(
    r'homepage ".*?"',
    'homepage "https://github.com/ad-freiburg/qlever-control"',
    content,
)

# Add license after homepage if not present
if 'license "' not in content:
    content = re.sub(
        r'(homepage "https://github.com/ad-freiburg/qlever-control")',
        r'\1\n  license "Apache-2.0"',
        content,
    )


def get_sha256(file_path: Path) -> str:
    """Get sha256 hash of a file."""
    result = subprocess.run(
        ["sha256sum", str(file_path)], capture_output=True, text=True, check=True
    )
    return result.stdout.split()[0]


# Add patch blocks before def install if not present
if "patch do" not in content:
    patch_files = [
        (
            "disable-autocompletion-warning.patch",
            "Disable argcomplete warning for Homebrew installations",
        ),
        (
            "qleverfile-use-native-system.patch",
            "Update all Qleverfiles to use SYSTEM = native by default",
        ),
    ]

    patch_blocks = []
    for patch_file, comment in patch_files:
        patch_path = patches_dir / patch_file
        if patch_path.exists():
            sha256 = get_sha256(patch_path)
            patch_blocks.append(
                f"""  # {comment}
  patch do
    url "file://#{{File.expand_path('../Patches/{patch_file}', __dir__)}}"
    sha256 "{sha256}"
  end"""
            )

    if patch_blocks:
        patch_section = "\n\n" + "\n\n".join(patch_blocks) + "\n"
        content = re.sub(r"(\n  def install)", patch_section + r"\1", content)

# Add shell completion installation if not present
if "generate_completions_from_executable" not in content:
    shell_completion_block = """

    # Install shell completions
    generate_completions_from_executable(
      libexec/"bin/register-python-argcomplete", "qlever",
      shells: [:bash, :zsh, :fish]
    )"""
    content = re.sub(
        r"(virtualenv_install_with_resources)\n(  end)",
        r"\1" + shell_completion_block + r"\n\2",
        content,
    )

# Fix test block (poet generates "test do\n    false\n  end")
content = re.sub(
    r"test do.*?end",
    'test do\n    assert_match version.to_s, shell_output("#{bin}/qlever --version")\n  end',
    content,
    flags=re.DOTALL,
)

formula_path.write_text(content)
print("Formula fixed successfully")
