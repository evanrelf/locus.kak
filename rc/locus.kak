hook global WinDisplay (?<file>.*?):(?<line>\d+)(?::(?<column>\d+))?:? %{
  evaluate-commands %sh{
    file=$kak_hook_param_capture_file
    line=$kak_hook_param_capture_line
    column=$kak_hook_param_capture_column
    echo "delete-buffer"
    echo "edit -existing $file $line $column"
  }
}
