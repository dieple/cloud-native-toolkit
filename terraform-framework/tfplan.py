#!/usr/bin/env python

# Orchestrator build script for all environments - to be called by CodeFresh or can be used interactively
import argparse
import sys
import os
import inspect
import hcl2

# realpath() will make your script run, even if you symlink it :)
build_dir = os.path.realpath(os.path.abspath(os.path.split(inspect.getfile(inspect.currentframe()))[0]))
if build_dir not in sys.path:
    sys.path.insert(0, build_dir)

# include utils or lib modules from a subfolder
for include_dir in ["buildscripts", "variables", "components", "tfvars"]:
    build_subdir = os.path.realpath(os.path.abspath(os.path.join(os.path.split(inspect.getfile(inspect.currentframe()))[0], include_dir)))
    if build_subdir not in sys.path:
        sys.path.insert(0, build_subdir)

from buildscripts.tfregions import *
from buildscripts.tfmodules import *
from buildscripts.tfprompts import *
from buildscripts.tfrun import *

input_envs_file = "./variables/envs.tf"
tf_actions = ["plan", "apply", "plan-destroy", "apply-destroy"]
module_dirs = ["components"]


def process_arguments():
    """
    Parse and process program arguments
    :return: argument parser
    """
    parser = argparse.ArgumentParser()
    optional = parser._action_groups.pop()
    required = parser.add_argument_group('Required arguments')

    required.add_argument('-a',
                          '--action',
                          help='Terraform action:--> plan, apply, plan-destroy, or apply-destroy',
                          required=True)

    optional.add_argument('-i',
                          '--interactive',
                          help='Interactive mode?',
                          required=False,
                          default=True)

    optional.add_argument('-p',
                          '--approve',
                          help='Auto approve?',
                          required=False,
                          default=False)

    parser._action_groups.append(optional)
    return parser.parse_args()


def parse_envs_file(envs_file):
    """
    The envs.tf file contains metadata that required to build an
    environment for a specific workspace
    :param envs_file:
    :return: list of workspaces and workspace data dict
    """
    with(open(envs_file, 'r')) as env_file:
        env_dict = hcl2.load(env_file)
    workspaces_dict = env_dict['variable'][0]['envs']['default']

    # setup the workspace/account to display and prompt user to select one to build
    workspaces = []
    for workspace in workspaces_dict:
        for key, val in workspace.items():
            workspaces.append(key + "|" + val['account_id'] + "|" + val ['account'])
    return workspaces, workspaces_dict


def main():

    args = process_arguments()

    if args.action not in tf_actions:
        sys.exit("Error: invalid terraform action! It should be ---> {0}".format(tf_actions))

    if args.interactive:
        # Not being build by CI/CD tool 
        workspaces, workspaces_dict = parse_envs_file(input_envs_file)

        # prompt user to select an account to build
        account_sel = prompt_account(workspaces)

        # prompt user to select module(s) to build
        build_modules = prompt_modules(find_modules(module_dirs))

        build_data = {}
        build_data["workspace"] = account_sel.split('|')[0]
        build_workspace = account_sel.split('|')[0]
        build_env = workspaces_dict[0][build_workspace]

        tfrun(args, build_modules, build_workspace, build_env)
    else:
        pass # for now


if __name__ == '__main__':
    main()
