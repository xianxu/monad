%%%-------------------------------------------------------------------
%% @doc monad public API
%% @end
%%%-------------------------------------------------------------------

-module(monad_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    monad_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
