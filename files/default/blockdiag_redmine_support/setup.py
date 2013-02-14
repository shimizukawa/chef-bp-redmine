# -*- coding: utf-8 -*-

from setuptools import setup, find_packages

setup(
    name = 'blockdiag_redmine_support',
    version = '2012.10.22',
    description = 'SVG stdout stream interface support for blockdiag series',
    long_description = 'this code was copied from BeProud local.',
    author = 'Shimizukawa Takayuki',
    author_email = 'shimizukawa@gmail.com',
    license = 'Apache License Version 2.0',
    classifiers = [
        'Development Status :: 4 - Beta',
        'License :: OSI Approved :: Apache Software License',
    ],
    url = 'https://bitbucket.org/shimizukawa/',
    packages = find_packages(),
    include_package_data=True,
    install_requires = [
        'docutils',
        'Pillow',
        'blockdiag',
        'seqdiag',
        'actdiag',
        'nwdiag',
    ],
)
