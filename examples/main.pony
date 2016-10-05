use "../terminfo"

actor Main
  new create(env: Env) =>
    try
      let db = GetTerminalInfo(env)
      env.out.print("Greetings " + db.set_a_foreground(4) +
                    db.enter_underline_mode() + "Pony" +
                    db.exit_attribute_mode() + "! :)")
    else
      env.out.print("Aw, couldn't get a terminfo database for you. Maybe you " +
                    "don't have $TERM set?")
    end
