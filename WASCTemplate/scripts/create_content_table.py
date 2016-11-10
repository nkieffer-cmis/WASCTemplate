#!/usr/bin/env python
import sys

longtable = """
%\\renewcommand*{{\\arraystretch}}{{1.8}}
\\begin{{longtable}}{{ f p{{ 1.5in }} }}
\\textbf{{Findings}}       & \\textbf{{Evidence}}  \\\\% [1em]
{}
\\end{{longtable}}
"""

row = """
{} 
& {} \\\\  %end of row
"""
rows = ""

fn = sys.argv[1]

content_file = open(fn, "r");
content_text = content_file.read()

content = content_text.split("\n\n")

print len(content)

p = 0
while p < len(content):
    findings = content[p]+"\n"
    evidence = content[p+1].split("\n")
#\\vspace{{-\\baselineskip}}
    ev_list = """%\\begin{{itemize}}[noitemsep,leftmargin=*,topsep=0pt,partopsep=0pt]
{} 
%\\end{{itemize}}
"""
    items = ""
    item_tmp = "\\nextitem {}\n"
    for e in evidence:
        if e == "": continue
        items += item_tmp.format(e)
    rows += row.format(findings, ev_list.format(items))
    p += 2

content_tex = open("content.tex", "w")    
content_tex.write(longtable.format(rows))
content_tex.close()
