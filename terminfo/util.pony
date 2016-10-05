use "files"
use "collections"
use "options"

primitive GetTerminfoDb
  """
  Read the compiled terminfo database located at the given path. Returns None on
  errors, including parse errors.
  """
  fun apply(filename: String, auth: AmbientAuth):
      (None | TerminfoDb) =>
    try
      let f = OpenFile(FilePath(auth, filename)) as File
      /* XXX biggest i saw on os x was 3402 lol. There's probably a constant max
       * somewhere in the ncurses codebase. */
      TerminfoDb(f.read(2 << 12))
    else
      None
    end

primitive GetTerminalName
  """
  Get name and terminfo database location for current terminal, according to
  $TERM.
  """
  fun apply(vars: Map[String, String] val): (None | String) =>
    try
      let term_name = vars("TERM")
      let first_letter = recover val
        let hex_fmt = FormatSettingsInt.set_format(FormatHexSmallBare).set_width(2)
        term_name(0).string(hex_fmt)
      end
      let filename = Path.join(Path.join("/usr/share/terminfo", first_letter),
                              term_name)
      filename
    else
      None
    end

primitive GetTerminalInfo
  """
  For the truly lazy. Get and parse the terminfo database for the current
  terminal, according to $TERM.
  """
  fun apply(env: Env): (None | Terminfo) =>
    let env_vars = EnvVars(env.vars())
    match GetTerminalName(env_vars)
    | let filename: String =>
      try
        match GetTerminfoDb(filename, env.root as AmbientAuth)
        | let db: TerminfoDb => Terminfo(db)
        end
      end
    else
      None
    end
