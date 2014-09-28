{application, ex20, [
	{description, ""},
	{vsn, "0.1.0"},
	{modules, ['ex20_app', 'ex20_sup', 'hello_handler']},
	{registered, []},
	{applications, [
		kernel,
		stdlib,
        cowboy
	]},
	{mod, {ex20_app, []}},
	{env, []}
]}.
