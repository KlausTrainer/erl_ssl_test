%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(erl_ssl_test_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.

start(_Type, _Args) ->
    ok = ssl:start(),
    PrivDir = code:priv_dir(erl_ssl_test),
    CaCertfile = PrivDir ++ "/ssl/ca.crt",
    Certfile = PrivDir ++ "/ssl/server.crt",
    Keyfile = PrivDir ++ "/ssl/server.key",
	{ok, _} = ranch:start_listener(erl_ssl_test, 1, ranch_ssl, [
        {port, 5555},
        {cacertfile, CaCertfile},
        {certfile, Certfile},
        {keyfile, Keyfile},
        {ciphers, ssl:cipher_suites()}
    ], echo_protocol, []),
	erl_ssl_test_sup:start_link().

stop(_State) ->
	ok.
