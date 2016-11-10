#!/usr/bin/env python
import sys

fn = sys.argv[1]
input_file = open(fn, "r")
output_file = open("content.tex", "w")

with open(fn, "r") as input_file:
    text = input_file.read()

    parts = text.split("\n")
    output = """
\\begin{Parallel}{0.74\\textwidth}{0.24\\textwidth}
"""
    finding = True
    frame = ""
    content = ""
    for part in parts:
        print "-"*70
        print part
        
        if part == "<Findings>":
            output += frame.format(content)
            frame= "\\ParallelLText{{\n{}}}"
            content = ""
            finding = True
        elif part == "<Evidence>":
            output += frame.format(content)
            frame= "\\ParallelRText{{\n \\begin{{itemize}}{}\\end{{itemize}}\n}}\\ParallelPar%\\bigskip\n"
            content = ""
            finding = False
        elif frame != "":
            if finding:
                content += part + "\\\\\n\n"
            else:
                content += "\item{ " + part + "}\n"
            
output += "\end{Parallel}"
print output
output_file.write(output)
output_file.close()
