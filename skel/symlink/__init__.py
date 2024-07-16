import os
from ZenPacks.zenoss.ZenPackLib import zenpacklib

CFG = zenpacklib.load_yaml([os.path.join(os.path.dirname(__file__), "zenpack.yaml")], verbose=False, level=30)
schema = CFG.zenpack_module.schema


import Globals
import os.path

from Products.ZenModel.ZenPack import ZenPack as ZenPackBase
from Products.ZenUtils.Utils import zenPath

#unused(Globals)

_plugins = os.listdir('libexec')
_plugins = [item for item in _plugins if '__init__.py' not in item]

class ZenPack(ZenPackBase):

    def install(self, app):
        super(ZenPack, self).install(app)
        self.symlink_plugins()

    def symlink_plugins(self):
        libexec = os.path.join(os.environ.get('ZENHOME'), 'libexec')
        if not os.path.isdir(libexec):
            # Stack installs might not have a $ZENHOME/libexec directory.
            os.mkdir(libexec)
        for plugin in _plugins:
            #LOG.info('Linking %s plugin into $ZENHOME/libexec/', plugin)
            plugin_path = zenPath('libexec', plugin)
            os.system('ln -sf "%s/%s" "%s"' % (self.path('libexec'), plugin, plugin_path))
            os.system('chmod 0755 %s' % plugin_path)

    def remove_plugin_symlinks(self):
        for plugin in _plugins:
            #LOG.info('Removing %s link from $ZENHOME/libexec/', plugin)
            os.system('rm -f "%s"' % zenPath('libexec', plugin))
