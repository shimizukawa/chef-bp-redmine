#!/usr/bin/env python

import sys

from transform import transform
from wiki_writer import WikiWriter
import extra_directives
import blockdiag_redmine_support


def main():
    extra_directives.setup()
    blockdiag_redmine_support.setup()

    try:
        output = transform(writer=WikiWriter(), part='html_body')
        if output:
            sys.stdout.write(output)
    except Exception, e:
        sys.stdout.write('<strong style="color:red">Error Parsing ReSt: %r</strong>' % e)
