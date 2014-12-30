{application,hello_cowboy,
             [{description,"Server static file using cowboy"},
              {vsn,"1"},
              {registered,[]},
              {applications,[kernel,stdlib,cowboy]},
              {mod,{hello_cowboy_app,[]}},
              {env,[{http_port,8080}]},
              {modules,[hello_cowboy_app,hello_cowboy_sup]}]}.
