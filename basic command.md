` wc -l test_command.gtf #查看行 `
`wc -c test_command.gtf #查看字数`
`grep '^chr_' test_command.gtf | grep 'YDL248' #查找 chr 与 YDL`
`sed 's/chr_/chromosome_/g' test_command.gtf | cut -f 1,3,4,5 #修改列名`
`awk '{tem=$3;$3=$2;$2=tem}' test_command.gtf | sort -k 4,5 > result.gtf #内置简单脚本，使用;`
`ls -l`
`chmod ug=rwx,o=r test_command.gtf`
`ls -l`
