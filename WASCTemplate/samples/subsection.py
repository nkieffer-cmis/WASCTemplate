from mako.template import Template
import sys

fn = sys.argv[1]
subsect = Template(filename="subsection.tmp")
with open(fn) as data:
    parts = data.read().split("<>")
    title = parts[0].strip()
    indicator = parts[1].strip()
    prompt = parts[2].strip()
    findings = unicode(parts[3])
    evidence = "\n".join(["\item " + x for x in parts[4].strip().split("\n")])
    print subsect.render(subsection=title,
                         indicator=indicator,
                         prompt=prompt,
                         findings=findings,
                         evidence=evidence)
exit(0)
