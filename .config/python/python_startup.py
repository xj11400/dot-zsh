#!/usr/bin/env python3

import atexit
import readline
import os

# save history file as ~/.cache/python/python_history
if 'PYTHONHISTFILE' in os.environ:
    histfile = os.path.expanduser(os.environ['PYTHONHISTFILE'])
elif 'XDG_DATA_HOME' in os.environ:
    histfile = os.path.join(os.path.expanduser(os.environ['XDG_DATA_HOME']),'python', 'python_history')
else:
    histfile = os.path.join(os.path.expanduser('~'),'python', 'python_history')

try:
    readline.read_history_file(histfile)
    readline.set_history_length(1000)
except FileNotFoundError:
    pass

atexit.register(readline.write_history_file, histfile)

