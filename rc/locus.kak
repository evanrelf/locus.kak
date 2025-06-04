# Standard: path/to/file:line[:column][:]
hook global WinDisplay (?<file>.*?):(?<line>\d+)(?::(?<column>\d+))?:? %{
  evaluate-commands %sh{
    file=$kak_hook_param_capture_file
    anchor_line=$kak_hook_param_capture_line
    anchor_column=$kak_hook_param_capture_column
    cursor_line=$anchor_line
    cursor_column=$anchor_column
    echo "delete-buffer"
    echo "edit -existing $file $anchor_line $anchor_column"
    echo "try %{ select -display-column $anchor_line.$anchor_column,$cursor_line.$cursor_column }"
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

# GitHub line range: path/to/file#Lline-Lline
hook global WinDisplay (?<file>.*?)#L(?<anchor_line>\d+)(?:-L(?<cursor_line>\d+))? %{
  evaluate-commands %sh{
    file=$kak_hook_param_capture_file
    anchor_line=$kak_hook_param_capture_anchor_line
    anchor_column=1
    cursor_line=${kak_hook_param_capture_cursor_line:-anchor_line}
    cursor_column=1
    echo "delete-buffer"
    echo "edit -existing $file $anchor_line"
    echo "execute-keys x"
    echo "try %{ select -display-column $anchor_line.$anchor_column,$cursor_line.$cursor_column; execute-keys x }"
  }
}
