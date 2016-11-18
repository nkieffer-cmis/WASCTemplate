from pathlib import Path

p = Path("sections")
with open("sections.tex", "w") as f:
    for section in [ x.name for x in p.iterdir() if x.is_dir() and "sect" in x.name]:
        f.write("\import{{sections/{0}/}}{{{0}}}\n".format(section))

