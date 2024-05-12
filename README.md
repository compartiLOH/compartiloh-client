# Description

Client to connect your computer to CompartiLOH System.

# Prerequisites

You need some prerequisites to run compartiloh client and provide you own services.

- Docker Engine
- Docker API

You can see in the supported [architectures section](https://github.com/compartiLOH/compartiloh-client?tab=readme-ov-file#supported-architectures) the compatibility with your system.

## Install

The first step is download this repository

```
git clone https://github.com/compartiLOH/compartiloh-client.git
```

Then run the installation script providing the architecture version you want. E.g: If you are in Linux x86_64 run

```
./install.sh linux-amd64
```

You can review the [architectures section](https://github.com/compartiLOH/compartiloh-client?tab=readme-ov-file#supported-architectures) section

This will install all compartiLOH client in home folder

```
$HOME/.compartiloh
```

CompartiLOH client will be installed in `$HOME/.compartiloh/cloh` path, but you can set client in PATH. Add the following lines in the corresponding file according to your shell, `.bashrc` for bash, `.zshrc` for zsh, and others.

```
#COMPARTILOH
export COMPARTILOH_HOME="$HOME/.compartiloh"
export PATH="$PATH:$COMPARTILOH_HOME"
```

Reload terminal or run `source` with your file. Like example

```
source ~/.zshrc
```

At final of this step, `cloh` CLI is available to run. The available commands can be viewed using `cloh help`. 

```
cloh help

connect      Conectar el recurso al sistema. Requiere configuracion de token
update       Actualizar CLI de compartiloh
help         Mostrar este mensaje de ayuda
```

## Configuration

Now you can configure your token in the attribute token in the file `$HOME/.compartiloh/agent/<arquitecture>/config/client-config.yaml`

```
remote:
  server: 
    host: "https://logs.compartiloh.com"
    port: 443
  frp:
    agent:
      host: "resources.compartiloh.com"
      port: 7000
    public:
      host: "services.compartiloh.com"
      port: 7000
  auth:
    url: "https://security.compartiloh.com"
local:
  api:
    port: 3501
  frp:
    internal:
        host: "localhost"
        port: 7400
    external:
        host: "localhost"
        port: 7401
log:
  level: "info"
token: <<REPLACE TOKEN HERE>>
```

# User Guide

To connect resource to system run the client with `connect` option
```
cloh connect
```

## Update client

To update CLI in your system run the client with `update` option
```
cloh update
```

## Troubleshooting

You can see your client logs in `$HOME/.compartiloh/agent/<arquitecture>/*.log` Each time you connect the Agent, a new file will be created.

Also note that the system is compatible with DOCKER_API_VERSION<=1.41, so in case the Agent is not connecting, please try running
```
export DOCKER_API_VERSION=1.41
```


## Supported Architectures

- `darwin-amd64`: MacOS on x86_64 (64-bit)
- `darwin-arm64`: MacOS on ARM64 (64-bit) on Apple Silicon devices like M1.
- `linux-amd64` : Linux on x86_64 (64-bit)
- `netbsd-amd64`: NetBSD on x86_64 (64-bit)
