test:
	@nvim                          \
		--headless                  \
		--noplugin                  \
		--clean                     \
		-u scripts/minimal_test.vim \
		-c "qa"
