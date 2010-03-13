# diffstat.py - integrate diffstat without shell pipes
#
# Copyright (C) 2007 Marti Raudsepp <marti@juffo.org>
#
# This software may be used and distributed according to the terms of the
# GNU General Public License version 2.0 or later, incorporated herein by
# reference.

"""diffstat integration

This extension adds integrated diffstat commands without needing to
pipe 'diffstat' manually in your shell.

To enable this extension, add the following lines to your hgrc file:
  [extensions]
  hgext.diffstat=

To add a changegroup (post-pull) hook:
  [hooks]
  changegroup = python:hgext.diffstat.hook

diffstat of repository (or selected files)      diffstat, ds
diffstat of the current mq patch                qdiffstat, qds
"""

from mercurial.i18n import gettext as _
from mercurial import commands, extensions, util, patch
import os

####

def open_diffstat(ui, format=1, name_width='auto', width=80, **opts):
    cmdline = ui.config("paths", "diffstat", "diffstat")

    cmdline += ' -p 1' # mercurial always prepends a/ or b/ to paths
    if format != 1:
        cmdline += ' -f %d' % format
    if name_width != 'auto':
        cmdline += ' -n %s' % name_width
    if width != -1:
        cmdline += ' -w %d' % width

    ui.note('running %s\n' % cmdline)
    import subprocess as s
    pipe = s.Popen(cmdline, shell=True, bufsize=-1, stdin=s.PIPE).stdin
    return pipe

def diffstat(ui, repo, *pats, **opts):
    """show diffstat of repository (or selected files)

    See 'hg help diff' for more information
    """
    pipe = open_diffstat(ui, **opts)

    # Careful, we're monkey-patching the UI here
    oldwrite = ui.write
    ui.write = pipe.write
    try:
        commands.diff(ui, repo, *pats, **opts)
    finally:
        ui.write = oldwrite

def qdiffstat(ui, repo, *pats, **opts):
    """show diffstat of the current mq patch
    
    see 'hg help qdiff' for more information
    """
    try:
        mq = extensions.find('mq')
    except KeyError:
        raise util.Abort(_("'mq' extension not loaded"))

    mq.reposetup(ui, repo)

    pipe = open_diffstat(ui, **opts)

    ui.write = pipe.write
    repo.mq.diff(repo, pats, opts)

def hook(ui, repo, **opts):
    """shows diffstat of changes after each pull

    To use a changegroup (after pull) hook, add this to your hgrc:
    [hooks]
    changegroup = python:hgext.diffstat.hook
    """
    if 'node' not in opts:
        ui.warn('diffstat.hook: unhandled hook type: %s' % opts['hooktype'])
        return

    startnode = opts['node'].decode('hex')
    endnode = repo.lookup(repo.changelog.count() - 1)

    pipe = open_diffstat(ui, **opts)

    patch.diff(repo, startnode, endnode, fp=pipe)

####

diffstatopts =  [
    ('f', 'format', 1, _('format (0=concise, 1=normal, 2=filled, 4=values)')),
    ('n', 'name-width', 'auto', _('minimum filename width (default: auto)')),
    ('w', 'width', -1, _('maximum width of the output (default: 80)')),
]

walkopts = [
    ('I', 'include', [], _('include names matching the given patterns')),
    ('X', 'exclude', [], _('exclude names matching the given patterns')),
]

cmdtable = {
    "diffstat|ds": (diffstat,
        [
            ('r', 'rev', [], _('revision')),
            ('a', 'text', None, _('treat all files as text')),
        ] + walkopts + diffstatopts,
        _('hg diffstat [OPTION]... [-r REV1 [-r REV2]] [FILE]...')),
    "qdiffstat|qds": (qdiffstat,
        walkopts + diffstatopts,
        _('hg qdiffstat [OPTION] [FILE]...')),
}
