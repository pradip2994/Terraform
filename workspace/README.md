## Create terraform files

![Screenshot 2023-09-30 213906](https://github.com/pradip2994/Terraform_Project/assets/124191442/3cc86a61-6641-40e3-ac4b-9b0115daec1e)

## Reformat your configuration in the standard style
```
terraform fmt
```
### now Create workshape using command 
```
terraform workspace new dev
terraform workspace new prod
```
![Screenshot 2023-09-30 214324](https://github.com/pradip2994/Terraform_Project/assets/124191442/9ad16a46-6cf2-4fe3-a88f-b70d811d3a51)

## Prepare your working directory for other commands
```
terraform init
```

![Screenshot 2023-09-30 214823](https://github.com/pradip2994/Terraform_Project/assets/124191442/21b1ba28-b0f2-4bf5-9eab-81879a161a41)

## Show changes required by the current configuration
```
terraform plan
```
### you can see that it took default configuration

![Screenshot 2023-09-30 214910](https://github.com/pradip2994/Terraform_Project/assets/124191442/dcc65cd3-5c39-45a9-984c-97a89864fe41)

## This command shows the use cases of workspace
```
terraform workspace -h
```

![Screenshot 2023-09-30 215013](https://github.com/pradip2994/Terraform_Project/assets/124191442/ce674ac4-05df-4b26-be61-52d69fbe7082)

```
terraform workspace show
terraform plan
```
### now you can see that it has taken configuration of development team i.e dev (instance_type= t2.micro)

![Screenshot 2023-09-30 215112](https://github.com/pradip2994/Terraform_Project/assets/124191442/deb424ae-9af6-4e7a-b793-0ee2d3663317)

### now you can see that when workspace is selected to prod it has taken configuration of production team i.e prod (instance_type= t2.xlarge)
```
terraform workspace select prod
terraform workspace show
terraform plan
```
 
![Screenshot 2023-09-30 215234](https://github.com/pradip2994/Terraform_Project/assets/124191442/e93f546d-dfaf-4911-a409-3d2b25dadcca)

## now if you do 
```
tree
```
### now you can see that terraform state file is created in dev 

![Screenshot 2023-09-30 215539](https://github.com/pradip2994/Terraform_Project/assets/124191442/a2eebc4e-6af4-4c98-ac89-03e17f7b2676)

### Similarly terraform state file is created in prod

![Screenshot 2023-09-30 215728](https://github.com/pradip2994/Terraform_Project/assets/124191442/35093469-1a42-40d6-94ba-2ab46720b3ce)

### you can see backup file is also created in dev and prod

![Screenshot 2023-09-30 220016](https://github.com/pradip2994/Terraform_Project/assets/124191442/55f74e4f-16fc-42f1-8f2c-7bc50b9b826f)
