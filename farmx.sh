#!/system/bin/sh

masterpassword=''
passwordtoencrypt=''
option=''
hiddenpasswords=''
len=''
passwordtodelete=''
i=0
waittoclear=''
apporwebsite=''
while ! [[ $option = "q" ]]
do
i=0
waittoclear=''
clear
#printf "\033c"
echo "-----------------------------------"
echo "Welcome"
echo ""
echo "***Dream Password Manager Script***"
echo ""
echo "1] Show All Passwords"
echo "2] Add New Password"
echo "3] Delete Existing Password"
echo "q] Quit"
echo ""
echo "Enter option: "
read option
if [[ $option = 2 ]];then
echo "Enter master password: "
read masterpassword
echo "Enter App Name or Website name"
read apporwebsite
echo "Enter password to Encrypt: "
read passwordtoencrypt
echo $apporwebsite " : " $passwordtoencrypt | openssl enc -e -des3 -base64 -pass pass:$masterpassword -pbkdf2  >> masterpasswordlist.txt
echo "done"
read waittoclear
fi

if [[ $option = 3 ]];then
IFS=$'\n' read -d '' -r -a hiddenpasswords < masterpasswordlist.txt
echo "Which password to delete? 0-? :"
read passwordtodelete
unset hiddenpasswords[$passwordtodelete]
echo "${hiddenpasswords[@]}" > masterpasswordlist.txt
echo "done"
read waittoclear
fi

if [[ $option = 1 ]];then
echo "Enter master password: "
read masterpassword
IFS=$'\n' read -d '' -r -a hiddenpasswords < masterpasswordlist.txt
#echo "Unecrypted"
#echo "${hiddenpasswords[@]}"
len=${#hiddenpasswords[@]}
for (( ; $i<$len ; i++ )); 
do
echo "$i" 
echo "${hiddenpasswords[$i]}" | openssl enc -d -des3 -base64 -pass pass:$masterpassword -pbkdf2
done
echo "done"
read waittoclear
fi
done