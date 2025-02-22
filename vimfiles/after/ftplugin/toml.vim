setlocal expandtab shiftwidth=2 softtabstop=2 

function! TomlIndent()
    let prev_line = getline(v:lnum - 1)
    let prev_indent = indent(v:lnum - 1)

    " If the previous line is a [section], indent the next line
    if prev_line =~ '^\s*\[.*\]\s*$'
        return prev_indent +  shiftwidth()
    endif

	return prev_indent
endfunction

setlocal indentexpr=TomlIndent()
setlocal indentkeys+=0],0}
