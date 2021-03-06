-module(test).

-compile({parse_transform, cut}).
-compile({parse_transform, do}).

-export([
         test_cut/0, 
         test_monad/0, 
         multi_step/1,
         multi_step1/1,
         multi_step2/1,
         multi_step2a/1
        ]).

test_cut() ->
    AddOne = add(1, _),
    io:format("~p", [AddOne(41)]).

test_monad() ->
    io:format("multi_step(bad) -> ~p~n", multi_step(bad)),
    io:format("multi_step({input, good}) -> ~p~n", multi_step({input, good})).

multi_step(Input) ->
    do([ error_m ||
         Input1 = {input, Input},
         Res <- step1(Input1),
         Final <- step2(Res),
         Final
       ]).

multi_step1(Input) ->
    case step1(Input) of
        {ok, Res} -> case step2(Res) of
                         {ok, Final} -> Final;
                         Other -> Other
                     end;
        Other -> Other
    end.

multi_step2(Input) ->
    {ok, Res} = step1(Input),
    {ok, Final} = step2(Res),
    Final.


multi_step2a(Input) ->
    try
        multi_step2a_inner(Input)
    catch
        failure2 ->
            {error, failure2};
        bagarg_step2 ->
            {error, bagarg_step2}
    end.

multi_step2a_inner(Input) ->
    Res = step1a(Input),
    step2a(Res).

% utilities
add(A, B) ->
    A + B.

step1({input, good}) ->
    {ok, {input, fine}};
step1({input, fail2}) ->
    {ok, {input, fail2}};
step1(Other) ->
    {error, {bagarg_step1, Other}}.

step2({input, fine}) ->
    {ok, result};
step2({input, fail2}) ->
    {error, failure2};
step2(Other) ->
    {error, {bagarg_step2, Other}}.

step1a({input, good}) ->
    {input, fine};
step1a({input, fail2}) ->
    {input, fail2};
step1a(Other) ->
    throw({bagarg_step1, Other}).

step2a({input, fine}) ->
    result;
step2a({input, fail2}) ->
    throw(failure2);
step2a(Other) ->
    throw({bagarg_step2, Other}).

