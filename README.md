# frp-deb

本项目用于打包frp为可被Debian/Armbian/Ubuntu等Linux发行版系统直接安装的deb软件包，且在原有的frp基础上，加入了兼容系统服务的管理脚本，极大的提高的软件的易用性。

## 服务管理

软件包在安装完毕之后，默认是将frps服务设为开机自启。可以手动切换 `frpc/frps` 服务的开机自启状态，支持服务的开机自启与后台进程守护。

1. 将frpc服务设为开机自启，操作如下：

`sudo systemctl enable frpc.service` 或 `sudo update-rc.d frpc defaults`

2. 将frps服务取消开机自启，操作如下：

`sudo systemctl disable frps.service` 或 `sudo update-rc.d -f frps remove`

3. 启动/停止/重启/查看状态(以frpc为例)，操作如下：

`sudo service frpc start`、 `sudo service frpc stop`、 `sudo service frpc restart`、 `sudo service frpc status`

4. 默认配置文件目录： `/etc/frp`

其中 `frpc.ini` 为客户端配置文件，`frps.ini` 为服务端配置文件，配置文件默认使用的是完整配置文件。

5. 默认日志文件目录： `/var/log/frp`

其中 `frpc.log` 为客户端日志文件，`frps.log` 为服务端日志文件。

## 如何构建

在开始构建deb软件包之前请务必安装 `fakeroot` 工具，或切换到root管理员身份操作

首先将本项目克隆到本地环境当中(注意在打包前删除项目目录下的.git文件夹，README.md以及LICENSE文件，以免将不必要的文件打包到安装包当中!)，根据需要从github上下载对应版本的frp预编译发布应用包，并将其解压到本地目录当中，然后将完整配置文件 `frpc_full.ini/frps_full.ini` 重命名为 `frpc.ini/frps.ini` 并复制到 `frp-deb/etc/frp/` 目录下，将可执行程序 `frpc/frps` 复制到 `frp-deb/usr/bin/` 目录下(注意赋予可执行权限)，对应修改 `frp-deb/DEBIAN/control` 文件中的 `[VERSION]` 和 `[ARCH]` 字段，例如:  `Version: 0.28.0` , `Architecture: amd64` . 最后切换到frp-deb所在的目录下，执行 `fakeroot dpkg-deb -b frp-deb frp-[VERSION]-[ARCH].deb` (注意这里的VERSION和ARCH请依据实际情况加以修改) 或切换到root管理员身份执行 `dpkg-deb -b frp-deb frp-[VERSION]-[ARCH].deb` . 稍等片刻即可生成最终的deb安装包文件。
