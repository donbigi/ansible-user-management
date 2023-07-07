# Provisioning an Ubuntu VM with Terraform and Running Ansible Playbook

This repository provides an example of how to provision an Ubuntu VM on Google Cloud Platform (GCP) using Terraform and then execute an Ansible playbook on the provisioned instance.

## Information on Chosen Linux Distribution

- Name: Ubuntu linux 20.04 LTS
- Machine Type: e2-medium
- Linux distro was created on GCP Compute Engine
- The Compute Engine instance was created using terraform

## Prerequisites

Before you begin, ensure that you have the following prerequisites installed:

- [Terraform](https://www.terraform.io/downloads.html)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)

## Setup

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/donbigi/ansible-user-management.git
   ```

2. Navigate to the cloned repository directory:

   ```bash
   cd ansible-user-management
   ```

3. Configure GCP credentials:

   - Create a service account in GCP with the necessary permissions for provisioning resources.
   - Download the service account key file (JSON format) and save it securely.
   - Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to the path of the service account key file.

4. Provision the Ubuntu VM using Terraform:

   - Open a terminal or command prompt and navigate to the `ansible-user-management` directory:

     ```bash
     cd ansible-user-management
     ```

   - Initialize Terraform:

     ```bash
     terraform init
     ```

   - Apply the Terraform configuration:

     ```bash
     terraform apply
     ```

   - Terraform will provision the Ubuntu VM on GCP. Note down the external IP address of the VM.

5. Configure Ansible and execute the playbook:

   - While still in the  `ansible-user-management` directory:

     ```bash
     cd ansible-user-management
     ```

   - Update the `inventory.ini` file:

     - Replace `<instance-external-ip>` with the external IP address of the VM provisioned in the previous step.
     - Ensure that the `ansible_ssh_private_key_file` value in `inventory.ini` points to the correct SSH private key file path on your local machine.

   - Execute the Ansible playbook:

     ```bash
     ansible-playbook -i inventory.ini ansible.yml
     ```

   - Ansible will connect to the Ubuntu VM and execute the tasks defined in the playbook.

## Customization

Customize the Terraform configuration in the `terraform/main.tf` file and the Ansible playbook in the `ansible/ansible.yml` file according to your requirements.

## Cleanup

To clean up and delete the resources created by Terraform, run the following command in the `ansible-user-management` directory:

```bash
terraform destroy
```

Confirm the deletion by entering `yes` when prompted.

## Manually Validate the Playbook

After applying ansible playbook, you should get a final output that looks like this:
```bash
my-ubuntu-instance         : ok=11   changed=9    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
if you want to verify mannualy, follow the instructions bellow

On the Gcould cloud shell run, SSH to the VM:
```bash
gcloud compute ssh example-instance --zone=us-central1-a
```

Check the /etc/skel for the script:
```bash
ls /etc/skel
```
check if user john was created:
```bash
cat /etc/passwd | grep -i john
```

check for superuser: 
```bash
sudo cat /etc/sudoers | grep -i john ALL=(ALL:ALL) ALL
```

check if vim, tmux and terraform was installed:
```bash
vim \
tmux \
terraform --version
```