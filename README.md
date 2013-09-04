Auto-Deploying-Cloud-Storage
============================

自動佈署雲端儲存的Shell Script, 自動設定Owncloud、Glusterfs、Galera、安全性與自動調整校能。

目前僅支援CentOS 6 64位元以上的版本。



#注意: 執行這個Script會將MySQL、Apache的設定與目錄清空，若有資料請先備份!


#自動佈署方式

#Step 1. 準備伺服器
準備好1台或3台以上的伺服器，設定好IP讓伺服器之間能連線。

#Step 2. 修改config/hosts
將要佈署的伺服器IP加入到此清單，執行此Script的伺服器IP也必需在清單內。

#Step 3. 修改config/config
主要修改下列的設定:

設定是否啟用防火牆，設定值: yes / no。

firewall=yes


位於此網段的主機才能存取DFS與MySQL, 例如: 192.168.5.0/24。firewall為no時不必設定。

network_segment=192.168.5.0/24


設定是否自動調整校能(測試中)，設定值: yes / no。

perf_tuning=no

設定apache的port，如果設定443會強迫使用HTTPS協定連線。

http_port=443

設定MySQL的root密碼。

mysql_pwd='owncloud'


#Step 4. 執行deploy.sh
切換到與deploy.sh相同的目錄，並執行指令 # sh deploy.sh 。

若執行錯誤請查看deploy.log檔。

#Step 5. 進入ownCloud設定網頁
在網址列輸入 http://IP.address/owncloud ，若http_port設定443則在網址列輸入 https://IP.address/owncloud 。
