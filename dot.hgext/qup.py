# qup.py - move MQ patches to top of unapplied part of series
#
# Copyright 2008 Andrei Vermel <andrei.vermel@gmail.com>
#
# This software may be used and distributed according to the terms
# of the GNU General Public License, incorporated herein by reference.

from mercurial.i18n import _
from mercurial.node import *
from mercurial import commands, cmdutil, hg, node, util
import os, tempfile

def qup(ui, repo, *patches, **opts):
    '''move MQ patches to top of unapplied part of series.

Patches can be specified by unambiguous start substrings or indices.'''

    try:
        series = file(repo.path+'/patches/series', 'r')
    except:
        raise util.Abort(_('patch queue not found'))

    q = repo.mq

    if not patches:
        raise util.Abort(_('no patches specified'))

    old_num_patches = len(patches)
    patches = [q.lookup(patch) for patch in patches]
    patches_dict = dict.fromkeys(patches)
    if len(patches_dict.keys()) != old_num_patches:
        raise util.Abort(_(('same patch specified multiple times, %s') % patches))

    series_dict = dict.fromkeys(q.series)
    for p in patches:
        if p not in series_dict:    
            raise util.Abort(_(('patch %s is not in series') % p))
   
    applied=[a.name for a in q.applied]
    for a in applied:
        if a in patches_dict:
            raise util.Abort(_(('patch %s is applied already, can\'t move') % a))

    pending_applied = False
    if applied:
        top_applied = applied[-1]
        pending_applied = True
   
    tokeep = [] 
    tofront = {}
    toback = []
    for line in series:
        if line.strip().startswith('#'):
            toback.append(line)
        else:
            spl = line.split('#')
            firstword=''
            if spl:
                firstword = spl[0].strip()
            if pending_applied:
                tokeep.append(line)
                if firstword == top_applied:
                    pending_applied = False
            else:
                if firstword in patches_dict:
                    tofront[firstword]=line
                else:
                    toback.append(line)

    if pending_applied:
        raise util.Abort(_('top applied patch not found in the series?'))
    if not tofront:
        raise util.Abort(_('none of specified patches found in the series'))

    outfd, outname = tempfile.mkstemp(dir=repo.path+'/patches')
    outfile = os.fdopen(outfd, 'w')
    outfile.writelines(tokeep)
    for patch in patches:
        outfile.write(tofront[patch].rstrip('\n')+'\n')
    outfile.writelines(toback)
    outfile.close()
    series.close()
    os.remove(series.name)
    os.rename(outname, series.name)

cmdtable = {
    'qup':
        (qup, [],
        _('hg qup PATCH...')),
}
