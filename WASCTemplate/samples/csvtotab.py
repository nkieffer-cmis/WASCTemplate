import csv
import sys
import io
fn = sys.argv[1]
try:
    column_spec = sys.argv[2]
except IndexError:
    column_spec = None

try:
    table_width = sys.argv[3]
except IndexError:
    table_width = "\\textwidth"
f = open(fn)
r = csv.reader(f)
print dir(r)
rows = list(r)

column_spec = column_spec if column_spec else "|".join(["X" for _ in range(len(rows[0]))])
out = io.StringIO();
temp = u"""
\\begin{{tabularx}}{{"""+table_width+"""}}{{{}}}
{}
\\end{{tabularx}}
"""
row_str = []
row_num = 0
for row in rows:
    
    if row_num == 0:
        row_str.append("\\rowcolor{gray}"+"&".join("\\textbf{{"+unicode(x).replace("%", "\\%")+"}}" for x in row)+"\\\\")
        row_str.append("\\hline")
    else:
        row_color = "\\rowcolor{lightgray}" if row_num % 2 == 1 else "\\rowcolor{white}"
        row_str.append(row_color+"&".join(unicode(x).replace("%", "\\%") for x in row)+"\\\\")
    row_num+=1

out.write(temp.format(column_spec,"\n".join(row_str)))
out.seek(0)
print out.read()
