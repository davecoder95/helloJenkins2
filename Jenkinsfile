pipeline {
    agent any
    stages {
        stage('set env') {
            steps {
              sh "chmod u+x env/awscred"
			  sh ". env/awscred"
			  sh "echo printing debasisisiiis"
			  sh "echo $AWS_ACCESS_KEY_ID"
              }
             }
			 
		stage('Submit Stack') {
            steps {
              sh "cat 01_s3cft.yml"
			  sh "aws cloudformation create-stack --stack-name s3bucket --template-body file://01_s3cft.yml --region 'us-east-1'"
              }
             }
            }
            }
