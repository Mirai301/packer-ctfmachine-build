# packer/cloud-initを使ってCTFっぽいマシンを作成する  
ToDo:もう少し凝った脆弱性を埋め込む予定  
  
### 事前準備  
```  
kvm,qemu等のセットアップ  
  
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img  
md5sum focal-server-cloudimg-amd64.img  
```  
  
### 秘密鍵の設定  
03_vuln.shの!!!!! PRIVATE KEY !!!!!に秘密鍵に書き換えてください  
  
## Writeup  
  
### イニシャルシェルの取得  
dirb等でディレクトリを総当り->secret.txtにHTTPアクセス  
usernameのワードリストでSSH-User-Enumする -> users.txtの作成  
users.txtと取得した秘密鍵で総当り  
  
### 権限昇格  
sudo -lするとnmapがNOPASSWORDでSUIDが設定されている  
-> GTFOBinsを参照(https://gtfobins.github.io/)