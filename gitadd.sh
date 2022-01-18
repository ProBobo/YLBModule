msg=$1

gitpush1() {
	if [ -z "$(git status -s)" ];then
		echo -e "\033[32m 进行push操作 \033[0m"
		git push origin master
	else
		echo -e "\033[31m modified/untracked \033[0m"
		git status
	fi
}

if [ -n "$msg" ]; then
   git add .
   git commit -m "${msg}"
   git pull origin master --allow-unrelated-histories
   echo -e "\033[32m 完成add、commit、pull操作 \033[0m"
   gitpush1
else
    echo -e "\033[31m 请添加注释再来一遍 \033[0m"
fi