# -*- coding: utf-8 -*-

def setup():
    setup_blockdiag()
    setup_seqdiag()
    setup_actdiag()
    setup_nwdiag()


############# blockdiag ##############
def setup_blockdiag():
    import blockdiag.utils.rst.directives

    blockdiag.utils.rst.directives.setup(
        format='SVG',
        antialias=False,
        fontpath=None,
        outputdir=None,
        nodoctype=True,
        noviewbox=True,
        inline_svg=True,
        ignore_pil=True
    )


############# seqdiag ##############
def setup_seqdiag():
    import seqdiag.utils.rst.directives

    seqdiag.utils.rst.directives.setup(
        format='SVG',
        antialias=False,
        fontpath=None,
        outputdir=None,
        nodoctype=True,
        noviewbox=True,
        inline_svg=True,
        ignore_pil=True
    )


############# actdiag ##############
def setup_actdiag():
    import actdiag.utils.rst.directives

    actdiag.utils.rst.directives.setup(
        format='SVG',
        antialias=False,
        fontpath=None,
        outputdir=None,
        nodoctype=True,
        noviewbox=True,
        inline_svg=True,
        ignore_pil=True
    )


############# nwdiag ##############
def setup_nwdiag():
    import nwdiag.utils.rst.directives

    nwdiag.utils.rst.directives.setup(
        format='SVG',
        antialias=False,
        fontpath=None,
        outputdir=None,
        nodoctype=True,
        noviewbox=True,
        inline_svg=True,
        ignore_pil=True
    )
