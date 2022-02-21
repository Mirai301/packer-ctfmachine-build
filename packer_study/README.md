packer-study
=====

[HashiCorpのPacker](https://www.packer.io/) を利用して仮想マシンのイメージを作成する演習となります。  

> 本演習は、各自に配布されている作業用VMの上で作業をおこないます。

## 事前準備

### 1. Packerのインストール

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update && sudo apt install packer
```

`packer version` を実行して、以下の結果が得られることを確認して下さい。  
（詳細なバージョン情報は実行時により異なる場合があります。）

```
$ packer version
Packer v1.7.10
```

### 2. Config Driveの作成

Config Driveは仮想マシンが起動時に読み込むためのメタデータを書き込んだファイルです。

- 参考1: [https://docs.openstack.org/ja/user-guide/cli-config-drive.html](https://docs.openstack.org/ja/user-guide/cli-config-drive.html)
- 参考2: [https://cloudinit.readthedocs.io/en/latest/topics/datasources/configdrive.html](https://cloudinit.readthedocs.io/en/latest/topics/datasources/configdrive.html)

```
sudo apt install cloud-utils
cloud-localds ./cloud.img cloud.cfg
```

### 3. 作成するイメージに埋め込む公開鍵の設定

`02_cloud-init.sh` 5行目の `!!!!! PUBLIC KEY !!!!!` を自身の公開鍵に書き換えて下さい。

## イメージの作成

以下のコマンドを実行して下さい、状況次第ですが5分前後で完了します。

```
sudo rm -rf output
sudo packer build ./focal-nginx.pkr.hcl
```

`output` ディレクトリの下にタイムスタンプが付与されたイメージが作成されます。

> 注意: 実行時間によってファイル名が異なります。

```
$ sudo ls -lah ./output
total 591M
drwxr-xr-x 2 root   root   4.0K Feb 21 07:18 .
drwxrwxr-x 3 ubuntu ubuntu 4.0K Feb 21 07:18 ..
-rw-r--r-- 1 root   root   592M Feb 21 07:18 focal-server-nginx-amd64-2022-02-21-07-15.qcow2
```

## 作成したイメージから仮想マシンを起動

> 注意: 以下の作業では自身の環境に合わせてファイル名を変更して下さい。

作成したイメージをコピー

```
sudo cp --sparse=always ./output/focal-server-nginx-amd64-2022-02-21-07-15.qcow2 .
```

コピーしたイメージから仮想マシンを起動

```
 virt-install \
    --import \
    --name focal-nginx-test \
    --memory 2048 \
    --vcpus 2 \
    --disk focal-server-nginx-amd64-2022-02-21-07-15.qcow2,bus=virtio \
    --disk cloud.img,device=cdrom \
    --network bridge=virbr0,model=virtio \
    --nographics \
    --noautoconsole
```

仮想マシン起動後、設定した公開鍵に対応する秘密鍵を用いてSSHでログインが可能な事を確認して下さい。  
（SSHに利用するユーザ名は `ubuntu` です。）
