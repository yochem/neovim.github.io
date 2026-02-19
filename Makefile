NVIM ?= nvim-src
DOCS ?= ${NVIM}/runtime/doc
DOCSRC = $(abspath ${DOCS})

USERDOC_TARGET := $(abspath ./content/doc/user)

.DEFAULT: hugo

${NVIM}:
	@echo git clone https://github.com/neovim/neovim.git $@

prerequisite: ${NVIM}

${USERDOC_TARGET}: | ${DOCSRC} prerequisite
	(cd ${NVIM} && VIMRUNTIME=runtime/ ./build/bin/nvim -V1 -es --clean +"lua require('src.gen.gen_help_html').gen('${DOCSRC}', '$@', nil, '$(shell cd ${DOCSRC} && git rev-parse HEAD)')" +0cq)
	# TODO: file does not work yet
	rm $@/fold.html

userdoc: ${USERDOC_TARGET}


content/doc/build.md:
	hugo new content --force $@
	curl -sSL https://raw.githubusercontent.com/neovim/neovim/refs/heads/master/BUILD.md >> $@

	# Replace INSTALL.md hyperlinks with "./install".
	sed -i '' 's/INSTALL\.md/\.\.\/install\//g' $@

content/doc/install.md:
	hugo new content --force $@
	curl -sSL https://raw.githubusercontent.com/neovim/neovim/refs/heads/master/INSTALL.md >> $@

	# Replace BUILD.md hyperlinks with "./build".
	sed -i '' 's/BUILD\.md/\.\.\/build\//g' $@

hugo: ${USERDOC_TARGET} content/doc/install.md content/doc/build.md
	hugo --gc --minify

cleanuserdoc:
	rm -rf ${USERDOC_TARGET}

cleanhugo:
	rm -rf ./public/
	rm -f .hugo_build.lock

clean: cleanuserdoc cleanhugo

.PHONY: userdoc prerequisite clean cleanuserdoc cleanhugo
