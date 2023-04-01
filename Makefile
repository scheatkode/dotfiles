.EXPORT_ALL_VARIABLES:

EUSER ?= ${USER}

.PHONY:    \
	install \
	test

install:
	@sudo -E salt-call --local      \
			--state-output=changes_id \
			--file-root="$(CURDIR)"   \
		state.highstate

test:
	@nvim                          \
		--headless                  \
		--noplugin                  \
		--clean                     \
		-u scripts/minimal_test.vim \
		-c "qa"
