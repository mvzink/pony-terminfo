# pterminfo

Let's do cool stuff in terminals!

Let's print "Greetings Pony!", but underline the word "Pony". And make it blue.

```pony
use "terminfo"

actor Main
  new create(env: Env) =>
    try
      let db = GetTerminalInfo(env) as TerminfoDb
      let tinfo = Terminfo(db)
      env.out.print("Greetings " + tinfo.set_a_foreground(4) +
                    tinfo.enter_underline_mode() + "Pony" +
                    tinfo.exit_attribute_mode() + "!")
    end
```

This is a Pony reimplementation of terminfo/libtinfo.

Currently supports:

* Detect terminal type... okay, well, only from `$TERM`. And we only look for
  the entry in `/usr/share/terminfo`, but it could be in other places. (*TODO*.)
* Parse the corresponding compiled terminfo database and shove all the
  capabilities into a HashMap.
* Wrap it (with types!) so you don't have to hardcode strings yourself.
* Evaluate parameterized string capabilities (such as `sgr`/`set_attributes`).
