-module(record).
-compile(export_all).

-record(todo, {status=reminder, who=joe, text}).


