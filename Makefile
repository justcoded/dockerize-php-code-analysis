.PHONY: default

SHELL=/bin/bash
include bin/colors-xterm.mk

PROJECT_NAME := Dockerized PHP Code Analysis Tool
SQL_DB_MAX_WAIT := 120

default:
	@echo '${PROJECT_NAME}'
	@echo 'Run ${FG_YELLOW}make help${FG_RESET} to find out available commands'

include bin/vars.mk
include bin/utils.mk
include bin/changelog.mk
include bin/code.mk

##
# @command code.test.check 				   Check code in test directory.
##
code.test.check:
	${MAKE} build
	${ECS_DR} \
		-c "ecs check --config /app/ecs.php test"

##
# @command code.test.fix 				   Fix code in test directory.
##
code.test.fix:
	${MAKE} build
	${ECS_DR} \
		-c "ecs check --config /app/ecs.php --fix test"

##
# @command build				   		Build docker image
##
build:
	docker-compose build

