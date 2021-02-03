def validateValidityOfApplicationName(String applicationName) {
  /* This method can be used to validate if the name of an application is valid for CloudHub deployment. */
  /* See: https://help.mulesoft.com/s/article/CloudHub-Application-Name-is-Limited-to-42-Characters for more information. */
  
  // Restrictions for the name in regards to CloudHub deployments.
  MAX_APPNAME_LENGTH  = 42
  CANNOT_START_WITH   = 'internal-'
  CANNOT_END_WITH     = '-'
  // CAN_ONLY_CONTAIN    = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'
  CANNOT_CONTAIN      = '_'

  // Calculate the length of the incoming application name and log this in the build.
  currentNameLength = applicationName.length()
  echo "Length of the application name when entering the method: ${currentNameLength}"

  // Check if the application name is not too long.
  if (currentNameLength > MAX_APPNAME_LENGTH){
    /* This code block corrects the application name when it is too long. */
    echo "It has been detected that the application name is too long (with a length of: ${currentNameLength}) while CloudHub deployment only allows for names of max. ${MAX_APPNAME_LENGTH} characters."
    echo "Current application name: ${applicationName}"

    // Cut of a part from the end of the application name in order to shorten it enough for deployment on CloudHub.
    applicationName = applicationName.substring(0, 42)

    echo 'A correction has been applied, shortening the length of the application name.'
    echo "Current application name: ${applicationName}"
  }

  // Check if the application name does not contain prohibited characters.
  if (applicationName.contains(CANNOT_CONTAIN)){
    /* This code block corrects the application name when it contains 'illegal' characters. */
    echo "It has been detected that the application name contains '${CANNOT_CONTAIN}' which is forbidden."
    echo "Current application name: ${applicationName}"

    // Replace the underscores with dashed because underscores are not allowed to be part of an application name on CloudHub.
    applicationName = applicationName.replaceAll(CANNOT_CONTAIN, '-')

    echo 'A correction has been applied, replacing the disallowed characters in the application name.'
    echo "Current application name: ${applicationName}"
  }

  // Check if the application name does not start with prohibited characters.
  if (applicationName.toLowerCase().startsWith(CANNOT_START_WITH)){
    /* This code block corrects the application name when it starts with 'illegal' characters. */
    echo "It has been detected that the application name starts with '${CANNOT_START_WITH}' which is forbidden."
    echo "Current application name: ${applicationName}"

    // Cut of the "internal-" prefix because that is not allowed to be the start of an application name on CloudHub.
    applicationName = applicationName.substring(9)

    echo 'A correction has been applied, removing the disallowed prefix from the application name.'
    echo "Current application name: ${applicationName}"
  }

  // Check if the application name does not end with prohibited characters.
  if (applicationName.endsWith(CANNOT_END_WITH)){
    /* This code block corrects the application name when it ends with 'illegal' characters. */
    echo "It has been detected that the application name ends with a '${CANNOT_END_WITH}' this is forbidden."
    echo "Current application name: ${applicationName}"

    // Cut of the last character because that will be the dash which is not allowed to be the end of an application name on CloudHub.
    applicationName = applicationName.substring(0, applicationName.length())

    echo 'A correction has been applied, removing the dash from the end of the application name.'
    echo "Current application name: ${applicationName}"
  }

  // Set the value to be returned.
  validName = applicationName

  // Return the value to the caller.
  return validName
}

def obtainCommitterMail(){
  // Obtain e-mailaddress of the latest Committer.
  committerMail = sh(
    script: "git --no-pager show -s --format='%ae'", returnStdout: true).trim()
  echo "E-mailaddress of the latest committer: ${committerMail}."

  return committerMail
}

def obtainGITVersion(){
  // Version of GIT.
  gitVersion = sh(
    script: "git --version", returnStdout: true).trim()
  echo "Version of GIT in use: ${gitVersion}."
  
  return gitVersion
}

/* def obtainArtifactID(){
  // Obtain App Name from POM.
  artifactID = sh script: 'mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout', returnStdout: true
  echo "ArtifactID read from POM: ${artifactID}."

  return artifactID
} */

def obtainEncryptionKeyCredentialsID(){
  // Construct CredentialsID to get the Encryption Key.
  encryptionKeyCredentialsID = ENVIRONMENT + '_' + ARTIFACT_ID
  echo "Value of the credentialsID: ${encryptionKeyCredentialsID}"

  return encryptionKeyCredentialsID
}

def obtainCommitterName(){
  // Obtain name of the latest Committer.
  committerName = sh(
    script: "git show -s --pretty='%an'", returnStdout: true).trim()
  echo "Name of the latest committer: ${committerName}."

  return committerName
}

def determineDeploymentEnvironments(){
  script{
    // Set last stage in case of failure.
    LAST_STAGE = 'Prepare Variables'

    echo 'Setting up Mule deployment environments.'
    
    // Setting up deployment environments.
    if (binding.hasVariable('MULE_PRD')) {
      echo 'Mule Production environment is present.'
      deploymentEnvironments = [MULE_TST, MULE_ACC, MULE_PRD]
    } else{
      echo 'Mule Production environment is absent.'
      deploymentEnvironments = [MULE_TST, MULE_ACC]
    }
    echo "The possible environments to deploy to are: ${deploymentEnvironments}."
  }

  return deploymentEnvironments
}

def readCloudHubVerificationSkips(){
  // Determine whether the verification of the deployment towards TST should be skipped.
  if (SkipCloudHubDeploymentVerification.contains("Skip TST Verification")){
    env.Skip_Verification_Of_TST_Deployment = true
  } else {
    env.Skip_Verification_Of_TST_Deployment = false
  }

  // Determine whether the verification of the deployment towards QA should be skipped.
  if (SkipCloudHubDeploymentVerification.contains("Skip QA Verification")){
    env.Skip_Verification_Of_QA_Deployment = true
  } else {
    env.Skip_Verification_Of_QA_Deployment = false
  }

  // Determine whether the verification of the deployment towards PRD should be skipped.
  if (SkipCloudHubDeploymentVerification.contains("Skip PRD Verification")){
    env.Skip_Verification_Of_PRD_Deployment = true
  } else {
    env.Skip_Verification_Of_PRD_Deployment = false
  }
}

/* def obtainAppVersion(){
  // Get App Version from POM.
  appVersion = sh script: 'mvn help:evaluate -Dexpression=project.version -q -DforceStdout', returnStdout: true
  echo "App version read from POM: ${appVersion}."

  return appVersion
} */

/* def obtainAppName(){
  // Get App Name from POM.
  appName = sh script: 'mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout', returnStdout: true
  echo "App name read from POM: ${appName}."

  return appName
} */

def updateCredentialsID(){
  echo "Value of the ENVIRONMENT: ${ENVIRONMENT}"
  
  credentialsID = ENVIRONMENT + '_' + ARTIFACT_ID
  echo "Value of the credentialsID: ${credentialsID}"
  
  // echo "Temporarily hardcoding credentialsID to 'QA_customers-pl-ms_Multibranch-pipeline_Test'."

  return credentialsID
}

