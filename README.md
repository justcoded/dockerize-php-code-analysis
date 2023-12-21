# ⚠️ WARNING 
### PHP Code Code Analysis Tool commands moved to https://github.com/justcoded/git-extras repository.

# Dockerized PHP Code Analysis Tool

This dockerized tool provides you Makefile commands to check and fix PHP code.  
It's built on top of https://github.com/easy-coding-standard/easy-coding-standard library 
and uses some other supported packages to cover as many rules as possible.

## Installation
1. Download [code.mk](./bin/code.mk)
2. Include `code.mk` in your `Makefile`  
```makefile
include code.mk
```
3. Use :)

## Usage
This tool uses `code.` namespace for all the commands it provides.  
Use `make help` if available in your project to see for available commands.  
You can see details in `code.mk` file to be aware of all available commands.

#### Check code
```shell
make code.check
```

```shell
make code.check path=src/app/Http
```

```shell
make code.check.dirty
```

```shell
make code.check.diff
```

```shell
make code.check.diff branch=main
```

#### Fix code
```shell
make code.fix
```

```shell
make code.fix path=src/app/Http
```

```shell
make code.fix.dirty
```

```shell
make code.fix.diff
```

```shell
make code.fix.diff branch=main
```

#### Configure checker

1. Publish the config
```shell
make code.config.publish
```
2. Modify `ecs.php` file to fit your needs.


#### Update
You can download a fresh `code.mk` file using the following command:

```shell
make code.self-update
```
