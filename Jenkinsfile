
node {
    checkout scm

    stage("Build Config") {
      sh '''
      ./bin/build.sh
      '''
    }


    if (env.BRANCH_NAME == "disabled") {
      stage("Publish using curl") {
        sh '''#!/bin/bash +x
          . /mnt/secrets/bintray/bintray
          AWS_ACCESS_KEY=$(aws --profile armory-ps-prod configure get aws_access_key_id) \
          AWS_SECRET_KEY=$(aws --profile armory-ps-prod configure get aws_secret_access_key) \
          ./bin/push.sh
        '''
      }
    }

    // The debian filepath in Groovy is:
    // "build/distributions/armory-bootstrap_0.${env.BUILD_NUMBER}.0-h${env.BUILD_NUMBER}.${env.BRANCH_NAME}_all.deb"
    //
    // The package name found in the artifacts will be the key used to search the debian repository (bintray/s3)
    archiveArtifacts artifacts: 'build/*, build/distributions/*.deb, build/distributions/*.rpm', fingerprint: true
}