def echoStringValueToSet(String input){
  echo "The input which will be used as output is: ${input}"
  return input
}

def determineDisplayName(String applicationVersion){
  // Based on the selection of the "Create_Release" checkbox, return the type of build.
  // if(params.Create_Release == true)
  if(params.Create_Release == 'Creating Release/Final Version')
  {
    applicationVersion = "Release Build: ${applicationVersion}"
  } else {
    applicationVersion = "Development Build: ${applicationVersion}"
  }

  return applicationVersion
}

def stringToLowerCase(String inputString){
  // Use Groovy Method to transform the input to lowercase.
  lowercaseString = inputString.toLowerCase()

  return lowercaseString
}

// Note here which Jenkins Plugins are required by this Jenkinsfile.
// 01: Config File Provider       // See: https://plugins.jenkins.io/config-file-provider/
// 02: Pipeline Maven Integration // See: https://plugins.jenkins.io/pipeline-maven/
// 03: Active Choices             // See: https://plugins.jenkins.io/uno-choice/
// 04: Credentials                // See: https://plugins.jenkins.io/credentials/
// 05: Credentials Binding        // See: https://plugins.jenkins.io/credentials-binding/
// 06: Warnings Next Generation   // See: https://plugins.jenkins.io/warnings-ng/   ??? The run speaks of the Task Scanner Plugin, that is deprecated and replaced by this.
// 07: JUnit Attachments          // See: https://plugins.jenkins.io/junit-attachments/
// 08: Pipeline: Stage View       // See: https://plugins.jenkins.io/pipeline-stage-view/
// 09: Parameter Separator        // See: https://plugins.jenkins.io/parameter-separator/

