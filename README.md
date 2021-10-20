monad
=====

An OTP application

Build
-----

    $ rebar3 compile

Test
----

    $ rebar3 shell


Then:


```
application:start(erlperf).

erlperf:run({test, multi_step, [{input, good}]}).
erlperf:run({test, multi_step1, [{input, good}]}).
erlperf:run({test, multi_step2, [{input, good}]}).

erlperf:run({test, multi_step, [{input, fail2}]}).
erlperf:run({test, multi_step1, [{input, fail2}]}).
erlperf:run({test, multi_step2, [{input, fail2}]}).
```

`multi_step` uses erlando's do monad setup with {ok, Result}, {error, Error}.

`multi_step1` uses nested cases.

`multi_step2` uses Erlang's fail fast philosophy.

erlperf showed erlando's about 60% slower. In reality it's probably fine as this is not supposed to be in tight loop. I suspect it would be similar perf to manually fold list of functions.
