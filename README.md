jenkins-docker
============================================================

初期設定
============================================================

1. imageを作成する

    ```
    docker-compose build
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
    ```

systemdによる自動起動設定
============================================================
host OSにsystemdの自動起動設定を行う
(ansibleのdocker imageが必要)

1. host OSにログインする

2. dockerからansibleの設定を行う

  ``` shell
  docker run --rm -it -v $(pwd)/systemd:/playbook hidepin/ansible ansible-playbook -i "(host OSのIPアドレス)," systemd.yml
  ```
