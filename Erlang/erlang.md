
        1> string:tokens("10 4 3 + 2 * -", " ").
        ["10","4","3","+","2","*","-"]

下の命令はsrc/ディレクトリ下の'.erl'
ファイルとtest/ディレクトリ下の'.erl'
ファイルをコンパイルして、出力する
'.beam'ファイルをebinディレクトリに
置く

        $ erlc -o ebin/ src/*.erl test/*.erl


beamファイルがどこにあるのかを
-paで指定する,テストするときに
[verbose]で指定することができる

        $ erl -pa ebin/
        1> eunit:test(mylist, [verbose]).

        ======================== EUnit ========================
        module 'mylist'
          module 'mylist_tests'
            mylist_tests: sum_test...ok
            mylist_tests: product_test...ok
            mylist_tests: odds_test...ok
            [done in 0.009 s]
          [done in 0.009 s]
        =======================================================
          All 3 tests passed.
        ok

Binary Comprehensions

        2> [X || <<X>> <= <<1,2,3,4,5>>, X rem 2 == 0].
        [2,4]
        3> Pixels = <<213,45,132,64,76,32,76,0,0,234,32,15>>.
        <<213,45,132,64,76,32,76,0,0,234,32,15>>
        4> RGB = [{R,G,B} || <<R,G,B>> <= Pixels].
        [{213,45,132},{64,76,32},{76,0,0},{234,32,15}]
        5> RGB = [{R,G,B} || <<R:8,G:8,B:8>> <= Pixels].
        [{213,45,132},{64,76,32},{76,0,0},{234,32,15}]
        6> RGB = [{R,G,B} || <<R:9,G:8,B:8>> <= Pixels].
        ** exception error: no match of right hand side value [{426,91,8},{257,48,129},{96,0,7}]


これはdict内部の表現仕方，心配する
必要は無い

        1> dict:new().
        {dict,0,16,16,8,80,48,
              {[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]},
              {{[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]}}}
	

リストから辞書を作る
ことも可能, findメソッドは
Dictに探すと指定する必要
がある

        2> Dict = dict:from_list([{list, 1},{tuple, 2}, {string, 3}]).
        {dict,3,16,16,8,80,48,
              {[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]},
              {{[],[],[],[],
                [[list|1]],
                [[tuple|2]],
                [],
                [[string|3]],
                [],[],[],[],[],[],[],[]}}}
        3> dict:find(list, Dict).
        {ok,1}
        4> dict:find(string, Dict).
        {ok,3}


run(Subject, RE) -> {match, Captured} | nomatch
re:run/2は上のようで，
re:run/3  run(Subject, RE, Options) -> {match, Captured} | match | nomatch

        1> re:run("The quick brown fox.", "ick").
        {match,[{6,3}]}
        2> re:run("The quick brown fox.", "ick ").
        {match,[{6,4}]}
        3> re:run("The brown fox.", "ick").
        nomatch
        4> re:run(<<"The quick brown fox.">>, "ick").
        {match,[{6,3}]}
        5> re:run("The sick quick brown fox.", "ick", [global]).
        {match,[[{5,3}],[{11,3}]]}

re:replace/3 returns an odd-looking binary, which
is called an iolist, an efficient data strucure,
used like this to prevent copying of data in memory

        10> re:replace("The quick brown fox.", "brown", "red").
        [<<"The quick ">>,<<"red">>|<<" fox.">>]

let's use re:replace/4 to provide an option
replace(Subject, RE, Replacement, Options) -> iodata() | unicode:charlist()

        1> re:replace("The quick brown fox.", "brown", "red", [{return, list}]).
"The quick red fox."

It has to do something with one backslash
being consumed by the shell's parser
and the second required by the 're' module

        28> re:run("4", "\\d").
        {match,[{0,1}]}
        34> re:run("4", "\d").
        nomatch

        31> re:run("a", "\\w").
        {match,[{0,1}]}
        32> re:run("a", "\w").
        nomatch

        33> re:run("Her name is Jane", "Her name is (.+)").
        {match,[{0,16},{12,4}]}

        14> string:words("this is a fucking good idea").
        6
        15> string:words("this is a fucking good idea", <).
        1
        16> string:words("this is a fucking good idea", $h).
        2
        17> string:words("this is a fucking good idea", $i).
        5
        18> string:join(["this", "is", "a", "string"], "W").
        "thisWisWaWstring">


        1> ets:new(ingredients, [set, named_table]).
        ingredients
        2> ets:insert(ingredients, {bacon, great}).
        true
        3> ets:lookup(ingredients, bacon).
        [{bacon,great}]
        4> ets:insert(ingredients, [{bacon, awesome}, {cabbage, alright}]).
        true
        5> ets:lookup(ingredients, bacon).
        [{bacon,awesome}]
        6> ets:lookup(ingredients, cabbage).
        [{cabbage,alright}]
        7> ets:delete(ingredients, cabbage).
        true
        8> ets:lookup(ingredients, cabbage).
        []



        4> Tabld = ets:new(ingredients, [bag]).
        20496
        5> ets:insert(Tabld, {bacon, delicious}).
        true
        6> ets:insert(Tabld, {bacon, fat}).
        true
        7> ets:insert(Tabld, {bacon, fat}).
        true
        8> ets:lookup(Tabld, bacon).
        [{bacon,delicious},{bacon,fat}]


        11> ets:new(ingredients, [ordered_set, named_table]).  
        ingredients 
        12> ets:insert(ingredients, [{ketchup, "not much"}, {mustard, "a lot"}, {cheese, "yes", "goat"}, {patty, "moose"}, {onions, "a lot", "caramelized"}]).  
        true 
        13> Res1 = ets:first(ingredients).
        cheese 
        14> Res2 = ets:next(ingredients, Res1).       
        ketchup 
        15> Res3 = ets:next(ingredients, Res2).  
        mustard 
        16> ets:last(ingredients).  
        patty 
        17> ets:prev(ingredients, ets:last(ingredients)).  
        onions

ディレクトリを指定して，下の中身をリストにする.file:list_dir()
1> file:list_dir("/Users/wzj/Projects/Web-Programming").
{ok,[".git","AngularJS","Bash","Bootstrap","Chef","Cowboy",
     "elixir","Erlang","Javascript","Nodejs","OSX","Postgresql",
     "RabbitMQ","README.md","Socket.IO","Vagrant"]}
2>

下のfilelib:ensure_dirk関数はabcの親ディレクトリを存在チェックして,あればokを返す
無かったら，しかも権限があれば，作る，権限なければ{error,eacces}を返す

11> filelib:ensure_dir("/Users/wzj/Projects/kkk/abc").
ok

簡単のabcdeを入れると複雑なDataをファイルに書き込む
  
        12> Data = [1,2,3,{car, "Honda"}].
        [1,2,3,{car,"Honda"}]
        15> filelib:ensure_dir("/Users/wzj/Projects/Web-Programming/Erlang/ex20/output").
        ok
        18> file:write_file("/Users/wzj/Projects/Web-Programming/Erlang/ex20/output", "abcde").
        ok
        20> file:write_file("/Users/wzj/Projects/Web-Programming/Erlang/ex20/output", io_lib:fwrite("~p",[Data])).
        ok

分かりやすいコールバック関数

        1> F = fun(X,Y, Operation) -> Operation(X,Y) end .
        #Fun<erl_eval.18.90072148>
        2> Plus = fun(X, Y) -> X+Y end.
        #Fun<erl_eval.12.90072148>
        3> F(2,45, Plus).
        47

if you call ets:new(some_name, []), 
you'll be starting a protected set table, 
without a name. For the name to be used 
as a way to contact a table (and to be 
made unique), the option named_table has 
to be passed to the function. Otherwise, 
the name of the table will purely be for 
documentation purposes and will appear in 
functions such as ets:i(), which print 
information about all ETS tables in the system.
注意：An ets table is deleted as soon as its owning process dies

        8> ets:new(ingredients, [set, named_table]).
        9> ets:insert(ingredients, [{bacon, awesome}, {cabbage, alright}]).
        true
        10> ets:insert(ingredients, {bacon, great}).
        true
        11> ets:lookup(ingredients, bacon).
        [{bacon,great}]

debugの状況で-compile(export_all)をつかいたいので 

        -ifdef(debug).
        -compile(export_all).
        -endif.

Sum starts with the 0(the seed), then the unnamed lambda
function grabs the first item in the list L and puts it
into X. Using X and Sum

        7> L = ["I", "like", "Erlang"].
        ["I","like","Erlang"]
        8> lists:foldl(fun(X, Sum) -> length(X) + Sum end, 0,L).
        11

Erlang only has a limited space for atoms, using 
'list_to_atom' on arbitrary lists can cause the emulator 
to terminate when this limit is reached. It is possible 
to use 'list_to_existing_atom/1' with the caveat that it 
would return a badarg if the atom currently doesn't exist.

        19> list_to_existing_atom("kkk").
        ** exception error: bad argument
        in function  list_to_existing_atom/1
        called as list_to_existing_atom("kkk")
        20> kkk.
        kkk
        21> list_to_existing_atom("kkk").
        kkk


