-module(company).
-include_lib("stdlib/include/qlc.hrl").
-include("company.hrl").
-compile(export_all).

init() ->
    mnesia:start(),

    mnesia:create_table(employee,
                        [{attributes, record_info(fields, employee)}]),
    mnesia:create_table(dept,
                        [{attributes, record_info(fields, dept)}]),
    mnesia:create_table(project,
                        [{attributes, record_info(fields, project)}]),
    mnesia:create_table(manager,
                        [{type, bag},
                         {attributes, record_info(fields, manager)}]),
    mnesia:create_table(at_dep,
                        [{attributes, record_info(fields, at_dep)}]),
    mnesia:create_table(in_proj,
                        [{type, bag},
                         {attributes, record_info(fields, in_proj)}]).
    
table_data() ->
    [

     %% epmplyeeテーブル
     {employee, 104465, "Johnson Torbjorn",   1, male,  99184, {242,038}},
     {employee, 107912, "Carlsson Tuula",     2, female,94556, {242,056}},
     {employee, 114872, "Dacker Bjarne",      3, male,  99415, {221,035}},
     {employee, 104531, "Nilsson Hans",       3, male,  99495, {222,026}},
     {employee, 104659, "Tornkvist Torbjorn", 2, male,  99514, {222,022}},
     {employee, 104732, "Wikstrom Claes",     2, male,  99586, {221,015}},
     {employee, 117716, "Fedoriw Anna",       1, female,99143, {221,031}},
     {employee, 115018, "Mattsson Hakan",     3, male,  99251, {203,348}},

     %% deptテーブル
     {dept, 'B/SF',  "Open Telecom Platform"},
     {dept, 'B/SFP', "OTP - Product Development"},
     {dept, 'B/SFR', "Computer Science Laboratory"},

     %% projectテーブル
     {project, erlang, 1},
     {project, otp, 2},
     {project, beam, 3},
     {project, mnesia, 5},
     {project, wolf, 6},
     {project, documentation, 7},
     {project, www, 8},

     %% managerテーブル
     {manager, 104465, 'B/SF'},
     {manager, 104465, 'B/SFP'},
     {manager, 114872, 'B/SFR'},

     %% at_depテーブル
     %% 社員一人がひとつの部門にしか働けない
     {at_dep, 104465, 'B/SF'},
     {at_dep, 107912, 'B/SF'},
     {at_dep, 114872, 'B/SFR'},
     {at_dep, 104531, 'B/SFR'},
     {at_dep, 104659, 'B/SFR'},
     {at_dep, 104732, 'B/SFR'},
     {at_dep, 117716, 'B/SFP'},
     {at_dep, 115018, 'B/SFP'},

     %% in_projテーブル
     %% 社員一人が複数のプロジェクトを抱えることができる
     {in_proj, 104465, otp},
     {in_proj, 107912, otp},
     {in_proj, 114872, otp},
     {in_proj, 104531, otp},
     {in_proj, 104531, mnesia},
     {in_proj, 104545, wolf},
     {in_proj, 104659, otp},
     {in_proj, 104659, wolf},
     {in_proj, 104732, otp},
     {in_proj, 104732, mnesia},
     {in_proj, 104732, erlang},
     {in_proj, 117716, otp},
     {in_proj, 117716, documentation},
     {in_proj, 115018, otp},
     {in_proj, 115018, mnesia}
    ].

reset_tables() ->
    mnesia:clear_table(employee),
    mnesia:clear_table(dept),
    mnesia:clear_table(project),
    mnesia:clear_table(manager),
    mnesia:clear_table(at_dept),
    mnesia:clear_table(in_proj),
    F = fun() ->
            lists:foreach(fun mnesia:write/1, table_data())
        end,
    mnesia:transaction(F).

insert_emp(Emp, DepId, ProjNames) ->
    Eno   = Emp#employee.emp_no,
    F = fun() ->
            mnesia:write(Emp),
            AtDep = #at_dep{emp=Eno, dept_id=DepId},
            mnesia:write(AtDep),
            mk_projs(Eno, ProjNames)
        end,
    mnesia:transaction(F).

mk_projs(Eno, [ProjName|Tail]) ->
    mnesia:write(#in_proj{emp=Eno, proj_name=ProjName}),
    mk_projs(Eno, Tail);
mk_projs(_, []) ->
    ok.

select_gender(Gender) ->
    F = fun() ->
            Female = #employee{sex=Gender, name='$1', _ = '_'},
            mnesia:select(employee, [{Female, [], ['$1']}])
        end,
    mnesia:transaction(F).

raise(Eno, Raise) ->
    F = fun() ->
            [E] = mnesia:read(employee, Eno, write),
            Salary = E#employee.salary + Raise,
            New = E#employee{salary= Salary},
            mnesia:write(New)
        end,
    mnesia:transaction(F).

do(Q) ->
    F = fun() ->
            qlc:e(Q) end,
    {atomic, Val} = mnesia:transaction(F),
    Val.

select_emp(Eno) ->
    do(qlc:q([X || X <- mnesia:table(employee),
                   X#employee.emp_no == Eno])).

raise_females(Amount) ->
    F = fun() ->
            Q = qlc:q([ E || E <- mnesia:table(employee),
                              E#employee.sex == female]),
            Fs = qlc:e(Q),
            over_write(Fs, Amount)
    end,
    mnesia:transaction(F).

over_write([E | Tail], Amount) ->
    Salary = E#employee.salary + Amount,
    New = E#employee{salary = Salary},
    mnesia:write(New),
    1 + over_write(Tail, Amount);
over_write([], _) ->
    0.



