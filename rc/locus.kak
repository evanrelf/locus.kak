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
hook global WinDisplay (?<file>.*?):(?<line>\d+):(?<column>\d+)-\d+:? %{
  evaluate-commands %sh{
    file=$kak_hook_param_capture_file
    line=$kak_hook_param_capture_line
    column=$kak_hook_param_capture_column
    echo "delete-buffer"
    echo "edit -existing $file $line $column"
  }
}

# GHC point range: path/to/file:(line,column)-(line,column)[:]
hook global WinDisplay (?<file>.*?):\((?<line>\d+),(?<column>\d+)\)-\(\d+,\d+\):? %{
  evaluate-commands %sh{
    file=$kak_hook_param_capture_file
    line=$kak_hook_param_capture_line
    column=$kak_hook_param_capture_column
    echo "delete-buffer"
    echo "edit -existing $file $line $column"
  }
}
