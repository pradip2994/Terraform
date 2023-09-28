# Automating AWS Infrastructure Deployment with Terraform

## Deployment of AWS resources such as Virtual Private Cloud (VPC), Subnets, Internet Gateway, Route Tables, Security Groups, Application Load Balancers, and EC2 Instances.
Outline:

1) Creating the VPC
2) Setting Up Subnets
3) Internet Gateway Attachment
4) Routing and Route Tables
5) Security Groups for EC2 Instances
6) Deploying EC2 Instances
7) Application Load Balancer (ALB)
8) Load Balancer Listener and DNS
9) Running Terraform and Deploying Resources 

### Install AWS CLI and Configure.

![Screenshot 2023-09-28 060540](https://github.com/pradip2994/Terraform/assets/124191442/0e27ee5e-4ee1-4bc7-8b43-152e521a2a5f)

### Create terraform file main.tf, variable.tf, user_data1.sh, and provider.tf 

![Screenshot 2023-09-28 060629](https://github.com/pradip2994/Terraform/assets/124191442/a416d3a2-453b-4333-80b0-5a9da4a9a2a5)

### Reformat your configuration in the standard style and Prepare your working directory for other commands

```
terraform fmt
terraform init
```

![Screenshot 2023-09-28 060828](https://github.com/pradip2994/Terraform/assets/124191442/86f61e45-f918-4f09-98b4-a971da756dd7)

### Check whether the configuration is valid

```
terraform validate
```

![Screenshot 2023-09-28 060901](https://github.com/pradip2994/Terraform/assets/124191442/5f081da1-12e4-4122-a24c-57868961d4f9)

### Show changes required by the current configuration

```
terraform plan
```

![Screenshot 2023-09-28 060956](https://github.com/pradip2994/Terraform/assets/124191442/574610bc-f45a-45e7-b7f4-61585917f8d9)
![Screenshot 2023-09-28 061019](https://github.com/pradip2994/Terraform/assets/124191442/f59b362a-ecef-46c1-bb5b-bf052296781b)

### Create or update infrastructure

```
terraform apply
```

![Screenshot 2023-09-28 061109](https://github.com/pradip2994/Terraform/assets/124191442/edc352c4-8559-4ebc-9631-05fdbd7be4af)
![Screenshot 2023-09-28 061442](https://github.com/pradip2994/Terraform/assets/124191442/12ab8d45-f94c-462d-aa96-0e8eb76a8c8d)

### In above image you can see at the bottem loadbalancer endpoint copy and paste in Browser.

![Screenshot 2023-09-28 061534](https://github.com/pradip2994/Terraform/assets/124191442/67150a67-50c2-4826-b1fe-a713dc2f8f52)
![Screenshot 2023-09-28 061551](https://github.com/pradip2994/Terraform/assets/124191442/23b991c2-f58d-4f28-8c60-e4cfb0e456ba)

### in above you can see the webpage response from both the server.

### Destroy previously-created infrastructure

![Screenshot 2023-09-28 061853](https://github.com/pradip2994/Terraform/assets/124191442/15bd9a52-ebd0-498c-82f1-3e7337e7803f)

#### Thank you for reading!
