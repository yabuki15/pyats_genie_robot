import logging
import re
import time

from ats import aetest
from ats.log.utils import banner
from genie.conf import Genie
from genie.abstract import Lookup # noqa
from genie.libs import ops # noqa
from pyats.async_ import pcall
from tabulate import tabulate
import yaml


log = logging.getLogger(__name__)

###################################################################
#                  COMMON SETUP SECTION                           #
###################################################################


class common_setup(aetest.CommonSetup):
    """ Common Setup section """

    # Connect to each device in the testbed
    @aetest.subsection
    def connect(self, testbed):
        genie_testbed = Genie.init(testbed)
        self.parent.parameters['testbed'] = genie_testbed
        device_list = []
        for device in genie_testbed.devices.values():
            #if device.os in ("ios", "iosxe", "nxos"):
            if device.os in ("linux"):
                log.info(banner(
                    "Connect to device '{d}'".format(d=device.name)))
                try:
                    device.connect()
                except Exception:
                    self.failed("Failed to establish connection to '{}'".format(device.name))
                device_list.append(device)

        # Pass list of devices the to testcases
        self.parent.parameters.update(dev=device_list)


###################################################################
#                     TESTCASES SECTION                           #
###################################################################

class check_info(aetest.Testcase):
    """ This is user Testcases section """

    def check_system_info(self, device):
        res_system_info = device.execute("net show system")
        print(res_system_info)

class common_cleanup(aetest.CommonCleanup):
    """ Common Cleanup for Sample Test """

    @aetest.subsection
    def clean_everything(self):
        """ Common Cleanup Subsection """
        log.info("All Done! ")


if __name__ == '__main__':
    aetest.main()
