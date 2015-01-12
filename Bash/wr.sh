#!/usr/bin/env bash

platform=$(uname -s)

case $platform in
    "Linux")
        DATE="date"
        ;;
    "Darwin")
        DATE="gdate"
        ;;
    *)
        echo "Unknown plateform"
        exit
        ;;
esac

function create_time_string() {
    get_time=$(${DATE} -dlast-monday+${1}day '+%m %d %a')
    month=$(echo ${get_time} | cut -d' ' -f1 )
    day=$(echo ${get_time} | cut -d' ' -f2 )
    date=$(echo ${get_time} | cut -d' ' -f3 )
    time_string="${month}月${day}日(${date}曜日)"
    echo "$time_string"
}

#declare -A holidays= 
declare -A days_offset=()
for i in $(seq 0 4)
do
    case $i in
        [0-4])
            days_offset[$i]=$(create_time_string ${i})
            ;;
        *)
            echo "Unknow date"
            exit
            ;;
    esac
done


cat <<- EOF > ~/weekly_report.md
h3. 今週の作業報告をいたします。

* ${days_offset[0]}
** 9:00 ~ 19:00
**** 
* ${days_offset[1]}
** 9:00 ~ 19:30
**** 
* ${days_offset[2]}
** 9:00 ~ 19:30
**** 
* ${days_offset[3]}
** 9:00 ~ 19:30
**** 
* ${days_offset[4]}
** 9:00 ~ 19:00
**** 

h3. 社外

今週メインの作業は

h3. 来週予定
EOF

echo "${HOME}に週報テンプレードを作成しました。"
