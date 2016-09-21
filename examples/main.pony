use ".."

actor Main
  new create(env: Env) =>
    try
      let db = GetTerminalInfo(env) as TerminfoDb
      let underline = db("smul") as String
      let underline_off = db("rmul") as String
      env.out.print("Hello " + underline + "world!" + underline_off)

      // TODO: make this API more convenient, maybe add constants (4 = blue)
      let params: Array[StackObject] val = recover val
        let params' = recover trn Array[StackObject]() end
        params'.push(4)
        params'
      end
      let setaf = recover val ParseString(db("setaf") as String, params) end
      let sgr0 = db("sgr0") as String
      env.out.print("Greetings " + setaf + "Pony!" + sgr0 + " :)")
    end
