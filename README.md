<b>Terraform Mini Project</b>

1. Using Terraform, create 3 EC2 instances and put them behind an Elastic Load Balancer
2. Make sure the after applying your plan, Terraform exports the public IP addresses of the 3 instances to a file called host-inventory
3. Get a .com.ng or any other domain name for yourself (be creative, this will be a domain you can keep using) and set it up with AWS Route53 within your terraform plan, then add an A record for subdomain terraform-test that points to your ELB IP address.
4. Create an Ansible script that uses the host-inventory file Terraform created to install Apache, set timezone to Africa/Lagos and displays a simple HTML page that displays content to clearly identify on all 3 EC2 instances.
5. Your project is complete when one visits terraform-test.yoursdmain.com and it shows the content from your instances, while rotating between the servers as your refresh to display their unique content.
6. Submit both the Ansible and Terraform files created


<br><b>Solution</b>
1. Created a terraform backend to store the state file in an S3 bucket and DynamoDB table to lock the state file.
2. Created modules for the VPC, EC2 instances, ELB and Route53.
3. Created a terraform script to create the VPC, EC2 instances, ELB, Security group and Route53 from the modules.
4. Created an Ansible playbook to install Apache, set timezone to Africa/Lagos and displays a simple HTML page that displays content to clearly identify on all 3 EC2 instances.
5. Created a shell script to run the ansible playbook, this script is called from the terraform script.