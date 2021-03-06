"""Validation tests for The Open Worm Project
------------------------------------------
This works best if it is installed first:
For normal users:
  pip install .
For developers:
  pip install -e . --process-dependency-links
Set an environment variable OW_HOME to the location of the directory 
that contains any OpenWorm repositories that you want to test.
"""

import os
from sciunit.utils import NotebookTools
import unittest

DEFAULT_OW_HOME = os.path.join(os.environ.get('HOME'),'openworm')
OW_HOME = os.environ.get('OPENWORM_HOME',DEFAULT_OW_HOME)
if not os.path.isdir(OW_HOME):
    msg = 'No directory found at %s.  Please set OW_HOME to the location of your OpenWorm projects directory.' % OW_HOME
    raise FileNotFoundError(msg)
CW_HOME = os.path.join(OW_HOME,'ChannelWorm')

class ChannelNotebooks(NotebookTools,unittest.TestCase):
    """Unit tests for documentation notebooks"""

    path = '.' # Path to notebooks to be tested

    def test_egl19_iv(self):
        self.do_notebook('EGL-19_IV')

 
class CellNotebooks(NotebookTools,unittest.TestCase):
    """Unit tests for documentation notebooks"""

    path = '.' # Path to notebooks to be tested

    def test_muscle_model(self):
        self.do_notebook('Muscle-Model')
    