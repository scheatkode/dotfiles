return {
   prettier = {
                noSemi = true,
               useTabs = false,
              tabWidth = 3,
            printWidth = 78,
           singleQuote = true,
         trailingComma = 'none',
        bracketSpacing = true,
      configPrecedence = 'prefer-file',
   },

   uncrustify = {
                           newlines = 'LF',		-- AUTO (default), CRLF, CR, or LF

                   indent_with_tabs = 0,		-- 1=indent to level only, 2=indent with tabs
                     input_tab_size = 8,		-- original tab size
                    output_tab_size = 3,		-- new tab size
                     indent_columns = 'output_tab_size',
                    -- indent_label = 0,		-- pos: absolute col, neg: relative column
                indent_align_string = false,		-- align broken strings
                       indent_brace = 0,
                       indent_class = true,

                   nl_start_of_file = 'remove',
            -- nl_start_of_file_min = 0,
                     nl_end_of_file = 'force',
                 nl_end_of_file_min = 1,
                             nl_max = 4,
            nl_before_block_comment = 2,
                 nl_after_func_body = 2,
          nl_after_func_proto_group = 2,

                    nl_assign_brace = 'add',		-- "= {" vs "= \n {"
                      nl_enum_brace = 'add',		-- "enum {" vs "enum \n {"
                     nl_union_brace = 'add',		-- "union {" vs "union \n {"
                    nl_struct_brace = 'add',		-- "struct {" vs "struct \n {"
                        nl_do_brace = 'add',		-- "do {" vs "do \n {"
                        nl_if_brace = 'add',		-- "if () {" vs "if () \n {"
                       nl_for_brace = 'add',		-- "for () {" vs "for () \n {"
                      nl_else_brace = 'add',		-- "else {" vs "else \n {"
                     nl_while_brace = 'add',		-- "while () {" vs "while () \n {"
                    nl_switch_brace = 'add',		-- "switch () {" vs "switch () \n {"
                nl_func_var_def_blk = 1,
                     nl_before_case = 1,
                     nl_fcall_brace = 'add',		-- "foo() {" vs "foo()\n{"
                      nl_fdef_brace = 'add',		-- "int foo() {" vs "int foo()\n{"
                    nl_after_return = true,
                     nl_brace_while = 'remove',
                      nl_brace_else = 'add',
                   nl_squeeze_ifdef = true,

                           pos_bool = 'trail',		-- BOOL ops on trailing end

      eat_blanks_before_close_brace = true,
        eat_blanks_after_open_brace = true,


                mod_paren_on_return = 'add',		-- "return 1;" vs "return (1);"
                  mod_full_brace_if = 'add',		-- "if (a) a--;" vs "if (a) { a--; }"
                 mod_full_brace_for = 'add',		-- "for () a--;" vs "for () { a--; }"
                  mod_full_brace_do = 'add',		-- "do a--; while ();" vs "do { a--; } while ();"
               mod_full_brace_while = 'add',		-- "while (a) a--;" vs "while (a) { a--; }"

                    sp_before_byref = 'remove',
                     sp_before_semi = 'remove',
                     sp_paren_paren = 'remove',	-- space between (( and ))
                    sp_return_paren = 'remove',	-- "return (1);" vs "return(1);"
                    sp_sizeof_paren = 'remove',	-- "sizeof (int)" vs "sizeof(int)"
                   sp_before_sparen = 'force',		-- "if (" vs "if("
                    sp_after_sparen = 'force',		-- "if () {" vs "if (){"
                      sp_after_cast = 'remove',	-- "(int) a" vs "(int)a"
                   sp_inside_braces = 'force',		-- "{ 1 }" vs "{1}"
            sp_inside_braces_struct = 'force',		-- "{ 1 }" vs "{1}"
              sp_inside_braces_enum = 'force',		-- "{ 1 }" vs "{1}"
                    sp_inside_paren = 'remove',
                   sp_inside_fparen = 'remove',
                   sp_inside_sparen = 'remove',
                   sp_inside_square = 'remove',
                     --sp_type_func = 'ignore',
                          sp_assign = 'force',
                           sp_arith = 'force',
                            sp_bool = 'force',
                         sp_compare = 'force',
                     sp_after_comma = 'force',
                  sp_func_def_paren = 'remove',	-- "int foo (){" vs "int foo(){"
                 sp_func_call_paren = 'remove',	-- "foo (" vs "foo("
                sp_func_proto_paren = 'remove',	-- "int foo ();" vs "int foo();"
                sp_func_class_paren = 'remove',
                    sp_before_angle = 'remove',
                     sp_after_angle = 'remove',
                     sp_angle_paren = 'remove',
               sp_angle_paren_empty = 'remove',
                      sp_angle_word = 'ignore',
                    sp_inside_angle = 'remove',
              sp_inside_angle_empty = 'remove',
                    sp_sparen_brace = 'add',
                    sp_fparen_brace = 'add',
                  sp_after_ptr_star = 'remove',
                 sp_before_ptr_star = 'force',
                sp_between_ptr_star = 'remove',

                    align_with_tabs = false,		-- use tabs to align
                   align_on_tabstop = false,		-- align on tabstops
                align_enum_equ_span = 4,
                      align_nl_cont = true,
                 align_var_def_span = 1,
               align_var_def_thresh = 12,
               align_var_def_inline = true,
                align_var_def_colon = true,
                  align_assign_span = 1,
                align_assign_thresh = 12,
             align_struct_init_span = 3,
              align_var_struct_span = 99,
               align_right_cmt_span = 3,
               align_pp_define_span = 3,
                align_pp_define_gap = 4,
                 align_number_right = true,
                 align_typedef_span = 5,
                  align_typedef_gap = 3,
           align_var_def_star_style = 0,

                      cmt_star_cont = true,
   },
}
