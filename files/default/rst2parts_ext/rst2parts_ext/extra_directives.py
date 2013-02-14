# -*- coding: utf-8 -*-
from docutils import nodes
from docutils.parsers.rst import directives
from pygments import highlight
from pygments.formatters import HtmlFormatter
from pygments.lexers import get_lexer_by_name, TextLexer


############### code-block, sourcecode ##############
def pygments_directive(name, arguments, options, content, lineno,
                       content_offset, block_text, state, state_machine):
    try:
        lexer = get_lexer_by_name(arguments[0])
    except (ValueError, IndexError):
        # no lexer found - use the text one instead of an exception
        lexer = TextLexer()
    parsed = highlight(u"\n".join(content), lexer, HtmlFormatter(noclasses=True))
    return [nodes.raw("", parsed, format="html")]


def setup():
    VARIANTS = {}
    pygments_directive.arguments = (0, 1, False)
    pygments_directive.content = 1
    pygments_directive.options = dict([(key, directives.flag) for key in VARIANTS])
    directives.register_directive("sourcecode", pygments_directive)
    directives.register_directive("code-block", pygments_directive)
