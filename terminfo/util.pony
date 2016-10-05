use "files"
use "collections"
use "options"

primitive GetTerminfoDb
  """
  Read the compiled terminfo database located at the given path. Returns None on
  errors, including parse errors.
  """
  fun apply(filename: String, auth: AmbientAuth): TerminfoDb ? =>
    let f = OpenFile(FilePath(auth, filename)) as File
    TerminfoDb(f.read(1 << 12))

primitive GetTerminalName
  """
  Get name and terminfo database location for current terminal, according to
  $TERM.
  """
  fun apply(vars: Map[String, String] val): String ? =>
    let term_name = vars("TERM")
    let first_letter = recover val
      let hex_fmt = FormatSettingsInt.set_format(FormatHexSmallBare).set_width(2)
      term_name(0).string(hex_fmt)
    end
    Path.join(Path.join("/usr/share/terminfo", first_letter), term_name)

primitive GetTerminalInfo
  """
  For the truly lazy. Get and parse the terminfo database for the current
  terminal, according to $TERM.
  """
  fun apply(env: Env): Terminfo ? =>
    let filename = GetTerminalName(EnvVars(env.vars()))
    let db = GetTerminfoDb(filename, env.root as AmbientAuth)
    Terminfo(db)
