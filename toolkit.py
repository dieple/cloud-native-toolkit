#!/usr/bin/env python

import argparse
import logging
import sys
import os
import inspect

# from pathlib import Path
from os.path import expanduser

# realpath() will make your script run, even if you symlink it :)
build_dir = os.path.realpath(os.path.abspath(os.path.split(inspect.getfile(inspect.currentframe()))[0]))
if build_dir not in sys.path:
    sys.path.insert(0, build_dir)

# include utils or lib modules from a subfolder
for include_dir in ["toolkits", "builder_tools", "terrascript"]:
    build_subdir = os.path.realpath(os.path.abspath(os.path.join(os.path.split(inspect.getfile(inspect.currentframe()))[0], include_dir)))
    if build_subdir not in sys.path:
        sys.path.insert(0, build_subdir)

from toolkits.utils import *

LOGLEVEL = os.getenv('LOG_LEVEL', 'INFO').strip()
logger = logging.getLogger()
logger.setLevel(LOGLEVEL.upper())
log_handler = logging.StreamHandler()
log_handler.setLevel(LOGLEVEL.upper())
log_formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
log_handler.setFormatter(log_formatter)
logger.addHandler(log_handler)

input_dockerfile = "./builder_tools/templates/Dockerfile.template"
input_pip_packages_file = "./builder_tools/templates/pip_packages.template"

output_dockerfile = "./Dockerfile"
entry_filename = "./entry.sh"
output_pip_packages_file = "./pip_packages"

terraform_text = "###INSTALL_TERRAFORM###"

home_dir = expanduser("~")

def process_arguments():
    parser = argparse.ArgumentParser()
    optional = parser._action_groups.pop()
    required = parser.add_argument_group('Required arguments')

    gh_user = os.environ.get('GITHUB_USERNAME')
    gh_email = os.environ.get('GITHUB_EMAIL')

    required.add_argument('--shareHostVolume',
                          help='Path where all development github repos are checked out. /home/<username>/repos',
                          required=True)
    required.add_argument('--baseImageVersion',
                          help='The toolkit base image version to use - e.g. 0.0.2',
                          required=True)

    optional.add_argument('--cloudflareApiToken', help='Cloudflare API Token', required=False)

    optional.add_argument('--toolkitImageName', help='End result tookit Docker image name', default='toolkit')
    optional.add_argument('--baseImageName', help='Base Docker image name', default='dieple/toolkit')
    optional.add_argument('--ansibleVersion', help='Ansible version', default='2.8.3')
    optional.add_argument("--installAnsible", type=str2bool, nargs='?', const=True, default=True, help="Install ansible?")

    optional.add_argument('--terraformVersion', help='Terraform version', default='0.12.31')
    optional.add_argument("--installTerraform", type=str2bool, nargs='?', const=True, default=True, help="Install Terraform?")

    optional.add_argument("--sshKeyDir", default="{0}/.ssh".format(home_dir), help="Host ssh directory")
    optional.add_argument("--awsConfigDir", default="{0}/.aws".format(home_dir), help="AWS config directory")
    optional.add_argument("--gitConfig", default="{0}/.gitconfig".format(home_dir), help="Git config")
    optional.add_argument("--kubeConfigDir", default="{0}/.kube".format(home_dir), help="Kubectl config directory")
    optional.add_argument("--sshKeyPassphrase", default="", help="ssh pass phrase")

    if is_empty(gh_user):
        gh_user = default_input("Env [GITHUB_USERNAME] not set - Enter github username", "dieple")

    if is_empty(gh_email):
        gh_email = default_input("Env [GITHUB_EMAIL] not set - Enter github Email", "diep@fifthrowtech.com")

    # print("DEBUG: gh_user {0}, gh_email {1}".format(gh_user, gh_email))
    optional.add_argument('--githubUsername', help='Github username', default="{0}".format(gh_user))
    optional.add_argument('--githubEmail', help='Github email', default="{0}".format(gh_email))

    parser._action_groups.append(optional)
    # logger.info("args {0}".format(parser.parse_args()))
    return parser.parse_args()

