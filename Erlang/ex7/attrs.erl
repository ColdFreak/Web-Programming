-module(attrs).
-vsn(1234).
-author({wang, zhijun}).
-purpose("example of attributes").
-compile(export_all).

fac(1) -> 1;
fac(N) -> N * fac(N-1).

