var sys = require('sys');

var obj = {
    name: "Tom Hanks",
    age: 54,
};

sys.print("Print message.\n");
sys.log("Log message.");
sys.print(sys.inspect(obj)+"\n");

// sysモジュールは標準的な出力機能を提供する
// 改行なしの文字列を出力するprintメソッドと
// 日付つきのログを出力するlogメソッド
// PerlのData::DumperやPHPのvar_dump()のような
// ダンプ機能を持つinspectメソッド
// 下はプログラムの出力
// Print message.
// 4 Aug 16:14:33 - Log message.
// { name: 'Tom Hanks', age: 54 }
