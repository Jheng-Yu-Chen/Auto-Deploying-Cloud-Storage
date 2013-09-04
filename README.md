Auto-Deploying-Cloud-Storage
============================

自動佈署雲端儲存的Shell Script, 自動設定Owncloud、Glusterfs、Galera、安全性與自動調整校能。

目前僅支援CentOS 6 64位元以上的版本。



#自動佈署方式
#注意: 執行這個Script會將MySQL、Apache的設定與目錄清空，若有資料請先備份!

#Step 1. 準備伺服器
準備好1台或3台以上的伺服器，設定好IP讓伺服器之間能連線。

#Step 2. 修改config/hosts
將要佈署的伺服器IP加入到此清單，執行此Script的伺服器IP也必需在清單內。

#Step 3. 修改config/config
主要修改下列的設定:

yes : 啟動防火牆
no : 不啟動防火牆
firewall=yes

位於此網段的主機才能存取MySQL與DFS, 例如: 192.168.5.0/24
firewall為no時不必設定。
network_segment=192.168.5.0/24

yes : 測試中，自動根據Node的CPU與Memory調整效能
no : (預設) 
perf_tuning=no

設定MySQL的root密碼。
mysql_pwd='owncloud'

#Step 4. 執行deploy.sh
切換到與deploy.sh相同的目錄，並執行指令 # sh deploy.sh ，完成。
