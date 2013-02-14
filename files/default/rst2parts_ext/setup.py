# -*- coding: utf-8 -*-

from setuptools import setup, find_packages

setup(
    name = 'rst2parts_ext',
    version = '2012.10.15',
    description = 'RbST rst2parts library extension',
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
    install_requires = [
        'docutils',
        'pygments',
        'Pillow',
    ],
)
