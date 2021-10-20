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
