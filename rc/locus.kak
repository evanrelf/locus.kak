# Standard: path/to/file:line[:column][:]
hook global WinDisplay (?<file>.*?):(?<line>\d+)(?::(?<column>\d+))?:? %{
  evaluate-commands %sh{
    file=$kak_hook_param_capture_file
    line=$kak_hook_param_capture_line
    column=$kak_hook_param_capture_column
    echo "delete-buffer"
    echo "edit -existing $file $line $column"
  }
}

# GHC column range: path/to/file:line:column-column[:]
hook global WinDisplay (?<file>.*?):(?<anchor_line>\d+):(?<anchor_column>\d+)-(?<cursor_column>\d+):? %{
  evaluate-commands %sh{
    file=$kak_hook_param_capture_file
    anchor_line=$kak_hook_param_capture_anchor_line
    anchor_column=$kak_hook_param_capture_anchor_column
    cursor_line=$anchor_line
    cursor_column=$kak_hook_param_capture_cursor_column
    echo "delete-buffer"
    echo "edit -existing $file $anchor_line $anchor_column"
    echo "try %{ select -display-column $anchor_line.$anchor_column,$cursor_line.$cursor_column }"
  }
}

# GHC point range: path/to/file:(line,column)-(line,column)[:]
hook global WinDisplay (?<file>.*?):\((?<anchor_line>\d+),(?<anchor_column>\d+)\)-\((?<cursor_line>\d+),(?<cursor_column>\d+)\):? %{
  evaluate-commands %sh{
    file=$kak_hook_param_capture_file
    anchor_line=$kak_hook_param_capture_anchor_line
    anchor_column=$kak_hook_param_capture_anchor_column
    cursor_line=$kak_hook_param_capture_cursor_column
    cursor_column=$kak_hook_param_capture_cursor_column
    echo "delete-buffer"
    echo "edit -existing $file $anchor_line $anchor_column"
    echo "try %{ select -display-column $anchor_line.$anchor_column,$cursor_line.$cursor_column }"
  }
}
