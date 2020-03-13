import os
import subprocess

from .tfprompts import *

link_files_list = ["backend.tf", "data.tf", "envs.tf", "providers.tf", "tags.tf"]

def tfrun(args, build_modules, build_workspace, build_env):
    """
    Using python-terraform package we can invoke terraform statements
    such as terraform init, plan, apply etc. in python code
    :param build_modules:
    :param build_workspace:
    :param build_env:
    :return:
    """

    # loop through each selected module(s) and apply the action as specified by user
    for m in build_modules:
        print("\n\n****************************************************************************")
        print("Permforming action \"{0}\" for module {1}".format(args.action, m))
        print("****************************************************************************\n\n")
        run_module(args, m, build_workspace, build_env)


def softlinking_files(module_path):

    curr_path = os.getcwd()
    rel_path = os.path.relpath(f"{curr_path}/variables", f"{curr_path}/{module_path}")
    for f in link_files_list:
        file_path = f"{curr_path}/{module_path}/{f}"
        rm_ln_cmd = f"cd {curr_path}/{module_path} && rm {f}"
        if os.path.exists(file_path) and os.path.islink(file_path):
            print(f"removing old linking file {f}...")
            process1 = subprocess.run(rm_ln_cmd, shell=True, check=False, stdout=subprocess.PIPE)
            output1 = process1.stdout

        print(f"linking file {f}...")
        ln_cmd = f"cd {curr_path}/{module_path} && ln -s {rel_path}/{f} ."
        process2 = subprocess.run(ln_cmd, shell=True, check=True, stdout=subprocess.PIPE)
        output2 = process2.stdout


def run_module(args, module_path, workspace, module_data):
    """
    Loop through list of selected module(s) and build based on the selected account
    :return:
    """

    mod_path = module_path.replace('./', '')
    curr_path = os.getcwd()
    tfvar_path = module_path.replace('./components/', '')
    print("curr_path = {0}".format(curr_path))
    print("DEBUG module_path = {0}".format(module_path))
    module_name = module_path.split('/')[-1]
    print("DEBUG module_name = {0}".format(module_name))

    key_config = "\"key={0}/terraform.tfstate\"".format(module_name)
    bucket_region_config = "\"region={0}\"".format(module_data["bucket_region"])
    bucket_config = "\"bucket={0}\"".format(module_data["bucket"])
    dynamodb_config = "\"dynamodb_table={0}\"".format(module_data["dynamodb"])

    plan_output_file = "plan.out"
    tf_varfile = f"{curr_path}/tfvars/{tfvar_path}/{workspace}.tfvars"
    tf_varfile_common = f"{curr_path}/tfvars/terraform.tfvars"
    tf_varfile_tags = f"{curr_path}/tfvars/core/taggings/{workspace}.tfvars"
    backend_override = f"{curr_path}/variables/config/backend_override.tf"
    providers_override = f"{curr_path}/variables/config/providers_override.tf"

    softlinking_files(mod_path)

    remove_prev_run = f"cd {module_path} && rm -f {plan_output_file} && rm -rf .terraform"
    cp_override_cmd = f"cd {module_path} && cp {backend_override} . && cp {providers_override} ."

    tf_plan_cmd = f"cd {module_path} && terraform workspace new {workspace} || terraform workspace select {workspace} && terraform plan -out {plan_output_file} --var-file {tf_varfile} --var-file {tf_varfile_common} --var-file {tf_varfile_tags}"
    tf_plan_destroy_cmd = f"cd {module_path} && terraform workspace new {workspace} || terraform workspace select {workspace} && terraform plan -destroy --var-file {tf_varfile} --var-file {tf_varfile_common} --var-file {tf_varfile_tags} -out {plan_output_file}"
    tf_apply_cmd = f"cd {module_path} && terraform workspace new {workspace} || terraform workspace select {workspace} && terraform apply {plan_output_file}"
    tf_init_cmd = f"cd {module_path} && terraform init --backend-config={key_config} --backend-config={bucket_region_config} --backend-config={dynamodb_config} --backend-config={bucket_config} && terraform workspace new {workspace} || terraform workspace select {workspace}"
    print(tf_init_cmd) # let's leave this in

    os.system(remove_prev_run)
    os.system(cp_override_cmd)
    os.system(tf_init_cmd)

    if args.action.lower() == 'plan':
        # always auto approve 'plan' action
        os.system(tf_plan_cmd)
    elif args.action.lower() == 'plan-destroy':
        # always auto approve 'plan' action
        os.system(tf_plan_destroy_cmd)
    elif args.action.lower() == 'apply':
        if args.approve:
            # auto-approve flag enabled so skip user confirmation
            os.system(tf_plan_cmd)
            os.system(tf_apply_cmd)
        else:
            os.system(tf_plan_cmd)
            # confirm with user first
            if user_confirmation("Sure you want to APPLY {0}".format(module_path)):
                os.system(tf_apply_cmd)
            else:
                print("User aborting...")
    elif args.action.lower() == 'apply-destroy':
        if args.approve:
            os.system(tf_plan_cmd)
            os.system(tf_apply_cmd)
        else:
            # confirm with user first
            os.system(tf_plan_destroy_cmd)
            if user_confirmation("Sure you want to APPLY DESTROY {0}".format(module_path)):
                os.system(tf_apply_cmd)
            else:
                print("User aborting...")
