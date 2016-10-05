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

  let raw: TerminfoDb

  new create(db: TerminfoDb) =>
    raw = db

  // Booleans
  fun auto_left_margin(): Bool ? =>
    raw("auto_left_margin") as Bool

  fun auto_right_margin(): Bool ? =>
    raw("auto_right_margin") as Bool

  fun no_esc_ctlc(): Bool ? =>
    raw("no_esc_ctlc") as Bool

  fun ceol_standout_glitch(): Bool ? =>
    raw("ceol_standout_glitch") as Bool

  fun eat_newline_glitch(): Bool ? =>
    raw("eat_newline_glitch") as Bool

  fun erase_overstrike(): Bool ? =>
    raw("erase_overstrike") as Bool

  fun generic_type(): Bool ? =>
    raw("generic_type") as Bool

  fun hard_copy(): Bool ? =>
    raw("hard_copy") as Bool

  fun has_meta_key(): Bool ? =>
    raw("has_meta_key") as Bool

  fun has_status_line(): Bool ? =>
    raw("has_status_line") as Bool

  fun insert_null_glitch(): Bool ? =>
    raw("insert_null_glitch") as Bool

  fun memory_above(): Bool ? =>
    raw("memory_above") as Bool

  fun memory_below(): Bool ? =>
    raw("memory_below") as Bool

  fun move_insert_mode(): Bool ? =>
    raw("move_insert_mode") as Bool

  fun move_standout_mode(): Bool ? =>
    raw("move_standout_mode") as Bool

  fun over_strike(): Bool ? =>
    raw("over_strike") as Bool

  fun status_line_esc_ok(): Bool ? =>
    raw("status_line_esc_ok") as Bool

  fun dest_tabs_magic_smso(): Bool ? =>
    raw("dest_tabs_magic_smso") as Bool

  fun tilde_glitch(): Bool ? =>
    raw("tilde_glitch") as Bool

  fun transparent_underline(): Bool ? =>
    raw("transparent_underline") as Bool

  fun xon_xoff(): Bool ? =>
    raw("xon_xoff") as Bool

  fun needs_xon_xoff(): Bool ? =>
    raw("needs_xon_xoff") as Bool

  fun prtr_silent(): Bool ? =>
    raw("prtr_silent") as Bool

  fun hard_cursor(): Bool ? =>
    raw("hard_cursor") as Bool

  fun non_rev_rmcup(): Bool ? =>
    raw("non_rev_rmcup") as Bool

  fun no_pad_char(): Bool ? =>
    raw("no_pad_char") as Bool

  fun non_dest_scroll_region(): Bool ? =>
    raw("non_dest_scroll_region") as Bool

  fun can_change(): Bool ? =>
    raw("can_change") as Bool

  fun back_color_erase(): Bool ? =>
    raw("back_color_erase") as Bool

  fun hue_lightness_saturation(): Bool ? =>
    raw("hue_lightness_saturation") as Bool

  fun col_addr_glitch(): Bool ? =>
    raw("col_addr_glitch") as Bool

  fun cr_cancels_micro_mode(): Bool ? =>
    raw("cr_cancels_micro_mode") as Bool

  fun has_print_wheel(): Bool ? =>
    raw("has_print_wheel") as Bool

  fun row_addr_glitch(): Bool ? =>
    raw("row_addr_glitch") as Bool

  fun semi_auto_right_margin(): Bool ? =>
    raw("semi_auto_right_margin") as Bool

  fun cpi_changes_res(): Bool ? =>
    raw("cpi_changes_res") as Bool

  fun lpi_changes_res(): Bool ? =>
    raw("lpi_changes_res") as Bool

  fun backspaces_with_bs(): Bool ? =>
    raw("backspaces_with_bs") as Bool

  fun crt_no_scrolling(): Bool ? =>
    raw("crt_no_scrolling") as Bool

  fun no_correctly_working_cr(): Bool ? =>
    raw("no_correctly_working_cr") as Bool

  fun gnu_has_meta_key(): Bool ? =>
    raw("gnu_has_meta_key") as Bool

  fun linefeed_is_newline(): Bool ? =>
    raw("linefeed_is_newline") as Bool

  fun has_hardware_tabs(): Bool ? =>
    raw("has_hardware_tabs") as Bool

  fun return_does_clr_eol(): Bool ? =>
    raw("return_does_clr_eol") as Bool


  // Numerics

  fun columns(): U16 ? =>
    raw("columns") as U16

  fun init_tabs(): U16 ? =>
    raw("init_tabs") as U16

  fun lines(): U16 ? =>
    raw("lines") as U16

  fun lines_of_memory(): U16 ? =>
    raw("lines_of_memory") as U16

  fun magic_cookie_glitch(): U16 ? =>
    raw("magic_cookie_glitch") as U16

  fun padding_baud_rate(): U16 ? =>
    raw("padding_baud_rate") as U16

  fun virtual_terminal(): U16 ? =>
    raw("virtual_terminal") as U16

  fun width_status_line(): U16 ? =>
    raw("width_status_line") as U16

  fun num_labels(): U16 ? =>
    raw("num_labels") as U16

  fun label_height(): U16 ? =>
    raw("label_height") as U16

  fun label_width(): U16 ? =>
    raw("label_width") as U16

  fun max_attributes(): U16 ? =>
    raw("max_attributes") as U16

  fun maximum_windows(): U16 ? =>
    raw("maximum_windows") as U16

  fun max_colors(): U16 ? =>
    raw("max_colors") as U16

  fun max_pairs(): U16 ? =>
    raw("max_pairs") as U16

  fun no_color_video(): U16 ? =>
    raw("no_color_video") as U16

  fun buffer_capacity(): U16 ? =>
    raw("buffer_capacity") as U16

  fun dot_vert_spacing(): U16 ? =>
    raw("dot_vert_spacing") as U16

  fun dot_horz_spacing(): U16 ? =>
    raw("dot_horz_spacing") as U16

  fun max_micro_address(): U16 ? =>
    raw("max_micro_address") as U16

  fun max_micro_jump(): U16 ? =>
    raw("max_micro_jump") as U16

  fun micro_col_size(): U16 ? =>
    raw("micro_col_size") as U16

  fun micro_line_size(): U16 ? =>
    raw("micro_line_size") as U16

  fun number_of_pins(): U16 ? =>
    raw("number_of_pins") as U16

  fun output_res_char(): U16 ? =>
    raw("output_res_char") as U16

  fun output_res_line(): U16 ? =>
    raw("output_res_line") as U16

  fun output_res_horz_inch(): U16 ? =>
    raw("output_res_horz_inch") as U16

  fun output_res_vert_inch(): U16 ? =>
    raw("output_res_vert_inch") as U16

  fun print_rate(): U16 ? =>
    raw("print_rate") as U16

  fun wide_char_size(): U16 ? =>
    raw("wide_char_size") as U16

  fun buttons(): U16 ? =>
    raw("buttons") as U16

  fun bit_image_entwining(): U16 ? =>
    raw("bit_image_entwining") as U16

  fun bit_image_type(): U16 ? =>
    raw("bit_image_type") as U16

  fun magic_cookie_glitch_ul(): U16 ? =>
    raw("magic_cookie_glitch_ul") as U16

  fun carriage_return_delay(): U16 ? =>
    raw("carriage_return_delay") as U16

  fun new_line_delay(): U16 ? =>
    raw("new_line_delay") as U16

  fun backspace_delay(): U16 ? =>
    raw("backspace_delay") as U16

  fun horizontal_tab_delay(): U16 ? =>
    raw("horizontal_tab_delay") as U16

  fun number_of_function_keys(): U16 ? =>
    raw("number_of_function_keys") as U16

  // Strings

  fun back_tab(): String ? =>
    raw("back_tab") as String

  fun bell(): String ? =>
    raw("bell") as String

  fun carriage_return(): String ? =>
    raw("carriage_return") as String

  fun change_scroll_region(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(raw("change_scroll_region") as String, params)

  fun clear_all_tabs(): String ? =>
    raw("clear_all_tabs") as String

  fun clear_screen(): String ? =>
    raw("clear_screen") as String

  fun clr_eol(): String ? =>
    raw("clr_eol") as String

  fun clr_eos(): String ? =>
    raw("clr_eos") as String

  fun column_address(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("column_address") as String, params)

  fun command_character(): String ? =>
    raw("command_character") as String

  fun cursor_address(row: U64, column: U64): String ? =>
    let params = recover val [as StackObject: row, column] end
    ParseString(raw("cursor_address") as String, params)

  fun cursor_down(): String ? =>
    raw("cursor_down") as String

  fun cursor_home(): String ? =>
    raw("cursor_home") as String

  fun cursor_invisible(): String ? =>
    raw("cursor_invisible") as String

  fun cursor_left(): String ? =>
    raw("cursor_left") as String

  fun cursor_mem_address(row: U64, column: U64): String ? =>
    let params = recover val [as StackObject: row, column] end
    ParseString(raw("cursor_mem_address") as String, params)

  fun cursor_normal(): String ? =>
    raw("cursor_normal") as String

  fun cursor_right(): String ? =>
    raw("cursor_right") as String

  fun cursor_to_ll(): String ? =>
    raw("cursor_to_ll") as String

  fun cursor_up(): String ? =>
    raw("cursor_up") as String

  fun cursor_visible(): String ? =>
    raw("cursor_visible") as String

  fun delete_character(): String ? =>
    raw("delete_character") as String

  fun delete_line(): String ? =>
    raw("delete_line") as String

  fun dis_status_line(): String ? =>
    raw("dis_status_line") as String

  fun down_half_line(): String ? =>
    raw("down_half_line") as String

  fun enter_alt_charset_mode(): String ? =>
    raw("enter_alt_charset_mode") as String

  fun enter_blink_mode(): String ? =>
    raw("enter_blink_mode") as String

  fun enter_bold_mode(): String ? =>
    raw("enter_bold_mode") as String

  fun enter_ca_mode(): String ? =>
    raw("enter_ca_mode") as String

  fun enter_delete_mode(): String ? =>
    raw("enter_delete_mode") as String

  fun enter_dim_mode(): String ? =>
    raw("enter_dim_mode") as String

  fun enter_insert_mode(): String ? =>
    raw("enter_insert_mode") as String

  fun enter_secure_mode(): String ? =>
    raw("enter_secure_mode") as String

  fun enter_protected_mode(): String ? =>
    raw("enter_protected_mode") as String

  fun enter_reverse_mode(): String ? =>
    raw("enter_reverse_mode") as String

  fun enter_standout_mode(): String ? =>
    raw("enter_standout_mode") as String

  fun enter_underline_mode(): String ? =>
    raw("enter_underline_mode") as String

  fun erase_chars(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("erase_chars") as String, params)

  fun exit_alt_charset_mode(): String ? =>
    raw("exit_alt_charset_mode") as String

  fun exit_attribute_mode(): String ? =>
    raw("exit_attribute_mode") as String

  fun exit_ca_mode(): String ? =>
    raw("exit_ca_mode") as String

  fun exit_delete_mode(): String ? =>
    raw("exit_delete_mode") as String

  fun exit_insert_mode(): String ? =>
    raw("exit_insert_mode") as String

  fun exit_standout_mode(): String ? =>
    raw("exit_standout_mode") as String

  fun exit_underline_mode(): String ? =>
    raw("exit_underline_mode") as String

  fun flash_screen(): String ? =>
    raw("flash_screen") as String

  fun form_feed(): String ? =>
    raw("form_feed") as String

  fun from_status_line(): String ? =>
    raw("from_status_line") as String

  fun init_1string(): String ? =>
    raw("init_1string") as String

  fun init_2string(): String ? =>
    raw("init_2string") as String

  fun init_3string(): String ? =>
    raw("init_3string") as String

  fun init_file(): String ? =>
    raw("init_file") as String

  fun insert_character(): String ? =>
    raw("insert_character") as String

  fun insert_line(): String ? =>
    raw("insert_line") as String

  fun insert_padding(): String ? =>
    raw("insert_padding") as String

  fun key_backspace(): String ? =>
    raw("key_backspace") as String

  fun key_catab(): String ? =>
    raw("key_catab") as String

  fun key_clear(): String ? =>
    raw("key_clear") as String

  fun key_ctab(): String ? =>
    raw("key_ctab") as String

  fun key_dc(): String ? =>
    raw("key_dc") as String

  fun key_dl(): String ? =>
    raw("key_dl") as String

  fun key_down(): String ? =>
    raw("key_down") as String

  fun key_eic(): String ? =>
    raw("key_eic") as String

  fun key_eol(): String ? =>
    raw("key_eol") as String

  fun key_eos(): String ? =>
    raw("key_eos") as String

  fun key_f0(): String ? =>
    raw("key_f0") as String

  fun key_f1(): String ? =>
    raw("key_f1") as String

  fun key_f10(): String ? =>
    raw("key_f10") as String

  fun key_f2(): String ? =>
    raw("key_f2") as String

  fun key_f3(): String ? =>
    raw("key_f3") as String

  fun key_f4(): String ? =>
    raw("key_f4") as String

  fun key_f5(): String ? =>
    raw("key_f5") as String

  fun key_f6(): String ? =>
    raw("key_f6") as String

  fun key_f7(): String ? =>
    raw("key_f7") as String

  fun key_f8(): String ? =>
    raw("key_f8") as String

  fun key_f9(): String ? =>
    raw("key_f9") as String

  fun key_home(): String ? =>
    raw("key_home") as String

  fun key_ic(): String ? =>
    raw("key_ic") as String

  fun key_il(): String ? =>
    raw("key_il") as String

  fun key_left(): String ? =>
    raw("key_left") as String

  fun key_ll(): String ? =>
    raw("key_ll") as String

  fun key_npage(): String ? =>
    raw("key_npage") as String

  fun key_ppage(): String ? =>
    raw("key_ppage") as String

  fun key_right(): String ? =>
    raw("key_right") as String

  fun key_sf(): String ? =>
    raw("key_sf") as String

  fun key_sr(): String ? =>
    raw("key_sr") as String

  fun key_stab(): String ? =>
    raw("key_stab") as String

  fun key_up(): String ? =>
    raw("key_up") as String

  fun keypad_local(): String ? =>
    raw("keypad_local") as String

  fun keypad_xmit(): String ? =>
    raw("keypad_xmit") as String

  fun lab_f0(): String ? =>
    raw("lab_f0") as String

  fun lab_f1(): String ? =>
    raw("lab_f1") as String

  fun lab_f10(): String ? =>
    raw("lab_f10") as String

  fun lab_f2(): String ? =>
    raw("lab_f2") as String

  fun lab_f3(): String ? =>
    raw("lab_f3") as String

  fun lab_f4(): String ? =>
    raw("lab_f4") as String

  fun lab_f5(): String ? =>
    raw("lab_f5") as String

  fun lab_f6(): String ? =>
    raw("lab_f6") as String

  fun lab_f7(): String ? =>
    raw("lab_f7") as String

  fun lab_f8(): String ? =>
    raw("lab_f8") as String

  fun lab_f9(): String ? =>
    raw("lab_f9") as String

  fun meta_off(): String ? =>
    raw("meta_off") as String

  fun meta_on(): String ? =>
    raw("meta_on") as String

  fun newline(): String ? =>
    raw("newline") as String

  fun pad_char(): String ? =>
    raw("pad_char") as String

  fun parm_dch(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("parm_dch") as String, params)

  fun parm_delete_line(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("parm_delete_line") as String, params)

  fun parm_down_cursor(): String ? =>
    raw("parm_down_cursor") as String

  fun parm_ich(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("parm_ich") as String, params)

  fun parm_index(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("parm_index") as String, params)

  fun parm_insert_line(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("parm_insert_line") as String, params)

  fun parm_left_cursor(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("parm_left_cursor") as String, params)

  fun parm_right_cursor(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("parm_right_cursor") as String, params)

  fun parm_rindex(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("parm_rindex") as String, params)

  fun parm_up_cursor(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("parm_up_cursor") as String, params)

  fun pkey_key(key: String, str: String): String ? =>
    // XXX is the function key specified as a string or an int?
    let params = recover val [as StackObject: key, str] end
    ParseString(raw("pkey_key") as String, params)

  fun pkey_local(i: String, j: String): String ? =>
    // XXX is the function key specified as a string or an int?
    let params = recover val [as StackObject: i, j] end
    ParseString(raw("pkey_local") as String, params)

  fun pkey_xmit(i: String, j: String): String ? =>
    // XXX is the function key specified as a string or an int?
    let params = recover val [as StackObject: i, j] end
    ParseString(raw("pkey_xmit") as String, params)

  fun print_screen(): String ? =>
    raw("print_screen") as String

  fun prtr_off(): String ? =>
    raw("prtr_off") as String

  fun prtr_on(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("prtr_on") as String, params)

  fun repeat_char(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(raw("repeat_char") as String, params)

  fun reset_1string(): String ? =>
    raw("reset_1string") as String

  fun reset_2string(): String ? =>
    raw("reset_2string") as String

  fun reset_3string(): String ? =>
    raw("reset_3string") as String

  fun reset_file(): String ? =>
    raw("reset_file") as String

  fun restore_cursor(): String ? =>
    raw("restore_cursor") as String

  fun row_address(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("row_address") as String, params)

  fun save_cursor(): String ? =>
    raw("save_cursor") as String

  fun scroll_forward(): String ? =>
    raw("scroll_forward") as String

  fun scroll_reverse(): String ? =>
    raw("scroll_reverse") as String

  fun set_attributes(i: U64, j: U64, k: U64, l: U64, m: U64, n: U64, o: U64,
                     p: U64, q: U64): String ? =>
    let params = recover val [as StackObject: i, j, k, l, m, n, o, p, q] end
    ParseString(raw("set_attributes") as String, params)

  fun set_tab(): String ? =>
    raw("set_tab") as String

  fun set_window(i: U64, j: U64, k: U64, l: U64): String ? =>
    let params = recover val [as StackObject: i, j, k, l] end
    ParseString(raw("set_window") as String, params)

  fun tab(): String ? =>
    raw("tab") as String

  fun to_status_line(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("to_status_line") as String, params)

  fun underline_char(): String ? =>
    raw("underline_char") as String

  fun up_half_line(): String ? =>
    raw("up_half_line") as String

  fun init_prog(): String ? =>
    raw("init_prog") as String

  fun key_a1(): String ? =>
    raw("key_a1") as String

  fun key_a3(): String ? =>
    raw("key_a3") as String

  fun key_b2(): String ? =>
    raw("key_b2") as String

  fun key_c1(): String ? =>
    raw("key_c1") as String

  fun key_c3(): String ? =>
    raw("key_c3") as String

  fun prtr_non(): String ? =>
    raw("prtr_non") as String

  fun char_padding(): String ? =>
    raw("char_padding") as String

  fun acs_chars(): String ? =>
    raw("acs_chars") as String

  fun plab_norm(i: U64, j: String): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(raw("plab_norm") as String, params)

  fun key_btab(): String ? =>
    raw("key_btab") as String

  fun enter_xon_mode(): String ? =>
    raw("enter_xon_mode") as String

  fun exit_xon_mode(): String ? =>
    raw("exit_xon_mode") as String

  fun enter_am_mode(): String ? =>
    raw("enter_am_mode") as String

  fun exit_am_mode(): String ? =>
    raw("exit_am_mode") as String

  fun xon_character(): String ? =>
    raw("xon_character") as String

  fun xoff_character(): String ? =>
    raw("xoff_character") as String

  fun ena_acs(): String ? =>
    raw("ena_acs") as String

  fun label_on(): String ? =>
    raw("label_on") as String

  fun label_off(): String ? =>
    raw("label_off") as String

  fun key_beg(): String ? =>
    raw("key_beg") as String

  fun key_cancel(): String ? =>
    raw("key_cancel") as String

  fun key_close(): String ? =>
    raw("key_close") as String

  fun key_command(): String ? =>
    raw("key_command") as String

  fun key_copy(): String ? =>
    raw("key_copy") as String

  fun key_create(): String ? =>
    raw("key_create") as String

  fun key_end(): String ? =>
    raw("key_end") as String

  fun key_enter(): String ? =>
    raw("key_enter") as String

  fun key_exit(): String ? =>
    raw("key_exit") as String

  fun key_find(): String ? =>
    raw("key_find") as String

  fun key_help(): String ? =>
    raw("key_help") as String

  fun key_mark(): String ? =>
    raw("key_mark") as String

  fun key_message(): String ? =>
    raw("key_message") as String

  fun key_move(): String ? =>
    raw("key_move") as String

  fun key_next(): String ? =>
    raw("key_next") as String

  fun key_open(): String ? =>
    raw("key_open") as String

  fun key_options(): String ? =>
    raw("key_options") as String

  fun key_previous(): String ? =>
    raw("key_previous") as String

  fun key_print(): String ? =>
    raw("key_print") as String

  fun key_redo(): String ? =>
    raw("key_redo") as String

  fun key_reference(): String ? =>
    raw("key_reference") as String

  fun key_refresh(): String ? =>
    raw("key_refresh") as String

  fun key_replace(): String ? =>
    raw("key_replace") as String

  fun key_restart(): String ? =>
    raw("key_restart") as String

  fun key_resume(): String ? =>
    raw("key_resume") as String

  fun key_save(): String ? =>
    raw("key_save") as String

  fun key_suspend(): String ? =>
    raw("key_suspend") as String

  fun key_undo(): String ? =>
    raw("key_undo") as String

  fun key_sbeg(): String ? =>
    raw("key_sbeg") as String

  fun key_scancel(): String ? =>
    raw("key_scancel") as String

  fun key_scommand(): String ? =>
    raw("key_scommand") as String

  fun key_scopy(): String ? =>
    raw("key_scopy") as String

  fun key_screate(): String ? =>
    raw("key_screate") as String

  fun key_sdc(): String ? =>
    raw("key_sdc") as String

  fun key_sdl(): String ? =>
    raw("key_sdl") as String

  fun key_select(): String ? =>
    raw("key_select") as String

  fun key_send(): String ? =>
    raw("key_send") as String

  fun key_seol(): String ? =>
    raw("key_seol") as String

  fun key_sexit(): String ? =>
    raw("key_sexit") as String

  fun key_sfind(): String ? =>
    raw("key_sfind") as String

  fun key_shelp(): String ? =>
    raw("key_shelp") as String

  fun key_shome(): String ? =>
    raw("key_shome") as String

  fun key_sic(): String ? =>
    raw("key_sic") as String

  fun key_sleft(): String ? =>
    raw("key_sleft") as String

  fun key_smessage(): String ? =>
    raw("key_smessage") as String

  fun key_smove(): String ? =>
    raw("key_smove") as String

  fun key_snext(): String ? =>
    raw("key_snext") as String

  fun key_soptions(): String ? =>
    raw("key_soptions") as String

  fun key_sprevious(): String ? =>
    raw("key_sprevious") as String

  fun key_sprint(): String ? =>
    raw("key_sprint") as String

  fun key_sredo(): String ? =>
    raw("key_sredo") as String

  fun key_sreplace(): String ? =>
    raw("key_sreplace") as String

  fun key_sright(): String ? =>
    raw("key_sright") as String

  fun key_srsume(): String ? =>
    raw("key_srsume") as String

  fun key_ssave(): String ? =>
    raw("key_ssave") as String

  fun key_ssuspend(): String ? =>
    raw("key_ssuspend") as String

  fun key_sundo(): String ? =>
    raw("key_sundo") as String

  fun req_for_input(): String ? =>
    raw("req_for_input") as String

  fun key_f11(): String ? =>
    raw("key_f11") as String

  fun key_f12(): String ? =>
    raw("key_f12") as String

  fun key_f13(): String ? =>
    raw("key_f13") as String

  fun key_f14(): String ? =>
    raw("key_f14") as String

  fun key_f15(): String ? =>
    raw("key_f15") as String

  fun key_f16(): String ? =>
    raw("key_f16") as String

  fun key_f17(): String ? =>
    raw("key_f17") as String

  fun key_f18(): String ? =>
    raw("key_f18") as String

  fun key_f19(): String ? =>
    raw("key_f19") as String

  fun key_f20(): String ? =>
    raw("key_f20") as String

  fun key_f21(): String ? =>
    raw("key_f21") as String

  fun key_f22(): String ? =>
    raw("key_f22") as String

  fun key_f23(): String ? =>
    raw("key_f23") as String

  fun key_f24(): String ? =>
    raw("key_f24") as String

  fun key_f25(): String ? =>
    raw("key_f25") as String

  fun key_f26(): String ? =>
    raw("key_f26") as String

  fun key_f27(): String ? =>
    raw("key_f27") as String

  fun key_f28(): String ? =>
    raw("key_f28") as String

  fun key_f29(): String ? =>
    raw("key_f29") as String

  fun key_f30(): String ? =>
    raw("key_f30") as String

  fun key_f31(): String ? =>
    raw("key_f31") as String

  fun key_f32(): String ? =>
    raw("key_f32") as String

  fun key_f33(): String ? =>
    raw("key_f33") as String

  fun key_f34(): String ? =>
    raw("key_f34") as String

  fun key_f35(): String ? =>
    raw("key_f35") as String

  fun key_f36(): String ? =>
    raw("key_f36") as String

  fun key_f37(): String ? =>
    raw("key_f37") as String

  fun key_f38(): String ? =>
    raw("key_f38") as String

  fun key_f39(): String ? =>
    raw("key_f39") as String

  fun key_f40(): String ? =>
    raw("key_f40") as String

  fun key_f41(): String ? =>
    raw("key_f41") as String

  fun key_f42(): String ? =>
    raw("key_f42") as String

  fun key_f43(): String ? =>
    raw("key_f43") as String

  fun key_f44(): String ? =>
    raw("key_f44") as String

  fun key_f45(): String ? =>
    raw("key_f45") as String

  fun key_f46(): String ? =>
    raw("key_f46") as String

  fun key_f47(): String ? =>
    raw("key_f47") as String

  fun key_f48(): String ? =>
    raw("key_f48") as String

  fun key_f49(): String ? =>
    raw("key_f49") as String

  fun key_f50(): String ? =>
    raw("key_f50") as String

  fun key_f51(): String ? =>
    raw("key_f51") as String

  fun key_f52(): String ? =>
    raw("key_f52") as String

  fun key_f53(): String ? =>
    raw("key_f53") as String

  fun key_f54(): String ? =>
    raw("key_f54") as String

  fun key_f55(): String ? =>
    raw("key_f55") as String

  fun key_f56(): String ? =>
    raw("key_f56") as String

  fun key_f57(): String ? =>
    raw("key_f57") as String

  fun key_f58(): String ? =>
    raw("key_f58") as String

  fun key_f59(): String ? =>
    raw("key_f59") as String

  fun key_f60(): String ? =>
    raw("key_f60") as String

  fun key_f61(): String ? =>
    raw("key_f61") as String

  fun key_f62(): String ? =>
    raw("key_f62") as String

  fun key_f63(): String ? =>
    raw("key_f63") as String

  fun clr_bol(): String ? =>
    raw("clr_bol") as String

  fun clear_margins(): String ? =>
    raw("clear_margins") as String

  fun set_left_margin(): String ? =>
    raw("set_left_margin") as String

  fun set_right_margin(): String ? =>
    raw("set_right_margin") as String

  fun label_format(): String ? =>
    raw("label_format") as String

  fun set_clock(i: U64, j: U64, k: U64): String ? =>
    let params = recover val [as StackObject: i, j, k] end
    ParseString(raw("set_clock") as String, params)

  fun display_clock(): String ? =>
    raw("display_clock") as String

  fun remove_clock(): String ? =>
    raw("remove_clock") as String

  fun create_window(i: U64, j: U64, k: U64, l: U64, h: U64): String ? =>
    let params = recover val [as StackObject: i, j, k, l, h] end
    ParseString(raw("create_window") as String, params)

  fun goto_window(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("goto_window") as String, params)

  fun hangup(): String ? =>
    raw("hangup") as String

  fun dial_phone(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("dial_phone") as String, params)

  fun quick_dial(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("quick_dial") as String, params)

  fun tone(): String ? =>
    raw("tone") as String

  fun pulse(): String ? =>
    raw("pulse") as String

  fun flash_hook(): String ? =>
    raw("flash_hook") as String

  fun fixed_pause(): String ? =>
    raw("fixed_pause") as String

  fun wait_tone(): String ? =>
    raw("wait_tone") as String

  fun user0(): String ? =>
    raw("user0") as String

  fun user1(): String ? =>
    raw("user1") as String

  fun user2(): String ? =>
    raw("user2") as String

  fun user3(): String ? =>
    raw("user3") as String

  fun user4(): String ? =>
    raw("user4") as String

  fun user5(): String ? =>
    raw("user5") as String

  fun user6(): String ? =>
    raw("user6") as String

  fun user7(): String ? =>
    raw("user7") as String

  fun user8(): String ? =>
    raw("user8") as String

  fun user9(): String ? =>
    raw("user9") as String

  fun orig_pair(): String ? =>
    raw("orig_pair") as String

  fun orig_colors(): String ? =>
    raw("orig_colors") as String

  fun initialize_color(i: U64, j: U64, k: U64, l: U64): String ? =>
    let params = recover val [as StackObject: i, j, k, l] end
    ParseString(raw("initialize_color") as String, params)

  fun initialize_pair(i: U64, j: U64, k: U64, l: U64, m: U64, n: U64, o: U64)
    : String ? =>
    let params = recover val [as StackObject: i, j, k, l, m, n, o] end
    ParseString(raw("initialize_pair") as String, params)

  fun set_color_pair(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_color_pair") as String, params)

  fun set_foreground(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_foreground") as String, params)

  fun set_background(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_background") as String, params)

  fun change_char_pitch(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("change_char_pitch") as String, params)

  fun change_line_pitch(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("change_line_pitch") as String, params)

  fun change_res_horz(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("change_res_horz") as String, params)

  fun change_res_vert(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("change_res_vert") as String, params)

  fun define_char(i: U64, j: U64, k: U64): String ? =>
    let params = recover val [as StackObject: i, j, k] end
    ParseString(raw("define_char") as String, params)

  fun enter_doublewide_mode(): String ? =>
    raw("enter_doublewide_mode") as String

  fun enter_draft_quality(): String ? =>
    raw("enter_draft_quality") as String

  fun enter_italics_mode(): String ? =>
    raw("enter_italics_mode") as String

  fun enter_leftward_mode(): String ? =>
    raw("enter_leftward_mode") as String

  fun enter_micro_mode(): String ? =>
    raw("enter_micro_mode") as String

  fun enter_near_letter_quality(): String ? =>
    raw("enter_near_letter_quality") as String

  fun enter_normal_quality(): String ? =>
    raw("enter_normal_quality") as String

  fun enter_shadow_mode(): String ? =>
    raw("enter_shadow_mode") as String

  fun enter_subscript_mode(): String ? =>
    raw("enter_subscript_mode") as String

  fun enter_superscript_mode(): String ? =>
    raw("enter_superscript_mode") as String

  fun enter_upward_mode(): String ? =>
    raw("enter_upward_mode") as String

  fun exit_doublewide_mode(): String ? =>
    raw("exit_doublewide_mode") as String

  fun exit_italics_mode(): String ? =>
    raw("exit_italics_mode") as String

  fun exit_leftward_mode(): String ? =>
    raw("exit_leftward_mode") as String

  fun exit_micro_mode(): String ? =>
    raw("exit_micro_mode") as String

  fun exit_shadow_mode(): String ? =>
    raw("exit_shadow_mode") as String

  fun exit_subscript_mode(): String ? =>
    raw("exit_subscript_mode") as String

  fun exit_superscript_mode(): String ? =>
    raw("exit_superscript_mode") as String

  fun exit_upward_mode(): String ? =>
    raw("exit_upward_mode") as String

  fun micro_column_address(): String ? =>
    raw("micro_column_address") as String

  fun micro_down(): String ? =>
    raw("micro_down") as String

  fun micro_left(): String ? =>
    raw("micro_left") as String

  fun micro_right(): String ? =>
    raw("micro_right") as String

  fun micro_row_address(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("micro_row_address") as String, params)

  fun micro_up(): String ? =>
    raw("micro_up") as String

  fun order_of_pins(): String ? =>
    raw("order_of_pins") as String

  fun parm_down_micro(): String ? =>
    raw("parm_down_micro") as String

  fun parm_left_micro(): String ? =>
    raw("parm_left_micro") as String

  fun parm_right_micro(): String ? =>
    raw("parm_right_micro") as String

  fun parm_up_micro(): String ? =>
    raw("parm_up_micro") as String

  fun select_char_set(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("select_char_set") as String, params)

  fun set_bottom_margin(): String ? =>
    raw("set_bottom_margin") as String

  fun set_bottom_margin_parm(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(raw("set_bottom_margin_parm") as String, params)

  fun set_left_margin_parm(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_left_margin_parm") as String, params)

  fun set_right_margin_parm(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_right_margin_parm") as String, params)

  fun set_top_margin(): String ? =>
    raw("set_top_margin") as String

  fun set_top_margin_parm(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_top_margin_parm") as String, params)

  fun start_bit_image(): String ? =>
    raw("start_bit_image") as String

  fun start_char_set_def(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(raw("start_char_set_def") as String, params)

  fun stop_bit_image(): String ? =>
    raw("stop_bit_image") as String

  fun stop_char_set_def(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("stop_char_set_def") as String, params)

  fun subscript_characters(): String ? =>
    raw("subscript_characters") as String

  fun superscript_characters(): String ? =>
    raw("superscript_characters") as String

  fun these_cause_cr(): String ? =>
    raw("these_cause_cr") as String

  fun zero_motion(): String ? =>
    raw("zero_motion") as String

  fun char_set_names(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("char_set_names") as String, params)

  fun key_mouse(): String ? =>
    raw("key_mouse") as String

  fun mouse_info(): String ? =>
    raw("mouse_info") as String

  fun req_mouse_pos(): String ? =>
    raw("req_mouse_pos") as String

  fun get_mouse(i: U64): String ? =>
    """
    parameter #1 not documented :/
    """
    let params = recover val [as StackObject: i] end
    ParseString(raw("get_mouse") as String, params)

  fun set_a_foreground(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_a_foreground") as String, params)

  fun set_a_background(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_a_background") as String, params)

  fun pkey_plab(i: U64, j: String, k: String): String ? =>
    let params = recover val [as StackObject: i, j, k] end
    ParseString(raw("pkey_plab") as String, params)

  fun device_type(): String ? =>
    raw("device_type") as String

  fun code_set_init(): String ? =>
    raw("code_set_init") as String

  fun set0_des_seq(): String ? =>
    raw("set0_des_seq") as String

  fun set1_des_seq(): String ? =>
    raw("set1_des_seq") as String

  fun set2_des_seq(): String ? =>
    raw("set2_des_seq") as String

  fun set3_des_seq(): String ? =>
    raw("set3_des_seq") as String

  fun set_lr_margin(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(raw("set_lr_margin") as String, params)

  fun set_tb_margin(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(raw("set_tb_margin") as String, params)

  fun bit_image_repeat(i: U64, j: U64): String ? =>
    let params = recover val [as StackObject: i, j] end
    ParseString(raw("bit_image_repeat") as String, params)

  fun bit_image_newline(): String ? =>
    raw("bit_image_newline") as String

  fun bit_image_carriage_return(): String ? =>
    raw("bit_image_carriage_return") as String

  fun color_names(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("color_names") as String, params)

  fun define_bit_image_region(): String ? =>
    raw("define_bit_image_region") as String

  fun end_bit_image_region(): String ? =>
    raw("end_bit_image_region") as String

  fun set_color_band(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_color_band") as String, params)

  fun set_page_length(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_page_length") as String, params)

  fun display_pc_char(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("display_pc_char") as String, params)

  fun enter_pc_charset_mode(): String ? =>
    raw("enter_pc_charset_mode") as String

  fun exit_pc_charset_mode(): String ? =>
    raw("exit_pc_charset_mode") as String

  fun enter_scancode_mode(): String ? =>
    raw("enter_scancode_mode") as String

  fun exit_scancode_mode(): String ? =>
    raw("exit_scancode_mode") as String

  fun pc_term_options(): String ? =>
    raw("pc_term_options") as String

  fun scancode_escape(): String ? =>
    raw("scancode_escape") as String

  fun alt_scancode_esc(): String ? =>
    raw("alt_scancode_esc") as String

  fun enter_horizontal_hl_mode(): String ? =>
    raw("enter_horizontal_hl_mode") as String

  fun enter_left_hl_mode(): String ? =>
    raw("enter_left_hl_mode") as String

  fun enter_low_hl_mode(): String ? =>
    raw("enter_low_hl_mode") as String

  fun enter_right_hl_mode(): String ? =>
    raw("enter_right_hl_mode") as String

  fun enter_top_hl_mode(): String ? =>
    raw("enter_top_hl_mode") as String

  fun enter_vertical_hl_mode(): String ? =>
    raw("enter_vertical_hl_mode") as String

  fun set_a_attributes(i: U64, j: U64, k: U64, l: U64, m: U64, n: U64)
    : String ? =>
    let params = recover val [as StackObject: i, j, k, l, m, n] end
    ParseString(raw("set_a_attributes") as String, params)

  fun set_pglen_inch(i: U64): String ? =>
    let params = recover val [as StackObject: i] end
    ParseString(raw("set_pglen_inch") as String, params)

  fun termcap_init2(): String ? =>
    raw("termcap_init2") as String

  fun termcap_reset(): String ? =>
    raw("termcap_reset") as String

  fun linefeed_if_not_lf(): String ? =>
    raw("linefeed_if_not_lf") as String

  fun backspace_if_not_bs(): String ? =>
    raw("backspace_if_not_bs") as String

  fun other_non_function_keys(): String ? =>
    raw("other_non_function_keys") as String

  fun arrow_key_map(): String ? =>
    raw("arrow_key_map") as String

  fun acs_ulcorner(): String ? =>
    raw("acs_ulcorner") as String

  fun acs_llcorner(): String ? =>
    raw("acs_llcorner") as String

  fun acs_urcorner(): String ? =>
    raw("acs_urcorner") as String

  fun acs_lrcorner(): String ? =>
    raw("acs_lrcorner") as String

  fun acs_ltee(): String ? =>
    raw("acs_ltee") as String

  fun acs_rtee(): String ? =>
    raw("acs_rtee") as String

  fun acs_btee(): String ? =>
    raw("acs_btee") as String

  fun acs_ttee(): String ? =>
    raw("acs_ttee") as String

  fun acs_hline(): String ? =>
    raw("acs_hline") as String

  fun acs_vline(): String ? =>
    raw("acs_vline") as String

  fun acs_plus(): String ? =>
    raw("acs_plus") as String

  fun memory_lock(): String ? =>
    raw("memory_lock") as String

  fun memory_unlock(): String ? =>
    raw("memory_unlock") as String

  fun box_chars_1(): String ? =>
    raw("box_chars_1") as String
