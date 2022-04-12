import os
from ats.easypy import run


def main():
    testscript = os.path.join('./check_system_info_script.py')
    run(testscript=testscript)
