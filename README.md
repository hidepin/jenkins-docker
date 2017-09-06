jenkins-docker
============================================================

初期設定
============================================================

1. imageを作成する

    ```
    docker-compose build
    ```

2. dirを作成する

    ```
    mkdir -p /opt/docker/jenkins/volumes/app/var/jenkins_home
    chown 1000:1000 /opt/docker/jenkins/volumes/app/var/jenkins_home
    ```

OSの変更方法
============================================================

RHEL7
------------------------------------------------------------

1. docker-compose.override.ymlを作成する

    ```
    version: '2'

    services:

      app:
        build:
          context: ./jenkins
          dockerfile: Dockerfile-redhat
          args: <- Proxy環境の場合
            http_proxy: http://xxx.xxx.xxx.xxx:3128 <- Proxy環境の場合
            https_proxy: http://xxx.xxx.xxx.xxx:3128 <- Proxy環境の場合
        environment: <- Proxy環境の場合
          http_proxy: http://xxx.xxx.xxx.xxx:3128 <- Proxy環境の場合
          https_proxy: http://xxx.xxx.xxx.xxx:3128 <- Proxy環境の場合
    ```

CentOS7
------------------------------------------------------------

1. docker-compose.override.ymlを作成する

    ```
    version: '2'

    services:

      app:
        build:
          context: ./jenkins
          dockerfile: Dockerfile-centos
          args: <- Proxy環境の場合
            http_proxy: http://xxx.xxx.xxx.xxx:3128 <- Proxy環境の場合
            https_proxy: http://xxx.xxx.xxx.xxx:3128 <- Proxy環境の場合
        environment: <- Proxy環境の場合
          http_proxy: http://xxx.xxx.xxx.xxx:3128 <- Proxy環境の場合
          https_proxy: http://xxx.xxx.xxx.xxx:3128 <- Proxy環境の場合
    ```

systemdによる自動起動設定
============================================================
host OSにsystemdの自動起動設定を行う
(ansibleが必要)

1. host OSにログインする

2. dockerからansibleの設定を行う

  ``` shell
  cd systemd
  ansible-playbook -i "(host OSのIPアドレス)," systemd.yml
  ```
