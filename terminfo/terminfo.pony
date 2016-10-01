"""
# terminfo package

Facilities for loading terminfo compiled databases. A typed wrapper over a Map
allows evaluating parameterized string capabilities (such as `sgr`) in a
type-safe manner, and querying capabilities by name without typing out strings
yourself; we don't want you hardcoding strings yourself, after all!
```
"""

class Terminfo
  """
  A type-safe wrapper over the raw TerminfoDb. Currently only full capability
  names have corresponding methods, even though the underlying Map also stores
  capabilities by their short names.

  String capabilities with parameters are evaluated tparm-style (see
  `ParamStack`). I guess terminfo might technically allow stack evaluation of
  String capabilities that don't have parameters, but that's not accounted for
  here.

  These methods will error if
    1) the terminal type doesn't have that capability
    2) some programming implementation bug gave the capability the wrong type
       (`Bool` vs. `U16` vs. `String`; yell at me please)
    3) tparm-style evaluation of a string capability fails
       - stack programming error
       - incorrect parameter types

  I tried to guess the correct parameter types for capabilities I can't find in
  a database on my machine, but some are probably wrong. I'm not planning on
  testing a subset of terminals covering all capabilities, or auditing
  capabilities I'm not going to use, so those errors are probably going to lurk.
  """

  let _db: TerminfoDb

  new create(db: TerminfoDb) =>
    _db = db

  // Booleans
  fun auto_left_margin(): Bool ? =>
    _db("auto_left_margin") as Bool

  fun auto_right_margin(): Bool ? =>
    _db("auto_right_margin") as Bool

  fun no_esc_ctlc(): Bool ? =>
    _db("no_esc_ctlc") as Bool

  fun ceol_standout_glitch(): Bool ? =>
    _db("ceol_standout_glitch") as Bool

  fun eat_newline_glitch(): Bool ? =>
    _db("eat_newline_glitch") as Bool

  fun erase_overstrike(): Bool ? =>
    _db("erase_overstrike") as Bool

  fun generic_type(): Bool ? =>
    _db("generic_type") as Bool

  fun hard_copy(): Bool ? =>
    _db("hard_copy") as Bool

  fun has_meta_key(): Bool ? =>
    _db("has_meta_key") as Bool

  fun has_status_line(): Bool ? =>
    _db("has_status_line") as Bool

  fun insert_null_glitch(): Bool ? =>
    _db("insert_null_glitch") as Bool

  fun memory_above(): Bool ? =>
    _db("memory_above") as Bool

  fun memory_below(): Bool ? =>
    _db("memory_below") as Bool

  fun move_insert_mode(): Bool ? =>
    _db("move_insert_mode") as Bool

  fun move_standout_mode(): Bool ? =>
    _db("move_standout_mode") as Bool

  fun over_strike(): Bool ? =>
    _db("over_strike") as Bool

  fun status_line_esc_ok(): Bool ? =>
    _db("status_line_esc_ok") as Bool

  fun dest_tabs_magic_smso(): Bool ? =>
    _db("dest_tabs_magic_smso") as Bool

  fun tilde_glitch(): Bool ? =>
    _db("tilde_glitch") as Bool

  fun transparent_underline(): Bool ? =>
    _db("transparent_underline") as Bool

  fun xon_xoff(): Bool ? =>
    _db("xon_xoff") as Bool

  fun needs_xon_xoff(): Bool ? =>
    _db("needs_xon_xoff") as Bool

  fun prtr_silent(): Bool ? =>
    _db("prtr_silent") as Bool

  fun hard_cursor(): Bool ? =>
    _db("hard_cursor") as Bool

  fun non_rev_rmcup(): Bool ? =>
    _db("non_rev_rmcup") as Bool

  fun no_pad_char(): Bool ? =>
    _db("no_pad_char") as Bool

  fun non_dest_scroll_region(): Bool ? =>
    _db("non_dest_scroll_region") as Bool

  fun can_change(): Bool ? =>
    _db("can_change") as Bool

  fun back_color_erase(): Bool ? =>
    _db("back_color_erase") as Bool

  fun hue_lightness_saturation(): Bool ? =>
    _db("hue_lightness_saturation") as Bool

  fun col_addr_glitch(): Bool ? =>
    _db("col_addr_glitch") as Bool

  fun cr_cancels_micro_mode(): Bool ? =>
    _db("cr_cancels_micro_mode") as Bool

  fun has_print_wheel(): Bool ? =>
    _db("has_print_wheel") as Bool

  fun row_addr_glitch(): Bool ? =>
    _db("row_addr_glitch") as Bool

  fun semi_auto_right_margin(): Bool ? =>
    _db("semi_auto_right_margin") as Bool

  fun cpi_changes_res(): Bool ? =>
    _db("cpi_changes_res") as Bool

  fun lpi_changes_res(): Bool ? =>
    _db("lpi_changes_res") as Bool

  fun backspaces_with_bs(): Bool ? =>
    _db("backspaces_with_bs") as Bool

  fun crt_no_scrolling(): Bool ? =>
    _db("crt_no_scrolling") as Bool

  fun no_correctly_working_cr(): Bool ? =>
    _db("no_correctly_working_cr") as Bool

  fun gnu_has_meta_key(): Bool ? =>
    _db("gnu_has_meta_key") as Bool

  fun linefeed_is_newline(): Bool ? =>
    _db("linefeed_is_newline") as Bool

  fun has_hardware_tabs(): Bool ? =>
    _db("has_hardware_tabs") as Bool

  fun return_does_clr_eol(): Bool ? =>
    _db("return_does_clr_eol") as Bool


  // Numerics

  fun columns(): U16 ? =>
    _db("columns") as U16

  fun init_tabs(): U16 ? =>
    _db("init_tabs") as U16

  fun lines(): U16 ? =>
    _db("lines") as U16

  fun lines_of_memory(): U16 ? =>
    _db("lines_of_memory") as U16

  fun magic_cookie_glitch(): U16 ? =>
    _db("magic_cookie_glitch") as U16

  fun padding_baud_rate(): U16 ? =>
    _db("padding_baud_rate") as U16

  fun virtual_terminal(): U16 ? =>
    _db("virtual_terminal") as U16

  fun width_status_line(): U16 ? =>
    _db("width_status_line") as U16

  fun num_labels(): U16 ? =>
    _db("num_labels") as U16

  fun label_height(): U16 ? =>
    _db("label_height") as U16

  fun label_width(): U16 ? =>
    _db("label_width") as U16

  fun max_attributes(): U16 ? =>
    _db("max_attributes") as U16

  fun maximum_windows(): U16 ? =>
    _db("maximum_windows") as U16

  fun max_colors(): U16 ? =>
    _db("max_colors") as U16

  fun max_pairs(): U16 ? =>
    _db("max_pairs") as U16

  fun no_color_video(): U16 ? =>
    _db("no_color_video") as U16

  fun buffer_capacity(): U16 ? =>
    _db("buffer_capacity") as U16

  fun dot_vert_spacing(): U16 ? =>
    _db("dot_vert_spacing") as U16

  fun dot_horz_spacing(): U16 ? =>
    _db("dot_horz_spacing") as U16

  fun max_micro_address(): U16 ? =>
    _db("max_micro_address") as U16

  fun max_micro_jump(): U16 ? =>
    _db("max_micro_jump") as U16

  fun micro_col_size(): U16 ? =>
    _db("micro_col_size") as U16

  fun micro_line_size(): U16 ? =>
    _db("micro_line_size") as U16

  fun number_of_pins(): U16 ? =>
    _db("number_of_pins") as U16

  fun output_res_char(): U16 ? =>
    _db("output_res_char") as U16

  fun output_res_line(): U16 ? =>
    _db("output_res_line") as U16

  fun output_res_horz_inch(): U16 ? =>
    _db("output_res_horz_inch") as U16

  fun output_res_vert_inch(): U16 ? =>
    _db("output_res_vert_inch") as U16

  fun print_rate(): U16 ? =>
    _db("print_rate") as U16

  fun wide_char_size(): U16 ? =>
    _db("wide_char_size") as U16

  fun buttons(): U16 ? =>
    _db("buttons") as U16

  fun bit_image_entwining(): U16 ? =>
    _db("bit_image_entwining") as U16

  fun bit_image_type(): U16 ? =>
    _db("bit_image_type") as U16

  fun magic_cookie_glitch_ul(): U16 ? =>
    _db("magic_cookie_glitch_ul") as U16

  fun carriage_return_delay(): U16 ? =>
    _db("carriage_return_delay") as U16

  fun new_line_delay(): U16 ? =>
    _db("new_line_delay") as U16

  fun backspace_delay(): U16 ? =>
    _db("backspace_delay") as U16

  fun horizontal_tab_delay(): U16 ? =>
    _db("horizontal_tab_delay") as U16

  fun number_of_function_keys(): U16 ? =>
    _db("number_of_function_keys") as U16

  // Strings

  fun back_tab(): String ? =>
    _db("back_tab") as String

  fun bell(): String ? =>
    _db("bell") as String

  fun carriage_return(): String ? =>
    _db("carriage_return") as String

  fun change_scroll_region(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(_db("change_scroll_region") as String, params)

  fun clear_all_tabs(): String ? =>
    _db("clear_all_tabs") as String

  fun clear_screen(): String ? =>
    _db("clear_screen") as String

  fun clr_eol(): String ? =>
    _db("clr_eol") as String

  fun clr_eos(): String ? =>
    _db("clr_eos") as String

  fun column_address(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("column_address") as String, params)

  fun command_character(): String ? =>
    _db("command_character") as String

  fun cursor_address(row: U64, column: U64): String ? =>
    let params = recover val [as StackObject: row, column] end
    ParseString(_db("cursor_address") as String, params)

  fun cursor_down(): String ? =>
    _db("cursor_down") as String

  fun cursor_home(): String ? =>
    _db("cursor_home") as String

  fun cursor_invisible(): String ? =>
    _db("cursor_invisible") as String

  fun cursor_left(): String ? =>
    _db("cursor_left") as String

  fun cursor_mem_address(row: U64, column: U64): String ? =>
    let params = recover val [as StackObject: row, column] end
    ParseString(_db("cursor_mem_address") as String, params)

  fun cursor_normal(): String ? =>
    _db("cursor_normal") as String

  fun cursor_right(): String ? =>
    _db("cursor_right") as String

  fun cursor_to_ll(): String ? =>
    _db("cursor_to_ll") as String

  fun cursor_up(): String ? =>
    _db("cursor_up") as String

  fun cursor_visible(): String ? =>
    _db("cursor_visible") as String

  fun delete_character(): String ? =>
    _db("delete_character") as String

  fun delete_line(): String ? =>
    _db("delete_line") as String

  fun dis_status_line(): String ? =>
    _db("dis_status_line") as String

  fun down_half_line(): String ? =>
    _db("down_half_line") as String

  fun enter_alt_charset_mode(): String ? =>
    _db("enter_alt_charset_mode") as String

  fun enter_blink_mode(): String ? =>
    _db("enter_blink_mode") as String

  fun enter_bold_mode(): String ? =>
    _db("enter_bold_mode") as String

  fun enter_ca_mode(): String ? =>
    _db("enter_ca_mode") as String

  fun enter_delete_mode(): String ? =>
    _db("enter_delete_mode") as String

  fun enter_dim_mode(): String ? =>
    _db("enter_dim_mode") as String

  fun enter_insert_mode(): String ? =>
    _db("enter_insert_mode") as String

  fun enter_secure_mode(): String ? =>
    _db("enter_secure_mode") as String

  fun enter_protected_mode(): String ? =>
    _db("enter_protected_mode") as String

  fun enter_reverse_mode(): String ? =>
    _db("enter_reverse_mode") as String

  fun enter_standout_mode(): String ? =>
    _db("enter_standout_mode") as String

  fun enter_underline_mode(): String ? =>
    _db("enter_underline_mode") as String

  fun erase_chars(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("erase_chars") as String, params)

  fun exit_alt_charset_mode(): String ? =>
    _db("exit_alt_charset_mode") as String

  fun exit_attribute_mode(): String ? =>
    _db("exit_attribute_mode") as String

  fun exit_ca_mode(): String ? =>
    _db("exit_ca_mode") as String

  fun exit_delete_mode(): String ? =>
    _db("exit_delete_mode") as String

  fun exit_insert_mode(): String ? =>
    _db("exit_insert_mode") as String

  fun exit_standout_mode(): String ? =>
    _db("exit_standout_mode") as String

  fun exit_underline_mode(): String ? =>
    _db("exit_underline_mode") as String

  fun flash_screen(): String ? =>
    _db("flash_screen") as String

  fun form_feed(): String ? =>
    _db("form_feed") as String

  fun from_status_line(): String ? =>
    _db("from_status_line") as String

  fun init_1string(): String ? =>
    _db("init_1string") as String

  fun init_2string(): String ? =>
    _db("init_2string") as String

  fun init_3string(): String ? =>
    _db("init_3string") as String

  fun init_file(): String ? =>
    _db("init_file") as String

  fun insert_character(): String ? =>
    _db("insert_character") as String

  fun insert_line(): String ? =>
    _db("insert_line") as String

  fun insert_padding(): String ? =>
    _db("insert_padding") as String

  fun key_backspace(): String ? =>
    _db("key_backspace") as String

  fun key_catab(): String ? =>
    _db("key_catab") as String

  fun key_clear(): String ? =>
    _db("key_clear") as String

  fun key_ctab(): String ? =>
    _db("key_ctab") as String

  fun key_dc(): String ? =>
    _db("key_dc") as String

  fun key_dl(): String ? =>
    _db("key_dl") as String

  fun key_down(): String ? =>
    _db("key_down") as String

  fun key_eic(): String ? =>
    _db("key_eic") as String

  fun key_eol(): String ? =>
    _db("key_eol") as String

  fun key_eos(): String ? =>
    _db("key_eos") as String

  fun key_f0(): String ? =>
    _db("key_f0") as String

  fun key_f1(): String ? =>
    _db("key_f1") as String

  fun key_f10(): String ? =>
    _db("key_f10") as String

  fun key_f2(): String ? =>
    _db("key_f2") as String

  fun key_f3(): String ? =>
    _db("key_f3") as String

  fun key_f4(): String ? =>
    _db("key_f4") as String

  fun key_f5(): String ? =>
    _db("key_f5") as String

  fun key_f6(): String ? =>
    _db("key_f6") as String

  fun key_f7(): String ? =>
    _db("key_f7") as String

  fun key_f8(): String ? =>
    _db("key_f8") as String

  fun key_f9(): String ? =>
    _db("key_f9") as String

  fun key_home(): String ? =>
    _db("key_home") as String

  fun key_ic(): String ? =>
    _db("key_ic") as String

  fun key_il(): String ? =>
    _db("key_il") as String

  fun key_left(): String ? =>
    _db("key_left") as String

  fun key_ll(): String ? =>
    _db("key_ll") as String

  fun key_npage(): String ? =>
    _db("key_npage") as String

  fun key_ppage(): String ? =>
    _db("key_ppage") as String

  fun key_right(): String ? =>
    _db("key_right") as String

  fun key_sf(): String ? =>
    _db("key_sf") as String

  fun key_sr(): String ? =>
    _db("key_sr") as String

  fun key_stab(): String ? =>
    _db("key_stab") as String

  fun key_up(): String ? =>
    _db("key_up") as String

  fun keypad_local(): String ? =>
    _db("keypad_local") as String

  fun keypad_xmit(): String ? =>
    _db("keypad_xmit") as String

  fun lab_f0(): String ? =>
    _db("lab_f0") as String

  fun lab_f1(): String ? =>
    _db("lab_f1") as String

  fun lab_f10(): String ? =>
    _db("lab_f10") as String

  fun lab_f2(): String ? =>
    _db("lab_f2") as String

  fun lab_f3(): String ? =>
    _db("lab_f3") as String

  fun lab_f4(): String ? =>
    _db("lab_f4") as String

  fun lab_f5(): String ? =>
    _db("lab_f5") as String

  fun lab_f6(): String ? =>
    _db("lab_f6") as String

  fun lab_f7(): String ? =>
    _db("lab_f7") as String

  fun lab_f8(): String ? =>
    _db("lab_f8") as String

  fun lab_f9(): String ? =>
    _db("lab_f9") as String

  fun meta_off(): String ? =>
    _db("meta_off") as String

  fun meta_on(): String ? =>
    _db("meta_on") as String

  fun newline(): String ? =>
    _db("newline") as String

  fun pad_char(): String ? =>
    _db("pad_char") as String

  fun parm_dch(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("parm_dch") as String, params)

  fun parm_delete_line(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("parm_delete_line") as String, params)

  fun parm_down_cursor(): String ? =>
    _db("parm_down_cursor") as String

  fun parm_ich(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("parm_ich") as String, params)

  fun parm_index(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("parm_index") as String, params)

  fun parm_insert_line(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("parm_insert_line") as String, params)

  fun parm_left_cursor(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("parm_left_cursor") as String, params)

  fun parm_right_cursor(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("parm_right_cursor") as String, params)

  fun parm_rindex(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("parm_rindex") as String, params)

  fun parm_up_cursor(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("parm_up_cursor") as String, params)

  fun pkey_key(key: String, str: String): String ? =>
    // XXX is the function key specified as a string or an int?
    let params = recover val [as StackObject: key, str] end
    ParseString(_db("pkey_key") as String, params)

  fun pkey_local(i: String, j: String): String ? =>
    // XXX is the function key specified as a string or an int?
    let params = recover val [as StackObject: i, j] end
    ParseString(_db("pkey_local") as String, params)

  fun pkey_xmit(i: String, j: String): String ? =>
    // XXX is the function key specified as a string or an int?
    let params = recover val [as StackObject: i, j] end
    ParseString(_db("pkey_xmit") as String, params)

  fun print_screen(): String ? =>
    _db("print_screen") as String

  fun prtr_off(): String ? =>
    _db("prtr_off") as String

  fun prtr_on(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("prtr_on") as String, params)

  fun repeat_char(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(_db("repeat_char") as String, params)

  fun reset_1string(): String ? =>
    _db("reset_1string") as String

  fun reset_2string(): String ? =>
    _db("reset_2string") as String

  fun reset_3string(): String ? =>
    _db("reset_3string") as String

  fun reset_file(): String ? =>
    _db("reset_file") as String

  fun restore_cursor(): String ? =>
    _db("restore_cursor") as String

  fun row_address(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("row_address") as String, params)

  fun save_cursor(): String ? =>
    _db("save_cursor") as String

  fun scroll_forward(): String ? =>
    _db("scroll_forward") as String

  fun scroll_reverse(): String ? =>
    _db("scroll_reverse") as String

  fun set_attributes(i: U64, j: U64, k: U64, l: U64, m: U64, n: U64, o: U64,
                     p: U64, q: U64): String ? =>
    let params = recover val [as StackObject: i, j, k, l, m, n, o, p, q] end
    ParseString(_db("set_attributes") as String, params)

  fun set_tab(): String ? =>
    _db("set_tab") as String

  fun set_window(i: U64, j: U64, k: U64, l: U64): String ? =>
    let params = recover val [as StackObject: i, j, k, l] end
    ParseString(_db("set_window") as String, params)

  fun tab(): String ? =>
    _db("tab") as String

  fun to_status_line(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("to_status_line") as String, params)

  fun underline_char(): String ? =>
    _db("underline_char") as String

  fun up_half_line(): String ? =>
    _db("up_half_line") as String

  fun init_prog(): String ? =>
    _db("init_prog") as String

  fun key_a1(): String ? =>
    _db("key_a1") as String

  fun key_a3(): String ? =>
    _db("key_a3") as String

  fun key_b2(): String ? =>
    _db("key_b2") as String

  fun key_c1(): String ? =>
    _db("key_c1") as String

  fun key_c3(): String ? =>
    _db("key_c3") as String

  fun prtr_non(): String ? =>
    _db("prtr_non") as String

  fun char_padding(): String ? =>
    _db("char_padding") as String

  fun acs_chars(): String ? =>
    _db("acs_chars") as String

  fun plab_norm(i: U64, j: String): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(_db("plab_norm") as String, params)

  fun key_btab(): String ? =>
    _db("key_btab") as String

  fun enter_xon_mode(): String ? =>
    _db("enter_xon_mode") as String

  fun exit_xon_mode(): String ? =>
    _db("exit_xon_mode") as String

  fun enter_am_mode(): String ? =>
    _db("enter_am_mode") as String

  fun exit_am_mode(): String ? =>
    _db("exit_am_mode") as String

  fun xon_character(): String ? =>
    _db("xon_character") as String

  fun xoff_character(): String ? =>
    _db("xoff_character") as String

  fun ena_acs(): String ? =>
    _db("ena_acs") as String

  fun label_on(): String ? =>
    _db("label_on") as String

  fun label_off(): String ? =>
    _db("label_off") as String

  fun key_beg(): String ? =>
    _db("key_beg") as String

  fun key_cancel(): String ? =>
    _db("key_cancel") as String

  fun key_close(): String ? =>
    _db("key_close") as String

  fun key_command(): String ? =>
    _db("key_command") as String

  fun key_copy(): String ? =>
    _db("key_copy") as String

  fun key_create(): String ? =>
    _db("key_create") as String

  fun key_end(): String ? =>
    _db("key_end") as String

  fun key_enter(): String ? =>
    _db("key_enter") as String

  fun key_exit(): String ? =>
    _db("key_exit") as String

  fun key_find(): String ? =>
    _db("key_find") as String

  fun key_help(): String ? =>
    _db("key_help") as String

  fun key_mark(): String ? =>
    _db("key_mark") as String

  fun key_message(): String ? =>
    _db("key_message") as String

  fun key_move(): String ? =>
    _db("key_move") as String

  fun key_next(): String ? =>
    _db("key_next") as String

  fun key_open(): String ? =>
    _db("key_open") as String

  fun key_options(): String ? =>
    _db("key_options") as String

  fun key_previous(): String ? =>
    _db("key_previous") as String

  fun key_print(): String ? =>
    _db("key_print") as String

  fun key_redo(): String ? =>
    _db("key_redo") as String

  fun key_reference(): String ? =>
    _db("key_reference") as String

  fun key_refresh(): String ? =>
    _db("key_refresh") as String

  fun key_replace(): String ? =>
    _db("key_replace") as String

  fun key_restart(): String ? =>
    _db("key_restart") as String

  fun key_resume(): String ? =>
    _db("key_resume") as String

  fun key_save(): String ? =>
    _db("key_save") as String

  fun key_suspend(): String ? =>
    _db("key_suspend") as String

  fun key_undo(): String ? =>
    _db("key_undo") as String

  fun key_sbeg(): String ? =>
    _db("key_sbeg") as String

  fun key_scancel(): String ? =>
    _db("key_scancel") as String

  fun key_scommand(): String ? =>
    _db("key_scommand") as String

  fun key_scopy(): String ? =>
    _db("key_scopy") as String

  fun key_screate(): String ? =>
    _db("key_screate") as String

  fun key_sdc(): String ? =>
    _db("key_sdc") as String

  fun key_sdl(): String ? =>
    _db("key_sdl") as String

  fun key_select(): String ? =>
    _db("key_select") as String

  fun key_send(): String ? =>
    _db("key_send") as String

  fun key_seol(): String ? =>
    _db("key_seol") as String

  fun key_sexit(): String ? =>
    _db("key_sexit") as String

  fun key_sfind(): String ? =>
    _db("key_sfind") as String

  fun key_shelp(): String ? =>
    _db("key_shelp") as String

  fun key_shome(): String ? =>
    _db("key_shome") as String

  fun key_sic(): String ? =>
    _db("key_sic") as String

  fun key_sleft(): String ? =>
    _db("key_sleft") as String

  fun key_smessage(): String ? =>
    _db("key_smessage") as String

  fun key_smove(): String ? =>
    _db("key_smove") as String

  fun key_snext(): String ? =>
    _db("key_snext") as String

  fun key_soptions(): String ? =>
    _db("key_soptions") as String

  fun key_sprevious(): String ? =>
    _db("key_sprevious") as String

  fun key_sprint(): String ? =>
    _db("key_sprint") as String

  fun key_sredo(): String ? =>
    _db("key_sredo") as String

  fun key_sreplace(): String ? =>
    _db("key_sreplace") as String

  fun key_sright(): String ? =>
    _db("key_sright") as String

  fun key_srsume(): String ? =>
    _db("key_srsume") as String

  fun key_ssave(): String ? =>
    _db("key_ssave") as String

  fun key_ssuspend(): String ? =>
    _db("key_ssuspend") as String

  fun key_sundo(): String ? =>
    _db("key_sundo") as String

  fun req_for_input(): String ? =>
    _db("req_for_input") as String

  fun key_f11(): String ? =>
    _db("key_f11") as String

  fun key_f12(): String ? =>
    _db("key_f12") as String

  fun key_f13(): String ? =>
    _db("key_f13") as String

  fun key_f14(): String ? =>
    _db("key_f14") as String

  fun key_f15(): String ? =>
    _db("key_f15") as String

  fun key_f16(): String ? =>
    _db("key_f16") as String

  fun key_f17(): String ? =>
    _db("key_f17") as String

  fun key_f18(): String ? =>
    _db("key_f18") as String

  fun key_f19(): String ? =>
    _db("key_f19") as String

  fun key_f20(): String ? =>
    _db("key_f20") as String

  fun key_f21(): String ? =>
    _db("key_f21") as String

  fun key_f22(): String ? =>
    _db("key_f22") as String

  fun key_f23(): String ? =>
    _db("key_f23") as String

  fun key_f24(): String ? =>
    _db("key_f24") as String

  fun key_f25(): String ? =>
    _db("key_f25") as String

  fun key_f26(): String ? =>
    _db("key_f26") as String

  fun key_f27(): String ? =>
    _db("key_f27") as String

  fun key_f28(): String ? =>
    _db("key_f28") as String

  fun key_f29(): String ? =>
    _db("key_f29") as String

  fun key_f30(): String ? =>
    _db("key_f30") as String

  fun key_f31(): String ? =>
    _db("key_f31") as String

  fun key_f32(): String ? =>
    _db("key_f32") as String

  fun key_f33(): String ? =>
    _db("key_f33") as String

  fun key_f34(): String ? =>
    _db("key_f34") as String

  fun key_f35(): String ? =>
    _db("key_f35") as String

  fun key_f36(): String ? =>
    _db("key_f36") as String

  fun key_f37(): String ? =>
    _db("key_f37") as String

  fun key_f38(): String ? =>
    _db("key_f38") as String

  fun key_f39(): String ? =>
    _db("key_f39") as String

  fun key_f40(): String ? =>
    _db("key_f40") as String

  fun key_f41(): String ? =>
    _db("key_f41") as String

  fun key_f42(): String ? =>
    _db("key_f42") as String

  fun key_f43(): String ? =>
    _db("key_f43") as String

  fun key_f44(): String ? =>
    _db("key_f44") as String

  fun key_f45(): String ? =>
    _db("key_f45") as String

  fun key_f46(): String ? =>
    _db("key_f46") as String

  fun key_f47(): String ? =>
    _db("key_f47") as String

  fun key_f48(): String ? =>
    _db("key_f48") as String

  fun key_f49(): String ? =>
    _db("key_f49") as String

  fun key_f50(): String ? =>
    _db("key_f50") as String

  fun key_f51(): String ? =>
    _db("key_f51") as String

  fun key_f52(): String ? =>
    _db("key_f52") as String

  fun key_f53(): String ? =>
    _db("key_f53") as String

  fun key_f54(): String ? =>
    _db("key_f54") as String

  fun key_f55(): String ? =>
    _db("key_f55") as String

  fun key_f56(): String ? =>
    _db("key_f56") as String

  fun key_f57(): String ? =>
    _db("key_f57") as String

  fun key_f58(): String ? =>
    _db("key_f58") as String

  fun key_f59(): String ? =>
    _db("key_f59") as String

  fun key_f60(): String ? =>
    _db("key_f60") as String

  fun key_f61(): String ? =>
    _db("key_f61") as String

  fun key_f62(): String ? =>
    _db("key_f62") as String

  fun key_f63(): String ? =>
    _db("key_f63") as String

  fun clr_bol(): String ? =>
    _db("clr_bol") as String

  fun clear_margins(): String ? =>
    _db("clear_margins") as String

  fun set_left_margin(): String ? =>
    _db("set_left_margin") as String

  fun set_right_margin(): String ? =>
    _db("set_right_margin") as String

  fun label_format(): String ? =>
    _db("label_format") as String

  fun set_clock(i: U64, j: U64, k: U64): String ? =>
    let params = recover val [as StackObject: i, j, k] end
    ParseString(_db("set_clock") as String, params)

  fun display_clock(): String ? =>
    _db("display_clock") as String

  fun remove_clock(): String ? =>
    _db("remove_clock") as String

  fun create_window(i: U64, j: U64, k: U64, l: U64, h: U64): String ? =>
    let params = recover val [as StackObject: i, j, k, l, h] end
    ParseString(_db("create_window") as String, params)

  fun goto_window(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("goto_window") as String, params)

  fun hangup(): String ? =>
    _db("hangup") as String

  fun dial_phone(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("dial_phone") as String, params)

  fun quick_dial(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("quick_dial") as String, params)

  fun tone(): String ? =>
    _db("tone") as String

  fun pulse(): String ? =>
    _db("pulse") as String

  fun flash_hook(): String ? =>
    _db("flash_hook") as String

  fun fixed_pause(): String ? =>
    _db("fixed_pause") as String

  fun wait_tone(): String ? =>
    _db("wait_tone") as String

  fun user0(): String ? =>
    _db("user0") as String

  fun user1(): String ? =>
    _db("user1") as String

  fun user2(): String ? =>
    _db("user2") as String

  fun user3(): String ? =>
    _db("user3") as String

  fun user4(): String ? =>
    _db("user4") as String

  fun user5(): String ? =>
    _db("user5") as String

  fun user6(): String ? =>
    _db("user6") as String

  fun user7(): String ? =>
    _db("user7") as String

  fun user8(): String ? =>
    _db("user8") as String

  fun user9(): String ? =>
    _db("user9") as String

  fun orig_pair(): String ? =>
    _db("orig_pair") as String

  fun orig_colors(): String ? =>
    _db("orig_colors") as String

  fun initialize_color(i: U64, j: U64, k: U64, l: U64): String ? =>
    let params = recover val [as StackObject: i, j, k, l] end
    ParseString(_db("initialize_color") as String, params)

  fun initialize_pair(i: U64, j: U64, k: U64, l: U64, m: U64, n: U64, o: U64)
    : String ? =>
    let params = recover val [as StackObject: i, j, k, l, m, n, o] end
    ParseString(_db("initialize_pair") as String, params)

  fun set_color_pair(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_color_pair") as String, params)

  fun set_foreground(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_foreground") as String, params)

  fun set_background(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_background") as String, params)

  fun change_char_pitch(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("change_char_pitch") as String, params)

  fun change_line_pitch(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("change_line_pitch") as String, params)

  fun change_res_horz(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("change_res_horz") as String, params)

  fun change_res_vert(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("change_res_vert") as String, params)

  fun define_char(i: U64, j: U64, k: U64): String ? =>
    let params = recover val [as StackObject: i, j, k] end
    ParseString(_db("define_char") as String, params)

  fun enter_doublewide_mode(): String ? =>
    _db("enter_doublewide_mode") as String

  fun enter_draft_quality(): String ? =>
    _db("enter_draft_quality") as String

  fun enter_italics_mode(): String ? =>
    _db("enter_italics_mode") as String

  fun enter_leftward_mode(): String ? =>
    _db("enter_leftward_mode") as String

  fun enter_micro_mode(): String ? =>
    _db("enter_micro_mode") as String

  fun enter_near_letter_quality(): String ? =>
    _db("enter_near_letter_quality") as String

  fun enter_normal_quality(): String ? =>
    _db("enter_normal_quality") as String

  fun enter_shadow_mode(): String ? =>
    _db("enter_shadow_mode") as String

  fun enter_subscript_mode(): String ? =>
    _db("enter_subscript_mode") as String

  fun enter_superscript_mode(): String ? =>
    _db("enter_superscript_mode") as String

  fun enter_upward_mode(): String ? =>
    _db("enter_upward_mode") as String

  fun exit_doublewide_mode(): String ? =>
    _db("exit_doublewide_mode") as String

  fun exit_italics_mode(): String ? =>
    _db("exit_italics_mode") as String

  fun exit_leftward_mode(): String ? =>
    _db("exit_leftward_mode") as String

  fun exit_micro_mode(): String ? =>
    _db("exit_micro_mode") as String

  fun exit_shadow_mode(): String ? =>
    _db("exit_shadow_mode") as String

  fun exit_subscript_mode(): String ? =>
    _db("exit_subscript_mode") as String

  fun exit_superscript_mode(): String ? =>
    _db("exit_superscript_mode") as String

  fun exit_upward_mode(): String ? =>
    _db("exit_upward_mode") as String

  fun micro_column_address(): String ? =>
    _db("micro_column_address") as String

  fun micro_down(): String ? =>
    _db("micro_down") as String

  fun micro_left(): String ? =>
    _db("micro_left") as String

  fun micro_right(): String ? =>
    _db("micro_right") as String

  fun micro_row_address(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("micro_row_address") as String, params)

  fun micro_up(): String ? =>
    _db("micro_up") as String

  fun order_of_pins(): String ? =>
    _db("order_of_pins") as String

  fun parm_down_micro(): String ? =>
    _db("parm_down_micro") as String

  fun parm_left_micro(): String ? =>
    _db("parm_left_micro") as String

  fun parm_right_micro(): String ? =>
    _db("parm_right_micro") as String

  fun parm_up_micro(): String ? =>
    _db("parm_up_micro") as String

  fun select_char_set(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("select_char_set") as String, params)

  fun set_bottom_margin(): String ? =>
    _db("set_bottom_margin") as String

  fun set_bottom_margin_parm(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(_db("set_bottom_margin_parm") as String, params)

  fun set_left_margin_parm(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_left_margin_parm") as String, params)

  fun set_right_margin_parm(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_right_margin_parm") as String, params)

  fun set_top_margin(): String ? =>
    _db("set_top_margin") as String

  fun set_top_margin_parm(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_top_margin_parm") as String, params)

  fun start_bit_image(): String ? =>
    _db("start_bit_image") as String

  fun start_char_set_def(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(_db("start_char_set_def") as String, params)

  fun stop_bit_image(): String ? =>
    _db("stop_bit_image") as String

  fun stop_char_set_def(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("stop_char_set_def") as String, params)

  fun subscript_characters(): String ? =>
    _db("subscript_characters") as String

  fun superscript_characters(): String ? =>
    _db("superscript_characters") as String

  fun these_cause_cr(): String ? =>
    _db("these_cause_cr") as String

  fun zero_motion(): String ? =>
    _db("zero_motion") as String

  fun char_set_names(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("char_set_names") as String, params)

  fun key_mouse(): String ? =>
    _db("key_mouse") as String

  fun mouse_info(): String ? =>
    _db("mouse_info") as String

  fun req_mouse_pos(): String ? =>
    _db("req_mouse_pos") as String

  fun get_mouse(i: U64): String ? =>
    """
    parameter #1 not documented :/
    """
    let params = recover val [as StackObject: i] end
    ParseString(_db("get_mouse") as String, params)

  fun set_a_foreground(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_a_foreground") as String, params)

  fun set_a_background(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_a_background") as String, params)

  fun pkey_plab(i: U64, j: String, k: String): String ? =>
    let params = recover val [as StackObject: i, j, k] end
    ParseString(_db("pkey_plab") as String, params)

  fun device_type(): String ? =>
    _db("device_type") as String

  fun code_set_init(): String ? =>
    _db("code_set_init") as String

  fun set0_des_seq(): String ? =>
    _db("set0_des_seq") as String

  fun set1_des_seq(): String ? =>
    _db("set1_des_seq") as String

  fun set2_des_seq(): String ? =>
    _db("set2_des_seq") as String

  fun set3_des_seq(): String ? =>
    _db("set3_des_seq") as String

  fun set_lr_margin(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(_db("set_lr_margin") as String, params)

  fun set_tb_margin(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(_db("set_tb_margin") as String, params)

  fun bit_image_repeat(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(_db("bit_image_repeat") as String, params)

  fun bit_image_newline(): String ? =>
    _db("bit_image_newline") as String

  fun bit_image_carriage_return(): String ? =>
    _db("bit_image_carriage_return") as String

  fun color_names(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("color_names") as String, params)

  fun define_bit_image_region(): String ? =>
    _db("define_bit_image_region") as String

  fun end_bit_image_region(): String ? =>
    _db("end_bit_image_region") as String

  fun set_color_band(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_color_band") as String, params)

  fun set_page_length(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_page_length") as String, params)

  fun display_pc_char(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("display_pc_char") as String, params)

  fun enter_pc_charset_mode(): String ? =>
    _db("enter_pc_charset_mode") as String

  fun exit_pc_charset_mode(): String ? =>
    _db("exit_pc_charset_mode") as String

  fun enter_scancode_mode(): String ? =>
    _db("enter_scancode_mode") as String

  fun exit_scancode_mode(): String ? =>
    _db("exit_scancode_mode") as String

  fun pc_term_options(): String ? =>
    _db("pc_term_options") as String

  fun scancode_escape(): String ? =>
    _db("scancode_escape") as String

  fun alt_scancode_esc(): String ? =>
    _db("alt_scancode_esc") as String

  fun enter_horizontal_hl_mode(): String ? =>
    _db("enter_horizontal_hl_mode") as String

  fun enter_left_hl_mode(): String ? =>
    _db("enter_left_hl_mode") as String

  fun enter_low_hl_mode(): String ? =>
    _db("enter_low_hl_mode") as String

  fun enter_right_hl_mode(): String ? =>
    _db("enter_right_hl_mode") as String

  fun enter_top_hl_mode(): String ? =>
    _db("enter_top_hl_mode") as String

  fun enter_vertical_hl_mode(): String ? =>
    _db("enter_vertical_hl_mode") as String

  fun set_a_attributes(i: U64, j: U64, k: U64, l: U64, m: U64, n: U64)
    : String ? =>
    let params = recover val [as StackObject: i, j, k, l, m, n] end
    ParseString(_db("set_a_attributes") as String, params)

  fun set_pglen_inch(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(_db("set_pglen_inch") as String, params)

  fun termcap_init2(): String ? =>
    _db("termcap_init2") as String

  fun termcap_reset(): String ? =>
    _db("termcap_reset") as String

  fun linefeed_if_not_lf(): String ? =>
    _db("linefeed_if_not_lf") as String

  fun backspace_if_not_bs(): String ? =>
    _db("backspace_if_not_bs") as String

  fun other_non_function_keys(): String ? =>
    _db("other_non_function_keys") as String

  fun arrow_key_map(): String ? =>
    _db("arrow_key_map") as String

  fun acs_ulcorner(): String ? =>
    _db("acs_ulcorner") as String

  fun acs_llcorner(): String ? =>
    _db("acs_llcorner") as String

  fun acs_urcorner(): String ? =>
    _db("acs_urcorner") as String

  fun acs_lrcorner(): String ? =>
    _db("acs_lrcorner") as String

  fun acs_ltee(): String ? =>
    _db("acs_ltee") as String

  fun acs_rtee(): String ? =>
    _db("acs_rtee") as String

  fun acs_btee(): String ? =>
    _db("acs_btee") as String

  fun acs_ttee(): String ? =>
    _db("acs_ttee") as String

  fun acs_hline(): String ? =>
    _db("acs_hline") as String

  fun acs_vline(): String ? =>
    _db("acs_vline") as String

  fun acs_plus(): String ? =>
    _db("acs_plus") as String

  fun memory_lock(): String ? =>
    _db("memory_lock") as String

  fun memory_unlock(): String ? =>
    _db("memory_unlock") as String

  fun box_chars_1(): String ? =>
    _db("box_chars_1") as String
