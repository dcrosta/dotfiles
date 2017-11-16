import os.path
import sys

relative_to = sys.argv[1]

for line in sys.stdin:
    print(os.path.relpath(line.strip(), relative_to))
