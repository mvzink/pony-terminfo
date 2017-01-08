use "files"
use "collections"
use "options"
use "format"

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
      Format.int[U8](where x = term_name(0), fmt = FormatHexSmallBare, width = 2)
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