def create_docker_entry_file(args, entry_filename):
    with open(entry_filename, 'w', newline='\n') as f:
        gh_email = 'git config --global user.email "{0}"\n'.format(args.githubEmail)
        gh_user = 'git config --global user.name "{0}"\n'.format(args.githubUsername)
        # assume_role = "set -x && . /scripts/assume-role.sh {0} reassume-role\n".format(args.profile)

        mvcat = "cat /home/toolkit/.zshrc.pre-oh-my-zsh >> /home/toolkit/.zshrc\n"

        src = "source /home/toolkit/.zshrc\n"
        exec_stmt = 'exec "$@"\n'

        f.write('#!/bin/bash\n\n')
        f.write('# Please do not modify this file manually as it generate by toolkit.py\n\n')
        f.write(gh_email)
        f.write(gh_user)
        f.write("wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true\n")

        # f.write("eval `ssh-agent -s`")
        # f.write("printf '${sshKeyPassphrase}\n' | ssh-add /home/toolkit/.ssh/id_rsa")

        f.write(mvcat)
        f.write(src)
        f.write(exec_stmt)

    # make the entrypoint executable so that the docker image can run on startup
    make_executable(entry_filename)


def create_pip_packages_file(args, input_pip_packages_file, output_pip_packages_file):

    # required development packages to install during docker build image
    with open(input_pip_packages_file) as f:
        with open(output_pip_packages_file, "w", newline='\n') as f1:
            for line in f:
                f1.write(line)

    # add ansible==${version}
    if args.installAnsible == True:
        with open(output_pip_packages_file, "a") as f:
            f.write("ansible=={0}\n".format(args.ansibleVersion))

def create_dockerfile_from_template(args, dockerfile_template, output_dockerfile):
    with open(dockerfile_template) as fin:
        with open(output_dockerfile, "w", newline='\n') as fout:
            for line in fin:
                if (args.installTerraform):
                    # terraform is required
                    if (line.startswith(terraform_text)):
                        lout = line.replace(terraform_text, '')
                        fout.write(lout)
                    else:
                        fout.write(line)
                else:
                    fout.write(line)


def build_docker_image(args, dockerfile):
    toolkit_image_name = "{0}:{1}".format(args.baseImageName, args.baseImageVersion)
    dockerAppUser = "toolkit"
    print("TFVersion: {0}".format(args.terraformVersion))

    build_command = f'docker build --build-arg terraformVersion={args.terraformVersion} \
        --build-arg dockerAppUser={dockerAppUser} \
        --build-arg cloudflareApiToken={args.cloudflareApiToken} \
        --build-arg sshKeyPassphrase={args.sshKeyPassphrase} \
        --build-arg sshKey="$(cat {args.sshKeyDir}/id_rsa)"  \
        --build-arg sshKeyPub="$(cat {args.sshKeyDir}/id_rsa.pub)" \
        --build-arg baseImageVersion={args.baseImageVersion} --rm -f {dockerfile} -t {toolkit_image_name} .'

    logger.info("build_command: {0}".format(build_command))
    os.system(build_command)


def run_docker_image(args):

    tf_plugins_dir = "{0}/.terraform.d/plugins".format(home_dir)
    tf_cache_plugins_dir = "{0}/.terraform.d/plugin-cache".format(home_dir)
    toolkit_image_name = "{0}:{1}".format(args.baseImageName, args.baseImageVersion)
    dot_ansible_dir = "{0}/.ansible".format(home_dir)


    run_command = 'docker run --net=host \
                        --add-host=host.docker.internal:host-gateway \
                        -e "SET_CONTAINER_TIMEZONE=true" \
                        -e "CONTAINER_TIMEZONE=Europe/London" \
                        --memory=10g --memory-swap=-1 \
                        --interactive --tty -u {0} --rm \
                        --volume "{1}:/home/{0}/.kube" \
                        --volume "{2}:/home/{0}/.ssh" \
                        --volume "{3}:/home/{0}/.aws" \
                        --volume "{4}:/repos" \
                        --volume "{5}:/home/{0}/.terraform.d/plugin-cache" \
                        --volume "{6}:/home/{0}/.gitconfig" \
                        --volume "{7}:/home/{0}/.terraform.d/plugins" \
                        --volume "{8}:/home/{0}/.ansible" \
                        {9} /usr/bin/zsh'.format("toolkit", args.kubeConfigDir, args.sshKeyDir, \
                                              args.awsConfigDir, args.shareHostVolume, \
                                              tf_cache_plugins_dir, args.gitConfig, tf_plugins_dir, dot_ansible_dir, \
                                              toolkit_image_name)

    logger.info("run_command: {0}".format(run_command))
    os.system(run_command)


def main():

    args = process_arguments()
    print("args: {0}".format(args))

    create_docker_entry_file(args, entry_filename)
    create_pip_packages_file(args, input_pip_packages_file, output_pip_packages_file)
    create_dockerfile_from_template(args, input_dockerfile, output_dockerfile)
    build_docker_image(args, output_dockerfile)
    run_docker_image(args)


if __name__ == '__main__':
    main()
