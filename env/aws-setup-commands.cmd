
# create key pair
aws ec2 create-key-pair --key-name DebKeyPair1

#create role 
aws iam create-role --role-name ec2-jenkins-role --assume-role-policy-document file://role-trust-policy.json


#attach policy to role 
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess  --role-name ec2-jenkins-role
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaRole  --role-name ec2-jenkins-role
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonSNSFullAccess  --role-name ec2-jenkins-role
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AWSCloudFormationFullAccess  --role-name ec2-jenkins-role



aws iam create-instance-profile --instance-profile-name ec2-jenkins-ip
aws iam add-role-to-instance-profile --role-name ec2-jenkins-role --instance-profile-name ec2-jenkins-ip


#create security group 
aws ec2 create-security-group --group-name ec2-Jenkins-SG --description "Jenkins security group"


#attach inbound rules 
aws ec2 authorize-security-group-ingress --group-name ec2-Jenkins-SG --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name ec2-Jenkins-SG --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name ec2-Jenkins-SG --protocol tcp --port 8080 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name ec2-Jenkins-SG --protocol tcp --port 443 --cidr 0.0.0.0/0

	
#create ec2 instanve  	
--aws ec2 run-instances --image-id ami-0aa7d40eeae50c9a9 --instance-type t2.micro --key-name DebKeyPair1  --security-group-ids sg-0cc9afd93cf6921a5  --region us-east-1a --block-device-mappings file://ebs-mapping.json --associate-public-ip-address 

aws ec2 run-instances --image-id ami-0aa7d40eeae50c9a9 --iam-instance-profile "Name=ec2-jenkins-ip" --instance-type t2.micro --key-name DebKeyPair1 --region us-east-1 --block-device-mappings file://ebs-mapping.json --associate-public-ip-address 


#$aws ec2 associate-iam-instance-profile --instance-id YourInstanceId --iam-instance-profile Name=YourNewRole-Instance-Profile
