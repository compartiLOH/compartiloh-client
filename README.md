# Description

Client to connect your computer to CompartiLOH System.

# Prerequisites

You need some prerequisites to run compartiloh client and provide you own services.

- Docker Engine
- Docker API

You can see in the supported [architectures section](https://github.com/compartiLOH/compartiloh-client?tab=readme-ov-file#supported-architectures) the compatibility with your system.

## User Guide

The first step is download this repository

```
git clone https://github.com/compartiLOH/compartiloh-client.git
```

Then run the installation script providing the architecture version you want. E.g: If you are in x86_64 run

```
install.sh x86_64
```

You can review the [architectures section](https://github.com/compartiLOH/compartiloh-client?tab=readme-ov-file#supported-architectures) section

This will be install all compartiLOH client in home folder

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

Now you can configure your token in the attribute token in the file `$HOME/.compartiloh/agent/x86_64/config/config.yaml`

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

To connect resource to system run the client with `connect` option
```
cloh connect
```

## Troubleshooting

You can see your client logs in `$HOME/.compartiloh/agent/x86_64/*.log` Each time you connect the Agent, a new file will be created.

## Supported Architectures

- Linux x86_64
