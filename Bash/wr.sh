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
    time_string="${month}月${day}日 (${date}曜日)"
    echo "$time_string"
}

for i in $(seq 0 4)
do
    case $i in
        0)
            day1_string=$(create_time_string ${i})
            ;;
        1)
            day2_string=$(create_time_string ${i})
            ;;
        2)
            day3_string=$(create_time_string ${i})
            ;;
        3)
            day4_string=$(create_time_string ${i})
            ;;
        4)
            day5_string=$(create_time_string ${i})
            ;;
        *)
            ;;
    esac
done

echo "週報テンプレードを作成しました。"

cat <<- EOF > ~/weekly_report
h3. 今週の作業報告をいたします。

* $day1_string
** 9:00 ~ 19:00
****
* $day2_string
** 9:00 ~ 19:30
****
* $day3_string
** 9:00 ~ 19:30
****
* $day4_string
** 9:00 ~ 19:30
****
* $day5_string
** 9:00 ~ 19:00
****

h3. 社外

h3. 来週予定
EOF
