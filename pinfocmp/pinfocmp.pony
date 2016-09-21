use ".."
use "options"

actor Main
  new create(env: Env) =>
    let env_vars = EnvVars(env.vars())
    match GetTerminalName(env_vars)
    | None =>
      env.out.print("Couldn't determine terminal type."
      " $TERM is empty or database is unparsable.")
    | let filename: String =>
      try
        match GetTerminfoDb(filename, env.root as AmbientAuth)
        | None =>
          env.out.print("Couldn't read " + filename)
        | let db: TerminfoDb =>
          env.out.print("Whee, opened " + filename)
          env.out.print("name = " + db.name)
          env.out.print("")
          let bool_names_full = BoolNamesFull()
          for (i, cap_name) in BoolNamesShort().pairs() do
            env.out.print(bool_names_full(i)+" ("+cap_name+") = "+db(cap_name).string())
          end

          env.out.write("\t")
          for (i, cap_name) in BoolNamesShort().pairs() do
            match db(cap_name)
            | true => env.out.write(cap_name + ", ")
            end
          end

          env.out.print("\n")
          let num_names_full = NumNamesFull()
          for (i, cap_name) in NumNamesShort().pairs() do
            env.out.print(num_names_full(i)+" ("+cap_name+") = "+db(cap_name).string())
          end

          env.out.print("")
          for k in db.str_names_full.values() do
            match db(k)
            | let u: String => env.out.print(k + ": " + u.size().string())
            end
          end

          env.out.print("")
          try
            let s = db(env.args(1)) as String
            env.out.print(env.args(1) + ": " + s.size().string())
            env.out.print(env.args(1) + ": " + "'" + s + "'")
          else
            env.out.print("shit")
          end
        end
      else
        env.out.print("Couldn't parse terminfo database.")
      end
    end
