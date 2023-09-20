.PHONY: chl chl-first chl-amend

CONV_CHL_IMAGE := justcoded/php-conventional-changelog:latest
CONV_CHL_DR := docker run -it --rm --volume "$$PWD":/codebase ${CONV_CHL_IMAGE} bash
CONV_CHL_CMD := conventional-changelog --config bin/changelog.php

##
# @command chl 	Generate changelog based on conventional commits
##
chl:
	${CONV_CHL_DR} \
		-c "${CONV_CHL_CMD}"

##
# @command chl-first 	Generate changelog based on conventional commits, first version
##
chl-first:
	${CONV_CHL_DR} \
		-c "${CONV_CHL_CMD} --first-release"
