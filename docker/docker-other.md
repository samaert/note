# docker中已有的容器，去除跟随docker启动

是的，在 Docker 中已经存在的容器可以不跟随 Docker 启动。 Docker 提供了多种方式来实现这一点：

1. 使用 `--restart` 选项

在容器启动时添加 `--restart` 选项，可以设置容器的重启策略。例如：

```
docker run --restart=no myimage
```

这将设置容器不自动重启。

1. 使用 `docker update` 命令

可以使用 `docker update` 命令来更新容器的配置。例如：

```
docker update --restart=no mycontainer
```

这将更新容器的重启策略，使其不自动重启。

1. 使用 Docker Compose

如果你使用 Docker Compose 来管理容器，可以在 `docker-compose.yml` 文件中设置 `restart` 选项。例如：

```
version: '3'
services:
  myservice:
    image: myimage
    restart: no
```

这将设置容器不自动重启。

1. 使用 systemd 服务

如果你使用 systemd 来管理 Docker，可以在 systemd 服务文件中设置 `Restart` 选项。例如：

```
[Unit]
Description=mycontainer
After=docker.service

[Service]
Restart=no
ExecStart=/usr/bin/docker start -a mycontainer
ExecStop=/usr/bin/docker stop mycontainer
```

这将设置容器不自动重启。

需要注意的是，以上方法都需要在容器启动前或更新容器配置时设置。如果容器已经启动，可以使用 `docker update` 命令或 `systemctl` 命令来更新容器的配置。





# 证明这个配置有没有生效

要验证容器的重启策略是否生效，可以使用以下方法：

1. 使用 `docker inspect` 命令

可以使用 `docker inspect` 命令来查看容器的配置信息。例如：

```
docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' mycontainer
```

这将显示容器的重启策略，如果设置为 `no`，则表示容器不会自动重启。

1. 使用 `docker ps` 命令

可以使用 `docker ps` 命令来查看容器的状态。例如：

```
docker ps -a --format "{{.Names}} {{.RestartCount}}"
```

这将显示容器的名称和重启次数，如果重启次数为 0，表示容器没有自动重启。

1. 使用 `systemctl` 命令（仅适用于 systemd）

如果你使用 systemd 来管理 Docker，可以使用 `systemctl` 命令来查看容器的状态。例如：

```
systemctl status docker-mycontainer
```

这将显示容器的状态信息，包括重启策略。

1. 手动停止容器

可以手动停止容器，然后观察容器是否自动重启。例如：

```
docker stop mycontainer
```

如果容器设置了重启策略为 `no`，那么它不会自动重启。

1. 查看容器日志

可以查看容器的日志来了解容器的重启情况。例如：

```
docker logs -f mycontainer
```

这将显示容器的日志信息，如果容器自动重启，日志中将记录重启的信息。

通过这些方法，可以验证容器的重启策略是否生效。