#!/bin/bash

# Input params:
# 1 - repo name
# 2 - branch name
# 3 - directory with tests (or useful content in general)
# 4 - output file name
git archive --output ${4} --format tar.gz --remote ssh://git@<my_domain>/<my_project>/${1}.git ${2} ${3}
tar zxf ${4}
rm ${4}