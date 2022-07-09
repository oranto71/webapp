node('master') 
{
    stage('Continuous Download')
                   {
                     git branch: 'terraform', credentialsId: 'me', url: 'https://github.com/ttnwt/webapp.git'
                   }
    stage('TF Init$Plan')
                   {
                    sh 'terraform init'
                    sh 'terraform plan'
                   }
     stage('Continuous delivery')
                   {
                    input message: 'Waiting for approval from executor', submitter: 'ttwnt'
                    deploy adapters: [tomcat8(credentialsId: 'prodep', path: '', url: 'http://172.31.95.153:8080')], contextPath: 'catenv', war: '**/*.war'
                   }
     stage('TF Apply')
                   {
                    sh 'terraform apply imput=false'
}
}