pipeline {
  // Determines on which agents the Build/Deploy can be executed ("any" == All possible agents).
  agent any

  // Load the Maven installation of Jenkins.
  // See: https://www.jenkins.io/doc/book/pipeline/syntax/#tools
  tools {
    maven "${MAVEN_VERSION}"
  }

  environment {
    // Set client-specific variables here.

    // Credentials
    /* These credentials are obtained from the Jenkins Credentials by name ("id" in Jenkins Credential manager). */
    //DEPLOY_CREDS = credentials('anypoint-playground-SA') // GLO Playground Anypoint Credentials
    DEPLOY_CREDS = credentials('Swiss-Sense_Anypoint_CICD_Credentials') // Swiss Sense Anypoint Credentials
    GIT_CREDS = credentials('root-gms-ipvl-jkn001') // GLO BitBucket Cloud Credentials (uses an SSH Key)
    GIT_CREDS_ID = 'root-gms-ipvl-jkn001'
    NEXUS = credentials('nx-deployer') // Nexus Credentials
    // NEXUS = credentials('nexus-admin') // Nexus Credentials

    // Maven variables
    MAVEN_VERSION =                 'Apache-Maven-3.6.3' // The ID/Name of the Maven Version as it known or set in Jenkins.
    MAVEN_GLOBAL_SETTINGS_CONFIG =  'Swiss-Sense_Maven-Global-Settings' // The ID/Name of the Maven Global Settings config file as it known or set in Jenkins.
    MAVEN_USER_SETTINGS_CONFIG =    'Swiss-Sense_Maven-User-Settings' // The ID/Name of the Maven User Settings config file as it known or set in Jenkins.
    // globalMavenSettingsConfig:  "f3e35f14-a552-415d-9593-328dbce86120",
    // mavenSettingsConfig:        "Swiss-Sense_Maven-User-Settings"
    
    // Environments
    MULE_TST = 'TST'
    MULE_ACC = 'QA'
    //MULE_PRD = 'PRD'
    
    // Logging variables
    // LOG4J_URL = 'https://repo.glomidco.com/repository/SwS_files/log4j2-sws-v4.xml' // Needs to be changed to the new logging implementation from its own repository in GIT.
    LOG4J2_REPO = 'git@bitbucket.org:glosws/logging.git'

    // Nexus variables
    NEXUS_URL = 'repo.glomidco.com' // Hostname of the Nexus repository.

    // E-Mail variables
    EMAIL_FROM = 'build@glo-integration.com' // The e-mail address from which the result/report will be send.

    // JUnit variables
    JUNIT_FILE = 'test-report.xml'

    // Source Control variables
    FEATURE_BRANCH_PREFIX = 'feature/'
    BUGFIX_BRANCH_PREFIX  = 'bugfix/'
    HOTFIX_BRANCH_PREFIX  = 'hotfix/'
    RELEASE_BRANCH_PREFIX = 'release/'

    // Declaring environment variables for later use.
    APP_NAME              = '' // Holds the Application Name from the POM file.
    APP_VERSION           = '' // Holds the Application Version
    LAST_STAGE            = '' // Holds the last Pipeline Stage started during the execution
    ERROR_MESSAGE         = '' // Holds the message which accompanies an error if one occurs.
    ARTIFACT_ID           = '' // Holds the ArtifactID from the POM file.

    // Committer variables
    COMMITTER_NAME = obtainCommitterName()  // Holds the Name of the latest committer.
    COMMITTER_MAIL = obtainCommitterMail()  // Holds the E-mailaddress of the latest committer.

    // GIT variables
    GIT_VERSION    = obtainGITVersion()     // Holds the version of GIT which is used.
    
    /* ARTIFACT_ID    = obtainArtifactID()     // Holds the ArtifactID from the POM file.
    APP_NAME       = obtainAppName()        // Holds the Application Name from the POM file.
    APP_VERSION    = obtainAppVersion()     // Holds the Application Version from the POM file. */
  }

  options {
    // Disables concurrent runs of this (specific) pipeline.
    disableConcurrentBuilds()
    
    // Ensures that the Log lines of the actual Build/Deploy are prefixed with a timestamp.
    timestamps()

    // The amount of old builds (logs and artifacts) to keep.
    // For more information see: https://stackoverflow.com/questions/39542485/how-to-write-pipeline-to-discard-old-builds/44155346
    buildDiscarder(logRotator(numToKeepStr: '25', artifactNumToKeepStr: '25')) // TODO: When finalizing it is advisable to set this value to 100.
  }
  
  stages {
    stage('Prepare Variables'){
      steps{
        script{
          // Set last stage to keep track of location in code in case of failure.
          LAST_STAGE = 'Prepare Variables'

          // Create an environment variable "DEPLOYMENT_ENVIRONMENTS".
          env.DEPLOYMENT_ENVIRONMENTS = ""

          echo 'Setting up Mule deployment environments.'
          
          // Setting up deployment environments.
          if (binding.hasVariable('MULE_PRD')) {
            echo 'Mule Production environment is present.'
            DEPLOYMENT_ENVIRONMENTS = "${MULE_TST}, ${MULE_ACC}, ${MULE_PRD}"
          } else{
            echo 'Mule Production environment is absent.'
            DEPLOYMENT_ENVIRONMENTS = "${MULE_TST}, ${MULE_ACC}"
          }

          // Log which environments can be deployed towards.
          echo "The possible environments to deploy to are: ${DEPLOYMENT_ENVIRONMENTS}."
        }
      }
    }

    // This will only be shown when a manual Build/Deploy is triggered.
    stage('Setup Parameters') {
      steps{
        script{
          // Set last stage to keep track of location in code in case of failure.
          LAST_STAGE = 'Setup Parameters'

          properties([
            // Defining the parameters to be used (upon manual Build/Deploy).
            parameters([
              // Creates a separator in the Parameters view to keep it more organised.
              separator(name: "MAIN_SETTINGS_SEPARATOR"),
              // Creates a drop-down box for selecting the environment to deploy to (and saves it to the "MuleEnvironment" variable).
              [$class: 'ChoiceParameter',
                choiceType: 'PT_SINGLE_SELECT',
                description: """Select the environment to deploy toward from the dropdown list.
                Remark: Selection here will affect whether a Release or Snapshot build will be created and deployed.
                Remark 2: The selection here is not used when building from a 'feature', 'bugfix', 'hotfix' or 'release' branch, those will respectively be forced to TST or QA only.""",
                name: 'MuleEnvironment',
                script:
                  [$class: 'GroovyScript',
                    fallbackScript:
                      [classpath: [],
                        sandbox: false,
                        script: "return ['Could not obtain the environments.']"
                      ],
                    script:
                      [classpath: [],
                        sandbox: true,
                        script: "return ['TST', 'QA', 'PRD:disabled']"
                      ]
                  ]
              ],
              // Creates a checkbox (based on the value of the "MuleEnvironment" variable) to indicate whether a Release build/deploy will occur.
              [$class: 'CascadeChoiceParameter',
                choiceType: 'PT_CHECKBOX',
                // description: 'This box will be checked when a new release from the /develop branch will be built/deployed.',
                description: """This box will be checked when a new release from the /develop branch will be built/deployed.
                Remark: This box is not representative when building from a 'feature', 'bugfix', 'hotfix' or 'release' branch, those will respectively be non-release or release.""",
                name: 'Create_Release',
                referencedParameters: 'MuleEnvironment',
                script:
                  [$class: 'GroovyScript',
                    fallbackScript:
                      [classpath: [],
                        sandbox: false,
                        script: "return ['Could not obtain required data.']"
                      ],
                    script:
                      [classpath: [],
                        sandbox: true,
                        script: """if (MuleEnvironment == 'TST'){
                            return ['Creating Release/Final Version:disabled']}
                          else if (MuleEnvironment == 'QA'){
                            return ['Creating Release/Final Version:selected:disabled']}
                          else if (MuleEnvironment == 'PRD'){
                            return ['Creating Release/Final Version:selected:disabled']}
                          else {
                            return ['Unknown Environment selection.']}"""
                      ]
                  ]
              ],
              // Creates a set of checkboxes (based on the value of the "MuleEnvironment" variable) for optionally skipping the verification of CloudHub deployments and thus speeding up the complete Build/Deploy action.
              [$class: 'CascadeChoiceParameter',
                choiceType: 'PT_CHECKBOX',
                description: 'Select the CloudHub environments for which the verification of the deployment should not be awaited.',
                name: 'SkipCloudHubDeploymentVerification',
                referencedParameters: 'MuleEnvironment',
                script:
                  [$class: 'GroovyScript',
                    fallbackScript:
                      [classpath: [],
                        sandbox: false,
                        script: "return ['Could not obtain required data.']"
                      ],
                    script:
                      [classpath: [],
                        sandbox: true,
                        script: """if (MuleEnvironment == 'TST'){
                            return ['Skip TST Verification', 'Skip QA Verification:disabled', 'Skip PRD Verification:disabled']}
                          else if (MuleEnvironment == 'QA'){
                            return ['Skip TST Verification:selected:disabled', 'Skip QA Verification', 'Skip PRD Verification:disabled']}
                          else if (MuleEnvironment == 'PRD'){
                            return ['Skip TST Verification:selected:disabled', 'Skip QA Verification:selected', 'Skip PRD Verification']}
                          else {
                            return ['Unknown Environment selection.']}"""
                      ]
                  ]
              ],
              // Creates a separator in the Parameters view to keep it more organised.
              separator(name: "ADVANCED_SETTINGS_SEPARATOR"),
              choice(
                name: 'EnableDebugLogging',
                choices: ['None', 'DeploymentsOnly', 'BuildOnly', 'FullExtensive'],
                // description: 'Select if any debug logging should be used during the build and/or deploy stages. Remark: The FullExtensive mode logs very much and results in slow completion.'
                description: """Select if any debug logging should be used during the build and/or deploy stages.
                Remark: The 'DeploymentsOnly' and 'FullExtensive' modes log very much and result in slow completion."""
              ),
              choice(
                name: 'SkipNewmanTests',
                choices: ['No, run tests', 'Yes, skip tests'],
                description: 'Choose whether to skip the execution of the NewmanTests.'
              ),
              // Creates a separator in the Parameters view to keep it more organised.
              separator(name: "CLOUDHUB_SETTINGS_SEPARATOR"),
              /* // CloudHub Worker(s) settings, see: https://docs.mulesoft.com/mule-runtime/4.3/deploy-to-cloudhub for more information. */
              // Several options have been disabled to prevent accidental setting undesired values.
              // Creates a drop-down box for selecting the amount of CloudHub Worker(s) to use for this application.
              [$class: 'ChoiceParameter',
                choiceType: 'PT_SINGLE_SELECT',
                description: 'Select the amount of CloudHub worker(s) for deployment of the application from the dropdown list.',
                name: 'AmountOfCloudHubWorkers',
                script:
                  [$class: 'GroovyScript',
                    fallbackScript:
                      [classpath: [],
                        sandbox: false,
                        script: "return ['Could not obtain the possible amounts of workers.']"
                      ],
                    script:
                      [classpath: [],
                        sandbox: true,
                        // script: "return ['1:selected', '2', '3', '4', '5', '6', '7', '8']"
                        script: "return ['1:selected', '2', '3:disabled', '4:disabled', '5:disabled', '6:disabled', '7:disabled', '8:disabled']"
                      ]
                  ]
              ],
              // Creates a drop-down box for selecting the type/size of the CloudHub Worker(s) to use for this application.
              // Remark: The type/size selected here is applied to ALL workers (selected in the amount above).
              [$class: 'ChoiceParameter',
                choiceType: 'PT_SINGLE_SELECT',
                description: """Select the type (and thus size) of the worker(s) from the dropdown list.
                Remark: The type/size selected here is applied to ALL workers (selected in the amount above).""",
                name: 'TypeOfCloudHubWorkers',
                script:
                  [$class: 'GroovyScript',
                    fallbackScript:
                      [classpath: [],
                        sandbox: false,
                        script: "return ['Could not obtain the possible types of workers.']"
                      ],
                    script:
                      [classpath: [],
                        sandbox: true,
                        // script: "return ['MICRO:selected', 'SMALL', 'MEDIUM', 'LARGE', 'XLARGE', 'XXLARGE', '4XLARGE']"
                        script: "return ['MICRO:selected', 'SMALL', 'MEDIUM:disabled', 'LARGE:disabled', 'XLARGE:disabled', 'XXLARGE:disabled', '4XLARGE:disabled']"
                      ]
                  ]
              ],
              // Creates a drop-down box for selecting the region of the CloudHub Worker(s) to use for this application.
              // Remark: The region selected here is applied to ALL workers (selected in the amount above).
              [$class: 'ChoiceParameter',
                choiceType: 'PT_SINGLE_SELECT',
                description: """Select the region where to deploy the application from the dropdown list.
                Remark: The region selected here is applied to ALL workers (selected in the amount above).""",
                name: 'RegionOfCloudHubWorkers',
                script:
                  [$class: 'GroovyScript',
                    fallbackScript:
                      [classpath: [],
                        sandbox: false,
                        script: "return ['Could not obtain the possible regions for workers.']"
                      ],
                    script:
                      [classpath: [],
                        sandbox: true,
                        // script: "return ['us-east-1', 'us-east-2', 'us-west-1', 'us-west-2', 'us-gov-west-1', 'eu-central-1:selected', 'eu-west-1', 'eu-west-2', 'ap-southeast-1', 'ap-southeast-2', 'ap-northeast-1', 'ca-central-1', 'sa-east-1']"
                        script: "return ['us-east-1:disabled', 'us-east-2:disabled', 'us-west-1:disabled', 'us-west-2:disabled', 'us-gov-west-1:disabled', 'eu-central-1:selected', 'eu-west-1', 'eu-west-2', 'ap-southeast-1:disabled', 'ap-southeast-2:disabled', 'ap-northeast-1:disabled', 'ca-central-1:disabled', 'sa-east-1:disabled']"
                      ]
                  ]
              ],
              // Creates a separator in the Parameters view to keep it more organised.
              // Current CloudHub Deployment selection:
              separator(name: "BUILD_OVERVIEW_SEPARATOR", sectionHeader: "Current CloudHub Deployment selection:"),
              [$class: 'DynamicReferenceParameter', 
                choiceType: 'ET_FORMATTED_HTML', 
                description: 'Overview of the CloudHub Deployment settings.',
                name: '',
                referencedParameters: 'Create_Release, AmountOfCloudHubWorkers, TypeOfCloudHubWorkers, RegionOfCloudHubWorkers',
                script:
                  [$class: 'GroovyScript',
                    fallbackScript:
                      [classpath: [],
                        sandbox: false,
                        script: 'return "<b>Could not obtain all settings for the CloudHub Deployment.</b>"'
                      ],
                    script:
                      [classpath: [],
                        sandbox: true,
                        script: '''
                          release=\'\'
                          amount=\'\'
                          size=\'\'
                          region=\'\'
                          if(Create_Release == "Creating Release/Final Version") {
                            release=\'A Release/Final version will be created.\'
                          } else {
                            release=\'A Release/Final version will <i>NOT</i> be created.\'
                          }
                          switch(AmountOfCloudHubWorkers) {
                            case ~/.*1.*/:
                              amount=\'1 CloudHub worker selected.\'
                              break;
                            case ~/.*2.*/:
                              amount=\'2 CloudHub workers selected.\'
                              break;
                            case ~/.*3.*/:
                              amount=\'3 CloudHub workers selected.\'
                              break;
                            case ~/.*4.*/:
                              amount=\'4 CloudHub workers selected.\'
                              break;
                            case ~/.*5.*/:
                              amount=\'5 CloudHub workers selected.\'
                              break;
                            case ~/.*6.*/:
                              amount=\'6 CloudHub workers selected.\'
                              break;
                            case ~/.*7.*/:
                              amount=\'7 CloudHub workers selected.\'
                              break;
                            case ~/.*8.*/:
                              amount=\'8 CloudHub workers selected.\'
                              break;
                            default:
                              amount=\'The default value of 1 CloudHub worker is used.\'
                          }
                          switch(TypeOfCloudHubWorkers) {
                            case ~/.*MICRO.*/:
                              size="A ${TypeOfCloudHubWorkers} worker of 0.1 vCore will be used."
                              break;
                            case ~/.*SMALL.*/:
                              size="A ${TypeOfCloudHubWorkers} worker of 0.2 vCore will be used."
                              break;
                            case ~/.*MEDIUM.*/:
                              size="A ${TypeOfCloudHubWorkers} worker of 1 vCore will be used."
                              break;
                            case ~/.*LARGE.*/:
                              size="A ${TypeOfCloudHubWorkers} worker of 2 vCores will be used."
                              break;
                            case ~/.*XLARGE.*/:
                              size="A ${TypeOfCloudHubWorkers} worker of 4 vCores will be used."
                              break;
                            case ~/.*XXLARGE.*/:
                              size="A ${TypeOfCloudHubWorkers} worker of 8 vCores will be used."
                              break;
                            case ~/.*4XLARGE.*/:
                              size="A ${TypeOfCloudHubWorkers} worker of 16 vCores will be used."
                              break;
                            default:
                              size=\'The default value of a MICRO CloudHub worker of 0.1 vCore is used.\'
                          }
                          switch(RegionOfCloudHubWorkers) {
                            case ~/.*us-east-1.*/:
                              region="The CloudHub worker(s) will be deployed in \'US East, N. Virginia\'."
                              break;
                            case ~/.*us-east-2.*/:
                              region="The CloudHub worker(s) will be deployed in \'US East, Ohio\'."
                              break;
                            case ~/.*us-west-1.*/:
                              region="The CloudHub worker(s) will be deployed in \'US West, N. California\'."
                              break;
                            case ~/.*us-west-2.*/:
                              region="The CloudHub worker(s) will be deployed in \'US West, Oregon\'."
                              break;
                            case ~/.*us-gov-west-1.*/:
                              region="The CloudHub worker(s) will be deployed in \'MuleSoft Government Cloud\'."
                              break;
                            case ~/.*eu-central-1.*/:
                              region="The CloudHub worker(s) will be deployed in \'EU, Frankfurt\'."
                              break;
                            case ~/.*eu-west-1.*/:
                              region="The CloudHub worker(s) will be deployed in \'EU, Ireland\'."
                              break;
                            case ~/.*eu-west-2.*/:
                              region="The CloudHub worker(s) will be deployed in \'EU, London\'."
                              break;
                            case ~/.*ap-southeast-1.*/:
                              region="The CloudHub worker(s) will be deployed in \'Asia Pacific, Singapore\'."
                              break;
                            case ~/.*ap-southeast-2.*/:
                              region="The CloudHub worker(s) will be deployed in \'Asia Pacific, Sydney\'."
                              break;
                            case ~/.*ap-northeast-1.*/:
                              region="The CloudHub worker(s) will be deployed in \'Asia Pacific, Tokyo\'."
                              break;
                            case ~/.*ca-central-1.*/:
                              region="The CloudHub worker(s) will be deployed in \'Canada, Central\'."
                              break;
                            case ~/.*sa-east-1.*/:
                              region="The CloudHub worker(s) will be deployed in \'South America, São Paulo\'."
                              break;
                            default:
                              region="The default value of \'EU, Frankfurt\' is used."
                          }
                          return "<b>Release/Final version: ${release}</b><p><b>Amount of workers: ${amount}</b><p><b>Type/Size of the workers: ${size}</b><p><b>Region of the workers: ${region}</b>"'''
                      ]
                  ]
              ]
            ])
          ])
        }
      }
    }

    stage('Set Variables') {
      steps {
        script {
          // Set last stage to keep track of location in code in case of failure.
          LAST_STAGE = 'Set Variables'

          // Set the ENVIRONMENT variable here for the first time to create it (and keep it mutable).
          env.ENVIRONMENT = '' // Holds the actual environment which will be deployed onto.

          echo "Value of 'Create_Release' is: ${Create_Release}" // Running the initial build/run breaks here because the value is not available.

          // Get Version from POM.
          APP_VERSION = sh script: 'mvn help:evaluate -Dexpression=project.version -q -DforceStdout', returnStdout: true
          echo "App version read from POM: ${APP_VERSION}."

          // Get App Name from POM.
          APP_NAME = sh script: 'mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout', returnStdout: true
          echo "App name read from POM: ${APP_NAME}."

          // Get ArtifactID from POM.
          ARTIFACT_ID = sh script: 'mvn help:evaluate -Dexpression=project.artifactId -q -DforceStdout', returnStdout: true
          echo "ArtifactID read from POM: ${ARTIFACT_ID}."

          // Set Environment to deploy to based on branch.
          if (BRANCH_NAME == 'develop') {
            ENVIRONMENT = MuleEnvironment
            echo "Environment which will be used is: ${ENVIRONMENT}, now creating APP_NAME."
            APP_NAME = ENVIRONMENT + '-' + APP_NAME
          }
          else if (BRANCH_NAME.startsWith("${FEATURE_BRANCH_PREFIX}")) {
            ENVIRONMENT = MULE_TST
            env.Skip_Verification_Of_TST_Deployment = false
            APP_NAME = ENVIRONMENT + '-' + APP_NAME
            APP_VERSION = APP_VERSION + '+' + FEATURE_BRANCH_PREFIX.replaceAll('/', '-') + (BRANCH_NAME - "${FEATURE_BRANCH_PREFIX}")
          }
          else if (BRANCH_NAME.startsWith("${BUGFIX_BRANCH_PREFIX}")) {
            ENVIRONMENT = MULE_TST
            env.Skip_Verification_Of_TST_Deployment = false
            APP_NAME = ENVIRONMENT + '-' + APP_NAME
            APP_VERSION = APP_VERSION + '+' + BUGFIX_BRANCH_PREFIX.replaceAll('/', '-') + (BRANCH_NAME - "${BUGFIX_BRANCH_PREFIX}")
          }
          else if (BRANCH_NAME.startsWith("${HOTFIX_BRANCH_PREFIX}")) {
            ENVIRONMENT = MULE_ACC
            // Assign a TST specific flag because a build from the Release branch will use the 'normal' "Deploy" step to be deployed to QA.
            env.Skip_Verification_Of_TST_Deployment = false
            APP_NAME = ENVIRONMENT + '-' + APP_NAME
            APP_VERSION = APP_VERSION + '+' + HOTFIX_BRANCH_PREFIX.replaceAll('/', '-') + (BRANCH_NAME - "${HOTFIX_BRANCH_PREFIX}")
          }
          else if (BRANCH_NAME.startsWith("${RELEASE_BRANCH_PREFIX}")) {
            ENVIRONMENT = MULE_ACC
            // Assign a TST specific flag because a build from the Release branch will use the 'normal' "Deploy" step to be deployed to QA.
            env.Skip_Verification_Of_TST_Deployment = false
            APP_NAME = ENVIRONMENT + '-' + APP_NAME
            APP_VERSION = APP_VERSION + '+' + RELEASE_BRANCH_PREFIX.replaceAll('/', '-') + (BRANCH_NAME - "${RELEASE_BRANCH_PREFIX}")
          }
          else {
            echo 'No valid branch used, aborting build!'
            currentBuild.result = 'ABORTED'
            error('Stopping execution of the build early due to an incorrect SCM branch being used.')
          }

          echo "Updated app name to: ${APP_NAME}"

          // Check validity of the application name.
          echo "Validating the application name against rules for CloudHub deployment."
          APP_NAME = validateValidityOfApplicationName(APP_NAME)

          echo "Resulting app name (after validation) to: ${APP_NAME}"

          /* Mule 4 uses Semantic Versioning v2.0.0; See: https://semver.org/ */
          // Overwrite Jenkins' build number with the version of the app for display in Jenkins.
          currentBuild.displayName = determineDisplayName(APP_VERSION)

          // Call a method to handle the settings of verification skips for the various environments.
          readCloudHubVerificationSkips()

          // Display for which environments the deployment verification will be skipped.
          echo "Skip TST verification?: ${Skip_Verification_Of_TST_Deployment}"
          echo "Skip QA verification?: ${Skip_Verification_Of_QA_Deployment}"
          echo "Skip PRD verification?: ${Skip_Verification_Of_PRD_Deployment}"

          //ENCRYPTION_KEY
          env.credentialsID = ENVIRONMENT + '_' + ARTIFACT_ID
          echo "Value of the credentialsID: ${credentialsID}"
          
          // Set the ENCRYPTION_KEY variable here for the first time to create it (and keep it mutable).
          env.ENCRYPTION_KEY = credentialsID // Holds the encryption key of the application.

          // Save the lowercase value of the "ENVIRONMENT" variable into the Global 'muleEnv' variable.
          env.muleEnv = stringToLowerCase(ENVIRONMENT)

          env.APCLIENTCREDENTIALS = ENVIRONMENT

          // Display the CloudHub deployment settings.
          echo "The 'muleenv' value that will be used: ${muleEnv}"
          echo "The amount of CloudHub workers which will be used: ${AmountOfCloudHubWorkers}"
          echo "The type of CloudHub workers which will be used: ${TypeOfCloudHubWorkers}"
          echo "The region of CloudHub workers which will be used: ${RegionOfCloudHubWorkers}"
        }
      }
    }

    stage('Build') {
      when {
        anyOf {
          expression { params.EnableDebugLogging == 'None' }
          expression { params.EnableDebugLogging == 'DeploymentsOnly' }
        }
      }
      steps {
        // Set last stage in case of failure.
        script {
          LAST_STAGE = 'Build'
        }

        // Use the correct/set Maven version/installation with the given Global- and User Settings.
        withMaven(
          maven:                      "${MAVEN_VERSION}",
          // globalMavenSettingsConfig:  "f3e35f14-a552-415d-9593-328dbce86120",
          // mavenSettingsConfig:        "Swiss-Sense_Maven-User-Settings"
          globalMavenSettingsConfig:  "${MAVEN_GLOBAL_SETTINGS_CONFIG}",
          mavenSettingsConfig:        "${MAVEN_USER_SETTINGS_CONFIG}"
          //MAVEN_GLOBAL_SETTINGS_CONFIG
          //MAVEN_USER_SETTINGS_CONFIG
        ){
          // Call out the Maven version to give the "withMaven" step a body (which is required).
          sh 'mvn -version'
          echo 'Maven initialized in the "Build" stage.'

          // Perhaps here also the Log4J2 file from GIT needs to be injected.
          echo "Building ${APP_NAME} version ${APP_VERSION} from branch ${BRANCH_NAME}."
          sh """mvn versions:set -DnewVersion='${APP_VERSION}'"""
          //sh 'wget ${LOG4J_URL} -O ${WORKSPACE}/src/main/resources/log4j2.xml'
          sh 'mvn -U -e -V clean -DskipTests package'
        }
      }
    }

    stage('BuildWithDebugLogging') {
      when {
        anyOf {
          expression { params.EnableDebugLogging == 'BuildOnly' }
          expression { params.EnableDebugLogging == 'FullExtensive' }
        }
      }
      steps {
        // Set last stage in case of failure.
        script {
          LAST_STAGE = 'BuildWithDebugLogging'
        }

        // Use the correct/set Maven version/installation with the given Global- and User Settings.
        withMaven(
          maven:                      "${MAVEN_VERSION}",
          // globalMavenSettingsConfig:  "f3e35f14-a552-415d-9593-328dbce86120",
          // mavenSettingsConfig:        "Swiss-Sense_Maven-User-Settings"
          globalMavenSettingsConfig:  "${MAVEN_GLOBAL_SETTINGS_CONFIG}",
          mavenSettingsConfig:        "${MAVEN_USER_SETTINGS_CONFIG}"
        ){
          // Call out the Maven version to give the "withMaven" step a body (which is required).
          sh 'mvn -version'
          echo 'Maven initialized in the "BuildWithDebugLogging" stage.'

          // Perhaps here also the Log4J2 file from GIT needs to be injected.
          echo "Building ${APP_NAME} version ${APP_VERSION} from branch ${BRANCH_NAME}."
          sh """mvn versions:set -DnewVersion='${APP_VERSION}'"""
          //sh 'wget ${LOG4J_URL} -O ${WORKSPACE}/src/main/resources/log4j2.xml'
          sh 'mvn -U -e -V -X clean -DskipTests package'
        }
      }
    }

    stage('Unit Tests') {
      steps {
        // Set last stage in case of failure.
        script {
          LAST_STAGE = 'Unit Tests'
        }

        // Use the correct/set Maven version/installation with the given Global- and User Settings.
        withMaven(
          maven:                      "${MAVEN_VERSION}",
          // globalMavenSettingsConfig:  "f3e35f14-a552-415d-9593-328dbce86120",
          // mavenSettingsConfig:        "Swiss-Sense_Maven-User-Settings"
          globalMavenSettingsConfig:  "${MAVEN_GLOBAL_SETTINGS_CONFIG}",
          mavenSettingsConfig:        "${MAVEN_USER_SETTINGS_CONFIG}"
        ){
          // Call out the Maven version to give the "withMaven" step a body (which is required).
          sh 'mvn -version'
          echo 'Maven initialized in the "Unit Tests" stage.'

          echo 'Starting unit tests'
          sh 'mvn test'

          echo "Encryption Key: ${ENCRYPTION_KEY} and CredentialsID: ${credentialsID}"
        }
      }
    }

    stage('Deploy') {
      when {
        anyOf {
          branch 'develop'
          branch ("${FEATURE_BRANCH_PREFIX}*")
          branch ("${BUGFIX_BRANCH_PREFIX}*")
          branch ("${HOTFIX_BRANCH_PREFIX}*")
          branch ("${RELEASE_BRANCH_PREFIX}*")
        }
        allOf {
          expression { params.EnableDebugLogging == 'None' }
          anyOf{
            equals expected: '', actual: params.Create_Release
            equals expected: 'Could not obtain required data.', actual: params.Create_Release
          }
        }
      }
      environment{
        ENCRYPTION_KEY = credentials("${ENCRYPTION_KEY}")
        APCLIENTCREDENTIALS = credentials("${APCLIENTCREDENTIALS}")
      }
      steps {
        // Set last stage in case of failure.
        script {
          LAST_STAGE = 'Deploy'
        }

        echo "Deploying on ${ENVIRONMENT}."

        echo """The following information will be used:
        App Name:             ${APP_NAME},
        Cloudhub Environment: ${ENVIRONMENT}."""

        /* echo 'Using these Maven Settings: '
        sh '''mvn help:effective-settings''' */

        echo "Debug Logging setting: ${params.EnableDebugLogging}."

        sshagent(credentials: ["${GIT_CREDS_ID}"]){
          // Use the correct/set Maven version/installation with the given Global- and User Settings.
          withMaven(
            maven:                      "${MAVEN_VERSION}",
            // globalMavenSettingsConfig:  "f3e35f14-a552-415d-9593-328dbce86120",
            // mavenSettingsConfig:        "Swiss-Sense_Maven-User-Settings"
            globalMavenSettingsConfig:  "${MAVEN_GLOBAL_SETTINGS_CONFIG}",
            mavenSettingsConfig:        "${MAVEN_USER_SETTINGS_CONFIG}"
          ){
            // Call out an echo telling that Maven is loaded to give the "withMaven" step a body (which is required).
            echo 'Maven initialized in the "Deploy" stage.'

            // Fetch the file containing the logging settings from its own GIT repository.
            echo 'Obtaining the file containing the logging settings from GIT.'
            // sh("git archive --remote git@bitbucket.org:glosws/logging.git master log4j2.xml | tar x")
            // LOG4J2_REPO
            sh("git archive --remote ${LOG4J2_REPO} master log4j2.xml | tar x")
            
            // Inject the Log4J2 settings file into the current build.
            echo 'Injecting the file containing the logging settings into the current build.'
            sh "mv log4j2.xml ${WORKSPACE}/src/main/resources/log4j2.xml"

            /* sh "mvn -U -V -e\
            -DskipTests\
            clean\
            deploy\
            -Dusername='${DEPLOY_CREDS_USR}'\
            -Dpassword='${DEPLOY_CREDS_PSW}'\
            -Dmuleenv=${muleEnv}\
            -Dcloudhub.application.name='${APP_NAME}'\
            -Dchenv='${ENVIRONMENT}'\
            -DskipVerify='${Skip_Verification_Of_TST_Deployment}'\
            -Dworkertype='${TypeOfCloudHubWorkers}'\
            -Dworkers='${AmountOfCloudHubWorkers}'\
            -D'${ENCRYPTION_KEY_USR}'='${ENCRYPTION_KEY_PSW}'\
            -Denvclientid='${APCLIENTCREDENTIALS_USR}'\
            -Denvclientsecret='${APCLIENTCREDENTIALS_PSW}'\
            " */

            sh "mvn -U -V -e\
            -DskipTests\
            clean\
            deploy\
            -Dusername='${DEPLOY_CREDS_USR}'\
            -Dpassword='${DEPLOY_CREDS_PSW}'\
            -Dmuleenv=${muleEnv}\
            -Dcloudhub.application.name='${APP_NAME}'\
            -Dchenv='${ENVIRONMENT}'\
            -DskipVerify='${Skip_Verification_Of_TST_Deployment}'\
            -Dworkertype='${TypeOfCloudHubWorkers}'\
            -Dworkers='${AmountOfCloudHubWorkers}'\
            -Dworkerregion='${RegionOfCloudHubWorkers}'\
            -D'${ENCRYPTION_KEY_USR}'='${ENCRYPTION_KEY_PSW}'\
            -Denvclientid='${APCLIENTCREDENTIALS_USR}'\
            -Denvclientsecret='${APCLIENTCREDENTIALS_PSW}'\
            "

            // echo "The region of CloudHub workers which will be used: ${RegionOfCloudHubWorkers}"

            /* sh "mvn -U -V -e -B\
            -DskipTests\
            clean\
            deploy\
            -Dusername='${DEPLOY_CREDS_USR}'\
            -Dpassword='${DEPLOY_CREDS_PSW}'\
            -Dmuleenv=${muleEnv}\
            -Dcloudhub.application.name='${APP_NAME}'\
            -Dchenv='${ENVIRONMENT}'\
            -DskipVerify='true'\
            -Dworkertype='${TypeOfCloudHubWorkers}'\
            -Dworkers='${AmountOfCloudHubWorkers}'\
            -D'${ENCRYPTION_KEY_USR}'='${ENCRYPTION_KEY_PSW}'\
            -Denvclientid='${APCLIENTCREDENTIALS_USR}'\
            -Denvclientsecret='${APCLIENTCREDENTIALS_PSW}'\
            " */
          }
        }
      }
    }

    stage('DeployWithDebugLogging') {
      when {
        anyOf {
          branch 'develop'
          branch ("${FEATURE_BRANCH_PREFIX}*")
          branch ("${BUGFIX_BRANCH_PREFIX}*")
          branch ("${HOTFIX_BRANCH_PREFIX}*")
          branch ("${RELEASE_BRANCH_PREFIX}*")
        }
        anyOf {
          expression { params.EnableDebugLogging == 'DeploymentsOnly' }
          expression { params.EnableDebugLogging == 'FullExtensive' }
        }
      }
      environment{
        ENCRYPTION_KEY = credentials("${ENCRYPTION_KEY}")
        APCLIENTCREDENTIALS = credentials("${APCLIENTCREDENTIALS}")
      }
      steps {
        // Set last stage in case of failure.
        script {
          LAST_STAGE = 'DeployWithDebugLogging'
        }

        echo "Deploying on ${ENVIRONMENT}."
        echo """The following information will be used:
        App Name:             ${APP_NAME},
        Cloudhub Environment: ${ENVIRONMENT}."""

        echo "Debug Logging setting: ${params.EnableDebugLogging}."

        sshagent(credentials: ["${GIT_CREDS_ID}"]){
          // Use the correct/set Maven version/installation with the given Global- and User Settings.
          withMaven(
            maven:                      "${MAVEN_VERSION}",
            // globalMavenSettingsConfig:  "f3e35f14-a552-415d-9593-328dbce86120",
            // mavenSettingsConfig:        "Swiss-Sense_Maven-User-Settings"
            globalMavenSettingsConfig:  "${MAVEN_GLOBAL_SETTINGS_CONFIG}",
            mavenSettingsConfig:        "${MAVEN_USER_SETTINGS_CONFIG}"
          ){
            // Call out an echo telling that Maven is loaded to give the "withMaven" step a body (which is required).
            echo 'Maven initialized in the "DeployWithDebugLogging" stage.'

            // Fetch the file containing the logging settings from its own GIT repository.
            echo 'Obtaining the file containing the logging settings from GIT.'
            // sh("git archive --remote git@bitbucket.org:glosws/logging.git master log4j2.xml | tar x")
            sh("git archive --remote ${LOG4J2_REPO} master log4j2.xml | tar x")

            // Inject the Log4J2 settings file into the current build.
            echo 'Injecting the file containing the logging settings into the current build.'
            sh "mv log4j2.xml ${WORKSPACE}/src/main/resources/log4j2.xml"

            /* sh "mvn -U -V -e -X\
            -DskipTests\
            clean\
            deploy\
            -Dusername='${DEPLOY_CREDS_USR}'\
            -Dpassword='${DEPLOY_CREDS_PSW}'\
            -Dmuleenv=${muleEnv}\
            -Dcloudhub.application.name='${APP_NAME}'\
            -Dchenv='${ENVIRONMENT}'\
            -DskipVerify='${Skip_Verification_Of_TST_Deployment}'\
            -Dworkertype='${TypeOfCloudHubWorkers}'\
            -Dworkers='${AmountOfCloudHubWorkers}'\
            -D'${ENCRYPTION_KEY_USR}'='${ENCRYPTION_KEY_PSW}'\
            -Denvclientid='${APCLIENTCREDENTIALS_USR}'\
            -Denvclientsecret='${APCLIENTCREDENTIALS_PSW}'\
            " */

            sh "mvn -U -V -e -X\
            -DskipTests\
            clean\
            deploy\
            -Dusername='${DEPLOY_CREDS_USR}'\
            -Dpassword='${DEPLOY_CREDS_PSW}'\
            -Dmuleenv=${muleEnv}\
            -Dcloudhub.application.name='${APP_NAME}'\
            -Dchenv='${ENVIRONMENT}'\
            -DskipVerify='${Skip_Verification_Of_TST_Deployment}'\
            -Dworkertype='${TypeOfCloudHubWorkers}'\
            -Dworkers='${AmountOfCloudHubWorkers}'\
            -Dworkerregion='${RegionOfCloudHubWorkers}'\
            -D'${ENCRYPTION_KEY_USR}'='${ENCRYPTION_KEY_PSW}'\
            -Denvclientid='${APCLIENTCREDENTIALS_USR}'\
            -Denvclientsecret='${APCLIENTCREDENTIALS_PSW}'\
            "

            // -Dworkerregion='${RegionOfCloudHubWorkers}'\
          }
        }
      }
    }

    stage('Release') {
      when {
        allOf {
          branch 'develop'
          // equals expected: true,
          equals expected: 'Creating Release/Final Version', actual: params.Create_Release
        }
      }
      environment{
        // Load the "ENCRYPTION_KEY" variable with credentials containing the Encryption Key of the application in question for the current environment.
        ENCRYPTION_KEY = credentials("${ENCRYPTION_KEY}")

        // Load the "APCLIENTCREDENTIALS" variable with credentials containing the ClientID and ClientSecret of the environment in question.
        APCLIENTCREDENTIALS = credentials("${APCLIENTCREDENTIALS}")
      }
      steps {
        // Set last stage in case of failure.
        script {
          LAST_STAGE = 'Release'
        }

        echo 'Creating new release.'
        echo "This release should be deployed to QA, the environment it will be deployed to is: ${ENVIRONMENT}"
        
        // sshagent(credentials: ['root-gms-ipvl-jkn001'])
        sshagent(credentials: ["${GIT_CREDS_ID}"]){
          withMaven(
            // globalMavenSettingsConfig: 'f3e35f14-a552-415d-9593-328dbce86120', 
            maven: 'Apache-Maven-3.6.3', 
            // mavenSettingsConfig: 'Swiss-Sense_Maven-User-Settings'
            globalMavenSettingsConfig:  "${MAVEN_GLOBAL_SETTINGS_CONFIG}",
            mavenSettingsConfig:        "${MAVEN_USER_SETTINGS_CONFIG}"
            ){
            sh 'git checkout develop'
            sh 'mvn jgitflow:release-start'
            sh 'git status'

            // Fetch the file containing the logging settings from its own GIT repository.
            echo 'Obtaining the file containing the logging settings from GIT.'
            // sh("git archive --remote git@bitbucket.org:glosws/logging.git master log4j2.xml | tar x")
            sh("git archive --remote ${LOG4J2_REPO} master log4j2.xml | tar x")
            
            // Inject the Log4J2 settings file into the current build.
            echo 'Injecting the file containing the logging settings into the current build.'
            sh "mv log4j2.xml ${WORKSPACE}/src/main/resources/log4j2.xml"

            echo "Ensure that the Log4J2 configuration doesn't prevent a successful build."
            sh "git update-index --assume-unchanged ${WORKSPACE}/src/main/resources/log4j2.xml"
            sh 'git reset HEAD log4j2.xml'
            sh 'git status'

            echo 'Deploying build artifact to Nexus.'
            
            /* sh "mvn clean\
            jgitflow:release-finish\
            -Dusername='${DEPLOY_CREDS_USR}'\
            -Dpassword='${DEPLOY_CREDS_PSW}'\
            -Dmuleenv=${muleEnv}\
            -Dcloudhub.application.name='${APP_NAME}'\
            -Dchenv='${ENVIRONMENT}'\
            -DskipVerify='${Skip_Verification_Of_QA_Deployment}'\
            -Dworkertype='${TypeOfCloudHubWorkers}'\
            -Dworkers='${AmountOfCloudHubWorkers}'\
            -D'${ENCRYPTION_KEY_USR}'='${ENCRYPTION_KEY_PSW}'\
            -Denvclientid='${APCLIENTCREDENTIALS_USR}'\
            -Denvclientsecret='${APCLIENTCREDENTIALS_PSW}'\
            " */

            sh "mvn clean\
            jgitflow:release-finish\
            -Dusername='${DEPLOY_CREDS_USR}'\
            -Dpassword='${DEPLOY_CREDS_PSW}'\
            -Dmuleenv=${muleEnv}\
            -Dcloudhub.application.name='${APP_NAME}'\
            -Dchenv='${ENVIRONMENT}'\
            -DskipVerify='${Skip_Verification_Of_QA_Deployment}'\
            -Dworkertype='${TypeOfCloudHubWorkers}'\
            -Dworkers='${AmountOfCloudHubWorkers}'\
            -Dworkerregion='${RegionOfCloudHubWorkers}'\
            -D'${ENCRYPTION_KEY_USR}'='${ENCRYPTION_KEY_PSW}'\
            -Denvclientid='${APCLIENTCREDENTIALS_USR}'\
            -Denvclientsecret='${APCLIENTCREDENTIALS_PSW}'\
            "

            // -Dworkerregion='${RegionOfCloudHubWorkers}'\
          }
        }
      }
    }

    // Needs to get an option to be skipped,
    // as well as being skipped when there are no Postman tests for the application/repository in question.
    stage('Newman Tests') {
      when {
        not {
          branch 'master'
        }
        allOf {
          expression { params.SkipNewmanTests == 'No, run tests' }
        }
      }
      steps {
        // Set last stage in case of failure.
        script {
          LAST_STAGE = 'Newman Tests'
        }

        // Use the correct/set Maven version/installation with the given Global- and User Settings.
        withMaven(
          maven:                      "${MAVEN_VERSION}",
          // globalMavenSettingsConfig:  "f3e35f14-a552-415d-9593-328dbce86120",
          // mavenSettingsConfig:        "Swiss-Sense_Maven-User-Settings"
          globalMavenSettingsConfig:  "${MAVEN_GLOBAL_SETTINGS_CONFIG}",
          mavenSettingsConfig:        "${MAVEN_USER_SETTINGS_CONFIG}"
        ){
          // Call out the Maven version to give the "withMaven" step a body (which is required).
          sh 'mvn -version'
          echo 'Maven initialized in the "Newman Tests" stage.'
        }

        echo "Running newman tests on ${ENVIRONMENT}"
        /*sh """
          docker run\
          -v ${WORKSPACE}/postman:/etc/newman\
          -t postman/newman:alpine\
          run collection.json\
          --environment=${BRANCH_NAME}.json\
          --reporters junit\
          --reporter-junit-export=${JUNIT_FILE}
        """*/
        //junit '**/postman/*.xml'
      }
    }
  }

  post {
    always {
      echo 'Jenkins Build/Deploy actions finished, finalizing now.'
      deleteDir()
      /* clean up our workspace */
    }

    // In case of a success result status.
    success {
      echo "Mailing results to ${COMMITTER_MAIL}."
      mail to: "${COMMITTER_MAIL}",
      from: "${EMAIL_FROM}",
      subject: "Build successful: ${currentBuild.fullDisplayName}",
      body: """Hi ${COMMITTER_NAME},
        |
        |Build succeeded in its entirety for ${currentBuild.fullDisplayName}. 
        |For more details, see: ${env.BUILD_URL}
        |
        |GLO Jenkins CI/CD.""".stripMargin()
    }

    // In case of a failure result status.
    failure {
      echo "Mailing results to ${COMMITTER_MAIL}."
      mail to: "${COMMITTER_MAIL}",
      from: "${EMAIL_FROM}",
      subject: "Build failed: ${currentBuild.fullDisplayName} during ${LAST_STAGE}",
      body: """Hi ${COMMITTER_NAME},
        |
        |Build failed for ${currentBuild.fullDisplayName}, during ${LAST_STAGE}. 
        |For more details, see: ${env.BUILD_URL}
        |
        |Please correct the issues/cause of the failure and try again.
        |
        |GLO Jenkins CI/CD.""".stripMargin()
    }
    
    // This is (always) executed in case of an aborted build.
    aborted {
      echo "Mailing results to ${COMMITTER_MAIL}."
      mail to: "${COMMITTER_MAIL}",
      from: "${EMAIL_FROM}",
      subject: "Build failed: ${currentBuild.fullDisplayName} during ${LAST_STAGE}",
      body: """Hello ${COMMITTER_NAME},
        |
        |The build for ${currentBuild.fullDisplayName} has been aborted during the ${LAST_STAGE} stage.
        |Reason for this abortion was: ${ERROR_MESSAGE}
        |For more details, see: ${env.BUILD_URL}
        |
        |Please correct the issues/cause of the abortion and try again.
        |
        |GLO Jenkins CI/CD.""".stripMargin()
    }
  }
}
