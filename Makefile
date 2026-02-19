NVIM ?= nvim-src
DOCSRC ?= ${NVIM}/runtime/doc

USERDOC_TARGET := ./content/doc/user

.DEFAULT: hugo

${NVIM}:
	@echo git clone https://github.com/neovim/neovim.git $@

prerequisite: ${NVIM}

${USERDOC_TARGET}: | prerequisite
	(cd ${NVIM} && VIMRUNTIME=runtime/ ./build/bin/nvim -V1 -es --clean +"lua require('src.gen.gen_help_html').gen('${DOCSRC}', '$@', nil, '$(shell cd ${DOCSRC} && git rev-parse HEAD)')" +0cq)
	# TODO: file does not work yet
	rm $@/fold.html

hugo: ${USERDOC_TARGET}
	hugo --gc --minify

cleanuserdoc:
	rm -rf ${USERDOC_TARGET}

cleanhugo:
	rm -rf ./public/
	rm -f .hugo_build.lock

clean: cleanuserdoc cleanhugo

.PHONY: userdoc prerequisite clean cleanuserdoc cleanhugo
