{application, cowboy_post, [
	{description, ""},
	{vsn, "0.1.0"},
	{id, "0ba4fa4-dirty"},
	{modules, ['cowboy_post_app', 'cowboy_post_sup', 'toppage_handler']},
	{registered, []},
	{applications, [
		kernel,
		stdlib,
        cowboy
	]},
	{mod, {cowboy_post_app, []}},
	{env, []}
]}.
