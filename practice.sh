#!/bin/bash
# s="abc,def,ghi"
# a=(${s//,/ })
# echo ${a[0]}
# echo ${a[1]}
# echo ${a[2]}

# for i in "${a[@]}"
# do
#   echo "$i"
# done

# echo `cut -d ',' -f 3 newly_confirmed_cases_daily.csv | sed -e '1d'`

# cutで「,」区切りにして列を取得、sedで１行目を削除
# cut -d ',' -f ${i} newly_confirmed_cases_daily.csv | sed -e '1d' 

lists=(`cat newly_confirmed_cases_daily.csv`)
i=3
N=$'\n'
array=()
hoge=(${lists//,/ })
unset hoge[0]
unset hoge[1]

for list in ${hoge[@]}
do
  prefecture=${list}
  # awkで列指定して列全体を足す。
  piyo=(`awk -F ',' '{s += $'${i}'} END {print s}' newly_confirmed_cases_daily.csv`)

  # 配列に代入
  array+=("${prefecture}"":""${piyo}""${N}")

  # iを加算
  let i++
done

# 「sort -t :」で「:」区切りにし、「-k 2,2n」で第 2 フィールドで数値的にソートするようにする。（nがないと行末まで行くためnは必要）← 第３、４フィールドがあった場合そっちも対象になってしまう。
ans=($(echo "${array[@]}" | sort -t : -k 2,2n ))

# seq 10で10回繰り返す
for i in `seq 10`
do
  echo ${ans[47-i]}
done
