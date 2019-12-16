import os
import argparse

def str2bool(val):
	if val.lower() in ('yes', 'true', 't', 'y', '1'):
		return True
	elif val.lower() in ('no', 'false', 'f', 'n', '0'):
		return False
	else:
		raise argparse.ArgumentTypeError('Boolean value expected.')

def make_executable(path):
	mode = os.stat(path).st_mode
	mode |= (mode & 0o444) >> 2  # copy R bits to X
	os.chmod(path, mode)

def default_input(message, default_value):
	if default_value:
		return input("{0} [{1}]: ".format(message, default_value)) or default_value
	else:
		return input( "{0} ".format(message))

def is_empty(chk_data):
	if chk_data:
		return False
	else:
		return True