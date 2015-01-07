-record(employee, {emp_no, 
                   name,
                   salary,
                   sex,
                   phone,
                   room_no}).
-record(dept, {id,
               name}).

-record(project, {name,
                  number}).

-record(manager, {emp, dept}).

-record(at_dep, {emp,
                 dept_id}).

-record(in_proj, {emp,
                  proj_name}).
