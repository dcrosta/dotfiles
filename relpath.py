import os.path
import sys

relative_to = sys.argv[1]

try:
    for line in sys.stdin:
        print(os.path.relpath(line.strip(), relative_to))
except IOError:
    # broken pipe, usually, just ignore
    pass
