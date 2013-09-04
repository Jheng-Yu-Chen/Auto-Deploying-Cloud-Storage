#/bin/bash

echo "" > deploy.log
mkdir -p tmp

source ./config/config
source ./script/functions

#判斷config/hosts檔裡的IP是否為1或3個以上
if [ $total_hosts -eq 0 ] || [ $total_hosts -eq 2 ]; then
	echo "至少要1台或3台以上的主機!" | tee -a deploy.log
	exit 1
fi

rpm -q openssh-clients > /dev/null
if [ $? -ne 0 ]; then
	echo "安裝openssh-clients ....." | tee -a deploy.log
	yum install -y openssh-clients 2>> deploy.log
	check_status
fi
	
#判斷執行腳本的使用者是否與./config/config裡deploy_user的設定相同
if [ "${USER}" != "${deploy_user}" ]; then
	echo "您以'$USER'的身份執行，請以'${deploy_user}'帳號登入!" | tee -a deploy.log
	exit 1
fi
	
#SSH不需輸入密碼登入
echo "你能SSH到別台主機而不用輸入密碼嗎?" | tee -a deploy.log
read -p "輸入'n'設定無密碼登入 (y/n): " answer

#檢查主機連線
echo ""
ping_host || exit 1
check_ssh
	
if [ "${answer}" == "n" ]; then
	./script/shared_ssh_keys
fi

echo ""	
echo "測試SSH無密碼登入:" | tee -a deploy.log
test_sshnopwd || exit 1
	
#檢查防火牆
echo ""
check_iptables

#檢查並設定SELINUX
echo ""
check_selinux
	
#檢查作業系統版本
echo ""
check_os
	
#安裝前動作
./script/init_install || exit 1
	
	
#設定GlusterFS
if [ "$total_hosts" -gt 1 ]; then
	./script/glusterfs || exit 1
fi

#設定Galera
./script/galera || exit 1
	
#owncloud
./script/owncloud || exit 1


#設定防火牆
./script/firewall

rm -rf tmp
