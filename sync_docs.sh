#!/bin/bash

# This script syncs files from Neovim core, to content/doc2/:
# - BUILD.md
# - INSTALL.md
#
# After Hugo publishes the rendered HTML from content/doc2/, the files are
# later copied from doc2/ to doc/ by this CI task:
# https://github.com/neovim/doc/blob/main/ci/doc-index.sh

set -eu

hugo new content --force content/doc2/build.md
curl -sSL https://raw.githubusercontent.com/neovim/neovim/refs/heads/master/BUILD.md >> content/doc2/build.md
# Replace INSTALL.md hyperlinks with "./install".
sed -i '' 's/INSTALL\.md/\.\.\/install\//g' content/doc2/build.md

hugo new content --force content/doc2/install.md
curl -sSL https://raw.githubusercontent.com/neovim/neovim/refs/heads/master/INSTALL.md >> content/doc2/install.md
# Replace BUILD.md hyperlinks with "./build".
sed -i '' 's/BUILD\.md/\.\.\/build\//g' content/doc2/install.md

git add content/doc2/
git commit -m 'update content/doc2/ files from neovim/neovim repo'
