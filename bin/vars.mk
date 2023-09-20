USERID := $(shell id -u $$USER)
CURDIR_BASENAME := $(notdir ${CURDIR})
MAYBE_SUDO   ?=
VAGRANT_MODE ?=

SED := sed
ifneq ($(shell command -v gsed),  )
	SED := gsed
endif

# parse .env vars
ifneq ("$(wildcard .env)","")
	DOTENV      := $(shell cat .env )
	# can be overridden from cli
	DB_DATABASE := $(shell cat .env | grep "^DB_DATABASE=" | ${SED} 's/DB_DATABASE=//')
	DB_USERNAME := $(shell cat .env | grep "^DB_USERNAME=" | ${SED} 's/DB_USERNAME=//')
	DB_PASSWORD := $(shell cat .env | grep "^DB_PASSWORD=" | ${SED} 's/DB_PASSWORD=//')
endif

# define docker compose version
DC := docker-compose
DC2_VERSION := $(shell docker compose version | grep "version v2")
ifneq "${DC2_VERSION}" ""
	DC := docker compose
endif

DOCKER_COMPOSE_OVERRIDE_SRC := build/docker-compose.dev.yml

# check if we running a vagrant by default
ifeq "$(USER)" "vagrant"
	V := 1
endif
# adjust global vars for vagrant mode
ifneq "$(V)" ""
	VAGRANT_MODE := 1
	MAYBE_SUDO := sudo
endif

# define do we need to disable docker pseudo TTY interface
DOCKER_T_FLAG :=
ifeq "$(NON_INTERACTIVE)" "1"
    DOCKER_T_FLAG := -T
endif

# docker exec/run aliases
DC_WORKDIR_WWW := -w /var/www/html
DC_EXEC := ${DC} exec ${DOCKER_T_FLAG} --privileged --index=1
DC_RUN := ${DC} run --rm ${DOCKER_T_FLAG}
