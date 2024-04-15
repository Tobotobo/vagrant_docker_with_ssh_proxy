# vagrant_docker_with_ssh_proxy

## 概要

* SSH Proxy の sshpiper と Docker プラグインを使ってみる
* sshpiper と Docker プラグインって何ができるの？
  * コンテナにラベルを設定しておく
  * ssh で接続する際にユーザー名に上記のラベルを指定する
  * sshpiper がユーザー名とラベルをマッチングして、該当するコンテナ内の sshサーバーに転送してくれる
* 何がうれしいの？
  * 通常、複数のコンテナを立ち上げて、それぞれに ssh で接続する場合、コンテナ毎に異なる外部から接続可能なポートを割り当てる必要がある  
  (2222, 2223, 2224, 2225, etc...)
  * sshpiper と Docker プラグインを使うと、上記のコンテナ毎に異なる外部から接続可能なポートを割り当てる必要がなくなり、ラベル (ユーザー名) の指定だけで接続先のコンテナを切り替えることができる  
  (tobotobo_dev, tobotobo_test, taro_dev, hanako_dev, etc...)
  * また、公開するポートも一つだけで済む
* あまり使いどころが思いつかないんだけど？
  * チームメンバー毎に作った開発環境やテスト環境を、使ってもらうのにポート番号で管理するのは煩雑。前述の例のようにユーザー名で誰の何かを区別できると管理が楽になる
* 手動で管理しなくても Coder とか Eclipse Che とか構築から払い出しまで管理してくれるソリューションを使えばよくない？
  * よくなかったからこうなったんだって

[GitHub - sshpiper](https://github.com/tg123/sshpiper)  
[DockerHub - farmer1992/sshpiperd](https://hub.docker.com/r/farmer1992/sshpiperd)  
[sshpiper - Docker Pulugin](https://github.com/tg123/sshpiper/tree/master/plugin/docker)

## 詳細

VirtualBox に仮想環境を構築  
※最後に表示される IP アドレスを控えておいてください。
```
vagrant up
```

構築した仮想環境に ssh 接続
```
vagrant ssh
```

SSH Proxy 起動
```
cd /vagrant/sshpiper
docker compose up -d
```

接続先 ( ubuntu_2204 ) 起動
```
cd /vagrant/ubuntu_2204
docker compose up -d
```

他の端末などから以下で接続できることを確認  
※パスワードは `dev`  
※XXX.XXX.XXX.XXX は `vagrant up` で確認した IP アドレス  
※ IP アドレスの確認を忘れた人は `vagrant ssh` で接続した状態で `ip addr show eth1 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1`
```
ssh -l tobotobo XXX.XXX.XXX.XXX -p2222
```
