Erlangのdbgモジュールでソースコードをトレースしたいです。 まず感覚をつかめめるために簡単のソースコードを使用します。

sum.erlファイルを作成します。

```
-module(sum).
-export([sum/1]).

sum(L) -> 
   sum(L, 0).

sum([H|T], Acc) -> 
   sum(T, H + Acc); 

sum([], Acc) ->
   Acc.
```

実行します。

```
1> dbg:start().     % start dbg
{ok,<0.35.0>}
2> dbg:tracer().    % start a simple tracer process 
{ok,<0.35.0>}
3> dbg:p(all, c).   % trace calls (c) of that MFA for all processes.
{ok,[{matched,nonode@nohost,26}]}
4> dbg:tpl(sum, sum, x).        % x means print exceptions ((and normal return values) 
{ok,[{matched,nonode@nohost,2},{saved,x}]}
5> sum:sum([1,2,3,4]).
(<0.33.0>) call sum:sum([1,2,3,4])
(<0.33.0>) call sum:sum([1,2,3,4],0)
(<0.33.0>) call sum:sum([2,3,4],1)
(<0.33.0>) call sum:sum([3,4],3)
(<0.33.0>) call sum:sum([4],6)
(<0.33.0>) call sum:sum([],10)
(<0.33.0>) returned from sum:sum/2 -> 10
(<0.33.0>) returned from sum:sum/2 -> 10
(<0.33.0>) returned from sum:sum/2 -> 10
(<0.33.0>) returned from sum:sum/2 -> 10
(<0.33.0>) returned from sum:sum/2 -> 10
(<0.33.0>) returned from sum:sum/1 -> 10
10
```
