<<<<PROVIDERS>>>>

provider "aws" {
    region = "us-east-1"  # Set your desired AWS region
    aws_secred_key = "fasdfsa"
    etc
}


> this is given in the main counfiguration file (which is main.tf)
> here we can change the provider as we need for example now we have provider "aws, it can be "azure", "digital-ocean" etc
> the region can be any region (us-east-1, us-west-1 etc)


> This will verify if terraform has access to the aws, (azure, digitalocean) or not after entering a particular command


<<<<<RESOURCES>>>>>

resource "aws_instance" "example" {
    ami           = "ami-0c55b159cbfafe1f0"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
}

> determines which resource to use from the playground

<<<<COMMANDS>>>>
>>> terraform init ---> (for initialization of terraform, it will initialize the provider plugins)
>>> terraform plan ---> (dry run, before applying the counfiguration it is going to show you what is going to happend and ask for confirmation)


![alt text](image.png)



Note:
Know after apply is shown in many fields because you will only get the values of the field after applying the configuration file


>>> terraform apply ----> (for applying the counfiguration and creating the instance- resource mentioned in the provider)
>>> terraform destroy ---> (this will check the state file and destroy and the resources which we are using in the provider)

<<<TERRAFORM STATE FILE>>>

> terraform.tfstate --> (it uses this file to keep track of what ever is happening )

> terraform show ---> command for showing the state file

Note:
That is it keeps track of the configuration file and if any changes were made to it it will first check this file, because terraform won't know that you have already created another instance so it will check here if nothing exist here it will create which is given in the resources and if you've added a new resource after that it will first check it here and then if it doensn't exist it will create and keeps a track of the INFRASTRUCTURE that we created.

Securing sensitive info in state file 
local state file
remote state file
how to run terraform in the CI/CD

<<<Providers- In Detail>>>

> it is a plugin which helps terraform where these entire resources/project has to be created

> There is a terraform providers page (official, partner, community)
    - official - hashicorp activly maintains
    - community - maintained by opensource
    - parner - some company is maintaining this one

Link: https://registry.terraform.io/browse/providers


What if we need to create multi region providers ?
How do you setup terraform to set up infrastructure in multiple cloud (hubrid cloud) ?

Note:
Alias can be anything and but while writing the providers in the resourses we have to call it by that alias given 

<<<<MULTIREGION>>>>

providers "aws" {
    alias = "East"
    region = "us-east-1"
}

provider "aws" {
    alias = "West",
    region = "us-west-1"
}

resources "aws.instance" "example" {
    ami = "ami-09876544"
    instance_type = "t2.micro"
    provider = "aws.East"
}

resource "aws.instance" "example2 {
    ami = "ami-93487593"
    instance_type = "t2.micro"
    provider = "aws.West"
}

<<<<VARIABLES>>>>
> to parameterize (pass values to project)
> instead of hardcoding assign it to the variables and then pass it

resource "aws_instace" "example" {
    ami: = variable1,
    instance_type: variable2
}

>> In terraform there are two types of variables
    > input variable
    > output variable


    <<<Input variable>>>
    > infor passed to terrafrom is called as input variable

    <<<Output variable>>>
    > If you want terraform to print a particular value in the ouput is called as output variable


> Note: Input variables can be defined within the module or at the root level of our configuration

>> Example of a variable

variable "example_var" {
    description = "An example input variable"  --> provides a human readable description of the variable (optional)
    type = string --> specifies the data type of the variable (string, number , list , map, boolean etc)
    default = "default_value" --> provides a default value for the variable (is optional)
}

variable "instance_type" {
    description = "An description of an instance"
    type = string
    default = "t2.micro"
}


How to use this variable now ?

resource "aws_instance" "example_instance" {
    ami = var.example_var
    instance_type = var.instance_type
}

> In this case it will take the default value since it is defined here for the instance type now what if we don't have an default value ?

>> You can pass the value of the variable from the terraform apply command if it is not there 
>> You can also put the values of these in a different file as well, variables.tf


<<<<<OUTPUT VARIABLES>>>>>

> The syntax for the output variables is slightly different from the input variables
> This is used when we need to give back the values after the terraform apply command is successful


resource "aws_instance" "example_instance" {
    ami = var.ami_id
    instance_type = var.instance_type
}

output "public_ip" {
    description = "This is the public ip"
    value = aws_instance.example_instance.public_ip
}


The terraform structure is like:

> main.tf
    > provider.tf
    > Input.tf
    > Output.tf
> terraform.tfvars


Note:
if we were to use terraform.tfvars we can write all the variables inside this and it is like key_value pairs.
if we were to use terraform.tfvars we can simply use it and while applying it will check for that values inside the terraform.tfvars file and if it exists it will take that value and if it doesn't it will take the default value given to it
- now for different puposes we might need to change the value of the variables eg: test env, dev env, prodcution etc so instead of updating the terraform.tfvars we can simply create more such files like 

 - dev.tfvars
 - prod.tfvars
 - test.tfvars

but if we were to change the name while using the command terraform apply we will specifically need to mention the .tfvars file which we need to use.


<<<<<<CONDITIONAL EXPRESSIONS>>>>>>

Just like optional chaining in JS

> SYNTAX

    condition ? true_val : false_val

<<<Buildin function>>>

example: 

>> Length

variable "my_list" {
    type= list
    default = ["apple", "orange", "mango"]
}

output {
    value = length(var.my_list)
}

>> Map

variable "keys" {
    type = list
    default = ["Alice", 30]
}

output {
    value = map(var.keys, var.values)
}

<!-- returns {"name" = "Alice", "age" = 30} -->

>> Lookup (there are a lot more of them use documentation)


<<<<State file>>>>
> stores the info of the infrastructure taht is created
> developers shouldn't have access to the state file since all the data regarding the instances are in there (as a devops engineer)

terraform show --> to show the state file in the command panel


> drawbacks
terraform will even store keys which are not supposed to be shown 
don't show the state file in github

<<<REMOTE BACKEND>>>

> for storing the state file in a external resource like s3 bucket, and don't bother about the backend 
eg: s3 bucket, terraform cloud, azure storage