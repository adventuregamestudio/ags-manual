# -*- coding: utf-8 -*-
"""
    sphinx.ext.h2r
    ~~~~~~~~~~~~~~
    info goes here
"""

import sphinx
import re
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
        with open(env.doc2path(docname)) as f:
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

def add_indices(app, docname, source):
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

def setup(app):
    app.add_config_value('h2r_script_object_from_header', r'(.*)', 'html')
    app.add_config_value('h2r_script_object_force_global', {}, 'html')
    app.connect('env-before-read-docs', map_page)
    app.connect('source-read', add_indices)
    return {'version': sphinx.__display_version__, 'parallel_read_safe': True}
