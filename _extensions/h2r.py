# -*- coding: utf-8 -*-
"""
    sphinx.ext.h2r
    ~~~~~~~~~~~~~~
    (markdown)headers-2-reStructuredText

    For when you need indicies and you have none, this extension
    generates some based on H2 and H3 markdown headers

    h2r_toc_from_doc is a path to a markdown page of headings and list
    items, which will be converted to rst, have toc entries added per
    section, and overwrite the contents of the master doc

    h2r_script_object_from_header is a regular expression that matches
    a script object in match group 1, from the H2 header

    h2r_script_object_force_global is a dictionary which maps script
    objects matched in H2 headers against a list of H3 headers which
    should not be be treated as functions or properties
"""

import io
import sphinx
import re
from m2r import parse_from_file
from sphinx.util import logging

logger = logging.getLogger(__name__)

## track subtitles to identify common attributes on script objects
seen_script_attr = []
## e.g. '.ID', '.Animate', etc.
shared_script_attr = []
## docname = (source offset, title, subtitle, is a script object)
changes = {}

def get_script_object(pattern, title):
    match = re.search(pattern, title)

    if match is not None:
        return match.group(1)

    return None

def map_page(app, env, docnames):
    title = None
    script_object = None

    for docname in env.found_docs:
        if docname == app.config.master_doc:
            continue

        with io.open(env.doc2path(docname), encoding='utf-8') as f:
            changes[docname] = []
            offset = 0

            for line in f:
                if line.startswith('## '):
                    title = line[3:].strip()
                    script_object = get_script_object(app.config.h2r_script_object_from_header, title)
                elif line.startswith('### '):
                    subtitle = line[4:].strip()

                    if isinstance(script_object, str):
                        logger.info('Found script object: %s.%s' % (script_object, subtitle))
                        changes[docname].append((offset, script_object, subtitle, True))

                        if subtitle in seen_script_attr:
                            if subtitle not in shared_script_attr:
                                shared_script_attr.append(subtitle)
                        else:
                            seen_script_attr.append(subtitle)
                    else:
                        logger.info('Found help section: %s, %s' % (title, subtitle))
                        changes[docname].append((offset, title, subtitle, False))

                offset += len(line)

def source_transform(app, docname, source):
    if docname != app.config.master_doc:
        add_indicies(app, docname, source)
    elif app.config.h2r_toc_from_doc:
        add_toc(app, docname, source)

def add_indicies(app, docname, source):
    modified = []
    offset = 0

    for insert_at, title, subtitle, is_script in changes[docname]:
        modified.append(source[0][offset:insert_at])
        offset = insert_at
        force_global = False

        try:
            if subtitle in app.config.h2r_script_object_force_global[title]:
                force_global = True
        except KeyError:
            pass

        if is_script:
            if not force_global:
                modified.append('.. index::\n   single: %s.%s\n\n' % (title, subtitle))
            else:
                logger.info('Script item \'%s\' forced as global' % (subtitle))

            if subtitle not in shared_script_attr:
                modified.append('.. index::\n   single: %s\n\n' % (subtitle))
        else:
            modified.append('.. index::\n   pair: %s; %s\n\n' % (title, subtitle))

    modified.append(source[0][offset:])
    source[0] = ''.join(modified)
    logger.info('Added %d indicies for document \'%s\'' % (len(changes[docname]), docname))

def add_toc(app, docname, source):
    # overwrite master doc source with the rst version of the contents page
    source[0] = parse_from_file(app.config.h2r_toc_from_doc)
    ## convert lists to toc items
    source[0] = re.sub(r'\* `([^`]+)`_?', r'   \1', source[0])
    ## insert toc directives
    source[0] = re.sub(r'(--+)', r'\1\n\n.. toctree::\n   :maxdepth: 1', source[0])
    ## add a glob toc to cover remaining docs
    source[0] += '\n.. toctree::\n   :glob:\n   :hidden:\n\n   *\n'
    logger.info('TOC page \'%s\' generated as:\n%s' % (app.config.master_doc, source[0]))

def setup(app):
    app.add_config_value('h2r_toc_from_doc', '', 'html')
    app.add_config_value('h2r_script_object_from_header', r'(.*)', 'html')
    app.add_config_value('h2r_script_object_force_global', {}, 'html')
    app.connect('env-before-read-docs', map_page)
    app.connect('source-read', source_transform)
    return {'version': sphinx.__display_version__, 'parallel_read_safe': True}
