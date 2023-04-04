@Library('jenkins-shared')_

pipeline{
    agent{
        kubernetes{
            yaml libraryResource('podTemplateRelease.yaml')+libraryResource('podTemplateBase/<container>.yaml')
        }
    }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '40', artifactNumToKeepStr: '40'))
        disableResume()
        timeout(time: 1, unit: 'HOURS')
    }
    
    triggers {
        cron('H 0 * * *') 
    }
    
    stages{
        stage('Checkout'){
            environment{
                SSH_KEY = credentials('abcde12345')
            }
            steps{
                container('<container-name>'){
                    checkoutMaster()
                }
            }
        }
        stage('Print group roles'){
            environment {
                GCLOUD_CREDS_FILE = "${INFRA_CREDS}"
                GOOGLE_APPLICATION_CREDENTIALS = "${INFRA_CREDS}"
            }
            steps{
                dir('code'){
                    script{
                        PROJECTS = ['project-ID-1', 'project-ID-2', 'project-ID-3']
                        container('<container-name>'){
                            sh 'echo $(date) >> $BUILD_NUMBER-testing-iamlist.csv'
                            for (project in PROJECTS) {
                                withCredentials([file(credentialsId: "${project}-plan-creds-gsm", variable: 'INFRA_CREDS')]){
                                    withEnv(["project=${project}"]){
                                    sh '''
                                        gcloud auth activate-service-account --key-file="${INFRA_CREDS}"
                                        echo ${project} >> $BUILD_NUMBER-testing-iamlist.csv
                                        gcloud projects get-iam-policy ${project} \
                                        --flatten="bindings[].members[]" \
                                        --format="csv[no-heading](${project},bindings.role,bindings.members)" \
                                        --filter="bindings.members:group" >> $BUILD_NUMBER-testing-iamlist.csv
                                    '''
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        stage('Print to Bucket'){
            environment {
                GCLOUD_CREDS_FILE = "${INFRA_CREDS}"
                GOOGLE_APPLICATION_CREDENTIALS = "${INFRA_CREDS}"
            }
            steps{
                dir('code'){
                    script{
                        container('<container-name>'){
                            withCredentials([file(credentialsId: "<project>-plan-creds-gsm", variable: 'INFRA_CREDS')]){
                                sh '''
                                    gsutil cp $BUILD_NUMBER-testing-iamlist.csv gs://<bucket-name>/
                                    rm *-iamlist.csv
                                '''
                            }
                        }
                    }
                }
            }
        }
    }
}
