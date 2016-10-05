use "../terminfo"

actor Main
  new create(env: Env) =>
    try
      let db = GetTerminalInfo(env) as Terminfo
      env.out.print("Greetings " + db.set_a_foreground(4) +
                    db.enter_underline_mode() + "Pony" +
                    db.exit_attribute_mode() + "! :)")
    end
