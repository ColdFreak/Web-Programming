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

    # %a は曜日を表示
    get_time=$(${DATE} -dlast-monday+${1}day '+%m %d %a')
    
    # 月を取得
    month=$(echo ${get_time} | cut -d' ' -f1 )
    
    # 日を取得
    day=$(echo ${get_time} | cut -d' ' -f2 )

    # 曜日を取得
    date=$(echo ${get_time} | cut -d' ' -f3 )

    # 9月26日(金曜日)　のような形で表示
    time_string="${month}月${day}日(${date}曜日)"

    echo "$time_string"
}

# days_offsetという配列を宣言
# 動的に変数名を作るため
declare  -A days_offset=()
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


cat <<- EOF > ~/weekly_report
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

h3. 来週予定
EOF

echo "${HOME}に週報テンプレードを作成しました。"
