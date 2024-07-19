import os

from Products.ZenModel.ZenPack import ZenPack as ZenPackBase
from Products.ZenUtils.Utils import zenPath

class ZenPack(ZenPackBase):

    def remove(self, app, leaveObjects=False):
        '''
        the script is automatically installed by the ZPLBin loader, but
        needs to be manually cleaned up on removal. 
        '''
        self.removeSymlinks()
        super(ZenPack, self).remove(app, leaveObjects)

    def removeSymlinks(self):
        '''
        Remove files we installed in bin/
        '''
        scriptDir = os.path.join(self.path(), "bin")
        for symLink in [os.path.join(zenPath("bin"), f) for f in os.listdir(scriptDir)]:
            try:
                os.unlink(symLink)
            except OSError:
                pass
