centos 更新时间

在CentOS系统中，您可以使用`ntpdate`命令或`chrony`/`ntpd`服务来更新系统时间。以下是两种常见方法的示例：

1. 使用`ntpdate`命令手动同步时间：

```bash
sudo yum install -y ntpdate
sudo ntpdate pool.ntp.org
```

1. 使用`chrony`服务自动同步时间：

```bash
sudo yum install -y chrony
sudo systemctl enable chronyd
sudo systemctl start chronyd
```

`chrony`会自动同步系统时间，无需手动操作。

请注意，`ntpdate`命令可能会在某些系统上被认为是不推荐的，因为它可能会导致时间跳变，对于系统稳定性有潜在的影响。如果可能，建议使用`chrony`或`ntpd`。