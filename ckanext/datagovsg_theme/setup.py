# -*- coding: utf-8 -*-
from setuptools import setup, find_packages

version = '1.0.0'

setup(
    name='ckanext-datagovsg-theme',
    version=version,
    description="A modern CKAN theme inspired by Singapore's data.gov.sg portal",
    long_description="""
    Data.gov.sg Theme for CKAN
    
    A clean, modern theme with purple accent colors and enhanced user experience.
    Features responsive design, smooth animations, and improved navigation.
    """,
    classifiers=[
        'Development Status :: 4 - Beta',
        'License :: OSI Approved :: GNU Affero General Public License v3 or later (AGPLv3+)',
        'Programming Language :: Python :: 3',
    ],
    keywords='CKAN theme data.gov.sg singapore',
    author='Your Name',
    author_email='your.email@example.com',
    url='https://github.com/yourusername/ckanext-datagovsg-theme',
    license='AGPL',
    packages=find_packages(exclude=['ez_setup', 'examples', 'tests']),
    namespace_packages=['ckanext'],
    include_package_data=True,
    zip_safe=False,
    install_requires=[
        # Add your dependencies here
    ],
    entry_points='''
        [ckan.plugins]
        datagovsg_theme=ckanext.datagovsg_theme.plugin:DataGovSGThemePlugin
    ''',
)

