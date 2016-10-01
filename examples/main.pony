use "../terminfo"

actor Main
  new create(env: Env) =>
    try
      let db = GetTerminalInfo(env) as TerminfoDb
      let tinfo = Terminfo(db)
      env.out.print("Greetings " + tinfo.set_a_foreground(4) +
                    tinfo.enter_underline_mode() + "Pony" +
                    tinfo.exit_attribute_mode() + "! :)")
    end
