################################################################################
# Encrypt ebs volume
################################################################################

resource "aws_ebs_encryption_by_default" "ebs_encryption" {
  enabled = true
}

################################################################################
# Enable HIPAA conformance pack in config
################################################################################

resource "aws_config_conformance_pack" "hipaa-cp" {
  name = "hipaa-cp"

  template_body = <<EOT

##################################################################################
#
#   Conformance Pack:
#     Operational Best Practices for HIPAA Security
#
#   This conformance pack helps verify compliance with HIPAA Security requirements.
#
#   See Parameters section for names and descriptions of required parameters.
#
##################################################################################

Parameters:
  AccessKeysRotatedParamMaxAccessKeyAge:
    Default: '90'
    Type: String
  CloudwatchAlarmActionCheckParamAlarmActionRequired:
    Default: 'TRUE'
    Type: String
  CloudwatchAlarmActionCheckParamInsufficientDataActionRequired:
    Default: 'TRUE'
    Type: String
  CloudwatchAlarmActionCheckParamOkActionRequired:
    Default: 'FALSE'
    Type: String
  CwLoggroupRetentionPeriodCheckParamMinRetentionTime:
    Default: '365'
    Type: String
  GuarddutyNonArchivedFindingsParamDaysHighSev:
    Default: '1'
    Type: String
  GuarddutyNonArchivedFindingsParamDaysLowSev:
    Default: '30'
    Type: String
  GuarddutyNonArchivedFindingsParamDaysMediumSev:
    Default: '7'
    Type: String
  IamPasswordPolicyParamMaxPasswordAge:
    Default: '90'
    Type: String
  IamPasswordPolicyParamMinimumPasswordLength:
    Default: '14'
    Type: String
  IamPasswordPolicyParamPasswordReusePrevention:
    Default: '24'
    Type: String
  IamPasswordPolicyParamRequireLowercaseCharacters:
    Default: 'true'
    Type: String
  IamPasswordPolicyParamRequireNumbers:
    Default: 'true'
    Type: String
  IamPasswordPolicyParamRequireSymbols:
    Default: 'true'
    Type: String
  IamPasswordPolicyParamRequireUppercaseCharacters:
    Default: 'true'
    Type: String
  IamUserUnusedCredentialsCheckParamMaxCredentialUsageAge:
    Default: '90'
    Type: String
  RedshiftClusterConfigurationCheckParamClusterDbEncrypted:
    Default: 'TRUE'
    Type: String
  RedshiftClusterConfigurationCheckParamLoggingEnabled:
    Default: 'TRUE'
    Type: String
  RedshiftClusterMaintenancesettingsCheckParamAllowVersionUpgrade:
    Default: 'TRUE'
    Type: String
  RestrictedIncomingTrafficParamBlockedPort1:
    Default: '20'
    Type: String
  RestrictedIncomingTrafficParamBlockedPort2:
    Default: '21'
    Type: String
  RestrictedIncomingTrafficParamBlockedPort3:
    Default: '3389'
    Type: String
  RestrictedIncomingTrafficParamBlockedPort4:
    Default: '3306'
    Type: String
  RestrictedIncomingTrafficParamBlockedPort5:
    Default: '4333'
    Type: String
  S3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicAcls:
    Default: 'True'
    Type: String
  S3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicPolicy:
    Default: 'True'
    Type: String
  S3AccountLevelPublicAccessBlocksPeriodicParamIgnorePublicAcls:
    Default: 'True'
    Type: String
  S3AccountLevelPublicAccessBlocksPeriodicParamRestrictPublicBuckets:
    Default: 'True'
    Type: String
  SecretsmanagerSecretPeriodicRotationParamMaxDaysSinceRotation:
    Default: '90'
    Type: String
  SecretsmanagerSecretUnusedParamUnusedForDays:
    Default: '90'
    Type: String
Resources:
  AccessKeysRotated:
    Properties:
      ConfigRuleName: access-keys-rotated
      InputParameters:
        maxAccessKeyAge:
          Fn::If:
          - accessKeysRotatedParamMaxAccessKeyAge
          - Ref: AccessKeysRotatedParamMaxAccessKeyAge
          - Ref: AWS::NoValue
      Source:
        Owner: AWS
        SourceIdentifier: ACCESS_KEYS_ROTATED
    Type: AWS::Config::ConfigRule
  AlbHttpDropInvalidHeaderEnabled:
    Properties:
      ConfigRuleName: alb-http-drop-invalid-header-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::ElasticLoadBalancingV2::LoadBalancer
      Source:
        Owner: AWS
        SourceIdentifier: ALB_HTTP_DROP_INVALID_HEADER_ENABLED
    Type: AWS::Config::ConfigRule
  AlbHttpToHttpsRedirectionCheck:
    Properties:
      ConfigRuleName: alb-http-to-https-redirection-check
      Source:
        Owner: AWS
        SourceIdentifier: ALB_HTTP_TO_HTTPS_REDIRECTION_CHECK
    Type: AWS::Config::ConfigRule
  ApiGwCacheEnabledAndEncrypted:
    Properties:
      ConfigRuleName: api-gw-cache-enabled-and-encrypted
      Scope:
        ComplianceResourceTypes:
        - AWS::ApiGateway::Stage
      Source:
        Owner: AWS
        SourceIdentifier: API_GW_CACHE_ENABLED_AND_ENCRYPTED
    Type: AWS::Config::ConfigRule
  ApiGwExecutionLoggingEnabled:
    Properties:
      ConfigRuleName: api-gw-execution-logging-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::ApiGateway::Stage
        - AWS::ApiGatewayV2::Stage
      Source:
        Owner: AWS
        SourceIdentifier: API_GW_EXECUTION_LOGGING_ENABLED
    Type: AWS::Config::ConfigRule
  ApiGwSslEnabled:
    Properties:
      ConfigRuleName: api-gw-ssl-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::ApiGateway::Stage
      Source:
        Owner: AWS
        SourceIdentifier: API_GW_SSL_ENABLED
    Type: AWS::Config::ConfigRule
  ApiGwXrayEnabled:
    Properties:
      ConfigRuleName: api-gw-xray-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::ApiGateway::Stage
      Source:
        Owner: AWS
        SourceIdentifier: API_GW_XRAY_ENABLED
    Type: AWS::Config::ConfigRule
  AutoscalingGroupElbHealthcheckRequired:
    Properties:
      ConfigRuleName: autoscaling-group-elb-healthcheck-required
      Scope:
        ComplianceResourceTypes:
        - AWS::AutoScaling::AutoScalingGroup
      Source:
        Owner: AWS
        SourceIdentifier: AUTOSCALING_GROUP_ELB_HEALTHCHECK_REQUIRED
    Type: AWS::Config::ConfigRule
  AutoscalingLaunchConfigPublicIpDisabled:
    Properties:
      ConfigRuleName: autoscaling-launch-config-public-ip-disabled
      Scope:
        ComplianceResourceTypes:
        - AWS::AutoScaling::LaunchConfiguration
      Source:
        Owner: AWS
        SourceIdentifier: AUTOSCALING_LAUNCH_CONFIG_PUBLIC_IP_DISABLED
    Type: AWS::Config::ConfigRule
  BeanstalkEnhancedHealthReportingEnabled:
    Properties:
      ConfigRuleName: beanstalk-enhanced-health-reporting-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::ElasticBeanstalk::Environment
      Source:
        Owner: AWS
        SourceIdentifier: BEANSTALK_ENHANCED_HEALTH_REPORTING_ENABLED
    Type: AWS::Config::ConfigRule
  CloudTrailCloudWatchLogsEnabled:
    Properties:
      ConfigRuleName: cloud-trail-cloud-watch-logs-enabled
      Source:
        Owner: AWS
        SourceIdentifier: CLOUD_TRAIL_CLOUD_WATCH_LOGS_ENABLED
    Type: AWS::Config::ConfigRule
  CloudTrailEnabled:
    Properties:
      ConfigRuleName: cloudtrail-enabled
      Source:
        Owner: AWS
        SourceIdentifier: CLOUD_TRAIL_ENABLED
    Type: AWS::Config::ConfigRule
  CloudTrailEncryptionEnabled:
    Properties:
      ConfigRuleName: cloud-trail-encryption-enabled
      Source:
        Owner: AWS
        SourceIdentifier: CLOUD_TRAIL_ENCRYPTION_ENABLED
    Type: AWS::Config::ConfigRule
  CloudTrailLogFileValidationEnabled:
    Properties:
      ConfigRuleName: cloud-trail-log-file-validation-enabled
      Source:
        Owner: AWS
        SourceIdentifier: CLOUD_TRAIL_LOG_FILE_VALIDATION_ENABLED
    Type: AWS::Config::ConfigRule
  CloudtrailS3DataeventsEnabled:
    Properties:
      ConfigRuleName: cloudtrail-s3-dataevents-enabled
      Source:
        Owner: AWS
        SourceIdentifier: CLOUDTRAIL_S3_DATAEVENTS_ENABLED
    Type: AWS::Config::ConfigRule
  CloudwatchAlarmActionCheck:
    Properties:
      ConfigRuleName: cloudwatch-alarm-action-check
      InputParameters:
        alarmActionRequired:
          Fn::If:
          - cloudwatchAlarmActionCheckParamAlarmActionRequired
          - Ref: CloudwatchAlarmActionCheckParamAlarmActionRequired
          - Ref: AWS::NoValue
        insufficientDataActionRequired:
          Fn::If:
          - cloudwatchAlarmActionCheckParamInsufficientDataActionRequired
          - Ref: CloudwatchAlarmActionCheckParamInsufficientDataActionRequired
          - Ref: AWS::NoValue
        okActionRequired:
          Fn::If:
          - cloudwatchAlarmActionCheckParamOkActionRequired
          - Ref: CloudwatchAlarmActionCheckParamOkActionRequired
          - Ref: AWS::NoValue
      Scope:
        ComplianceResourceTypes:
        - AWS::CloudWatch::Alarm
      Source:
        Owner: AWS
        SourceIdentifier: CLOUDWATCH_ALARM_ACTION_CHECK
    Type: AWS::Config::ConfigRule
  CloudwatchLogGroupEncrypted:
    Properties:
      ConfigRuleName: cloudwatch-log-group-encrypted
      Source:
        Owner: AWS
        SourceIdentifier: CLOUDWATCH_LOG_GROUP_ENCRYPTED
    Type: AWS::Config::ConfigRule
  CodebuildProjectEnvvarAwscredCheck:
    Properties:
      ConfigRuleName: codebuild-project-envvar-awscred-check
      Scope:
        ComplianceResourceTypes:
        - AWS::CodeBuild::Project
      Source:
        Owner: AWS
        SourceIdentifier: CODEBUILD_PROJECT_ENVVAR_AWSCRED_CHECK
    Type: AWS::Config::ConfigRule
  CodebuildProjectSourceRepoUrlCheck:
    Properties:
      ConfigRuleName: codebuild-project-source-repo-url-check
      Scope:
        ComplianceResourceTypes:
        - AWS::CodeBuild::Project
      Source:
        Owner: AWS
        SourceIdentifier: CODEBUILD_PROJECT_SOURCE_REPO_URL_CHECK
    Type: AWS::Config::ConfigRule
  CwLoggroupRetentionPeriodCheck:
    Properties:
      ConfigRuleName: cw-loggroup-retention-period-check
      InputParameters:
        MinRetentionTime:
          Fn::If:
          - cwLoggroupRetentionPeriodCheckParamMinRetentionTime
          - Ref: CwLoggroupRetentionPeriodCheckParamMinRetentionTime
          - Ref: AWS::NoValue
      Source:
        Owner: AWS
        SourceIdentifier: CW_LOGGROUP_RETENTION_PERIOD_CHECK
    Type: AWS::Config::ConfigRule
  DbInstanceBackupEnabled:
    Properties:
      ConfigRuleName: db-instance-backup-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::RDS::DBInstance
      Source:
        Owner: AWS
        SourceIdentifier: DB_INSTANCE_BACKUP_ENABLED
    Type: AWS::Config::ConfigRule
  DmsReplicationNotPublic:
    Properties:
      ConfigRuleName: dms-replication-not-public
      Scope:
        ComplianceResourceTypes: []
      Source:
        Owner: AWS
        SourceIdentifier: DMS_REPLICATION_NOT_PUBLIC
    Type: AWS::Config::ConfigRule
  DynamodbAutoscalingEnabled:
    Properties:
      ConfigRuleName: dynamodb-autoscaling-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::DynamoDB::Table
      Source:
        Owner: AWS
        SourceIdentifier: DYNAMODB_AUTOSCALING_ENABLED
    Type: AWS::Config::ConfigRule
  DynamodbInBackupPlan:
    Properties:
      ConfigRuleName: dynamodb-in-backup-plan
      Source:
        Owner: AWS
        SourceIdentifier: DYNAMODB_IN_BACKUP_PLAN
    Type: AWS::Config::ConfigRule
  DynamodbPitrEnabled:
    Properties:
      ConfigRuleName: dynamodb-pitr-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::DynamoDB::Table
      Source:
        Owner: AWS
        SourceIdentifier: DYNAMODB_PITR_ENABLED
    Type: AWS::Config::ConfigRule
  DynamodbTableEncryptedKms:
    Properties:
      ConfigRuleName: dynamodb-table-encrypted-kms
      Scope:
        ComplianceResourceTypes:
        - AWS::DynamoDB::Table
      Source:
        Owner: AWS
        SourceIdentifier: DYNAMODB_TABLE_ENCRYPTED_KMS
    Type: AWS::Config::ConfigRule
  DynamodbThroughputLimitCheck:
    Properties:
      ConfigRuleName: dynamodb-throughput-limit-check
      Source:
        Owner: AWS
        SourceIdentifier: DYNAMODB_THROUGHPUT_LIMIT_CHECK
    Type: AWS::Config::ConfigRule
  EbsInBackupPlan:
    Properties:
      ConfigRuleName: ebs-in-backup-plan
      Source:
        Owner: AWS
        SourceIdentifier: EBS_IN_BACKUP_PLAN
    Type: AWS::Config::ConfigRule
  EbsOptimizedInstance:
    Properties:
      ConfigRuleName: ebs-optimized-instance
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::Instance
      Source:
        Owner: AWS
        SourceIdentifier: EBS_OPTIMIZED_INSTANCE
    Type: AWS::Config::ConfigRule
  EbsSnapshotPublicRestorableCheck:
    Properties:
      ConfigRuleName: ebs-snapshot-public-restorable-check
      Source:
        Owner: AWS
        SourceIdentifier: EBS_SNAPSHOT_PUBLIC_RESTORABLE_CHECK
    Type: AWS::Config::ConfigRule
  Ec2EbsEncryptionByDefault:
    Properties:
      ConfigRuleName: ec2-ebs-encryption-by-default
      Source:
        Owner: AWS
        SourceIdentifier: EC2_EBS_ENCRYPTION_BY_DEFAULT
    Type: AWS::Config::ConfigRule
  Ec2Imdsv2Check:
    Properties:
      ConfigRuleName: ec2-imdsv2-check
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::Instance
      Source:
        Owner: AWS
        SourceIdentifier: EC2_IMDSV2_CHECK
    Type: AWS::Config::ConfigRule
  Ec2InstanceDetailedMonitoringEnabled:
    Properties:
      ConfigRuleName: ec2-instance-detailed-monitoring-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::Instance
      Source:
        Owner: AWS
        SourceIdentifier: EC2_INSTANCE_DETAILED_MONITORING_ENABLED
    Type: AWS::Config::ConfigRule
  Ec2InstanceManagedBySsm:
    Properties:
      ConfigRuleName: ec2-instance-managed-by-systems-manager
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::Instance
        - AWS::SSM::ManagedInstanceInventory
      Source:
        Owner: AWS
        SourceIdentifier: EC2_INSTANCE_MANAGED_BY_SSM
    Type: AWS::Config::ConfigRule
  Ec2InstanceNoPublicIp:
    Properties:
      ConfigRuleName: ec2-instance-no-public-ip
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::Instance
      Source:
        Owner: AWS
        SourceIdentifier: EC2_INSTANCE_NO_PUBLIC_IP
    Type: AWS::Config::ConfigRule
  Ec2InstanceProfileAttached:
    Properties:
      ConfigRuleName: ec2-instance-profile-attached
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::Instance
      Source:
        Owner: AWS
        SourceIdentifier: EC2_INSTANCE_PROFILE_ATTACHED
    Type: AWS::Config::ConfigRule
  Ec2ManagedinstanceAssociationComplianceStatusCheck:
    Properties:
      ConfigRuleName: ec2-managedinstance-association-compliance-status-check
      Scope:
        ComplianceResourceTypes:
        - AWS::SSM::AssociationCompliance
      Source:
        Owner: AWS
        SourceIdentifier: EC2_MANAGEDINSTANCE_ASSOCIATION_COMPLIANCE_STATUS_CHECK
    Type: AWS::Config::ConfigRule
  Ec2ManagedinstancePatchComplianceStatusCheck:
    Properties:
      ConfigRuleName: ec2-managedinstance-patch-compliance-status-check
      Scope:
        ComplianceResourceTypes:
        - AWS::SSM::PatchCompliance
      Source:
        Owner: AWS
        SourceIdentifier: EC2_MANAGEDINSTANCE_PATCH_COMPLIANCE_STATUS_CHECK
    Type: AWS::Config::ConfigRule
  EcsTaskDefinitionUserForHostModeCheck:
    Properties:
      ConfigRuleName: ecs-task-definition-user-for-host-mode-check
      Scope:
        ComplianceResourceTypes:
        - AWS::ECS::TaskDefinition
      Source:
        Owner: AWS
        SourceIdentifier: ECS_TASK_DEFINITION_USER_FOR_HOST_MODE_CHECK
    Type: AWS::Config::ConfigRule
  EfsEncryptedCheck:
    Properties:
      ConfigRuleName: efs-encrypted-check
      Source:
        Owner: AWS
        SourceIdentifier: EFS_ENCRYPTED_CHECK
    Type: AWS::Config::ConfigRule
  EfsInBackupPlan:
    Properties:
      ConfigRuleName: efs-in-backup-plan
      Source:
        Owner: AWS
        SourceIdentifier: EFS_IN_BACKUP_PLAN
    Type: AWS::Config::ConfigRule
  ElasticBeanstalkManagedUpdatesEnabled:
    Properties:
      ConfigRuleName: elastic-beanstalk-managed-updates-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::ElasticBeanstalk::Environment
      Source:
        Owner: AWS
        SourceIdentifier: ELASTIC_BEANSTALK_MANAGED_UPDATES_ENABLED
    Type: AWS::Config::ConfigRule
  ElasticacheRedisClusterAutomaticBackupCheck:
    Properties:
      ConfigRuleName: elasticache-redis-cluster-automatic-backup-check
      Source:
        Owner: AWS
        SourceIdentifier: ELASTICACHE_REDIS_CLUSTER_AUTOMATIC_BACKUP_CHECK
    Type: AWS::Config::ConfigRule
  ElasticsearchEncryptedAtRest:
    Properties:
      ConfigRuleName: elasticsearch-encrypted-at-rest
      Source:
        Owner: AWS
        SourceIdentifier: ELASTICSEARCH_ENCRYPTED_AT_REST
    Type: AWS::Config::ConfigRule
  ElasticsearchInVpcOnly:
    Properties:
      ConfigRuleName: elasticsearch-in-vpc-only
      Source:
        Owner: AWS
        SourceIdentifier: ELASTICSEARCH_IN_VPC_ONLY
    Type: AWS::Config::ConfigRule
  ElasticsearchLogsToCloudwatch:
    Properties:
      ConfigRuleName: elasticsearch-logs-to-cloudwatch
      Scope:
        ComplianceResourceTypes:
        - AWS::Elasticsearch::Domain
      Source:
        Owner: AWS
        SourceIdentifier: ELASTICSEARCH_LOGS_TO_CLOUDWATCH
    Type: AWS::Config::ConfigRule
  ElasticsearchNodeToNodeEncryptionCheck:
    Properties:
      ConfigRuleName: elasticsearch-node-to-node-encryption-check
      Scope:
        ComplianceResourceTypes:
        - AWS::Elasticsearch::Domain
      Source:
        Owner: AWS
        SourceIdentifier: ELASTICSEARCH_NODE_TO_NODE_ENCRYPTION_CHECK
    Type: AWS::Config::ConfigRule
  ElbAcmCertificateRequired:
    Properties:
      ConfigRuleName: elb-acm-certificate-required
      Scope:
        ComplianceResourceTypes:
        - AWS::ElasticLoadBalancing::LoadBalancer
      Source:
        Owner: AWS
        SourceIdentifier: ELB_ACM_CERTIFICATE_REQUIRED
    Type: AWS::Config::ConfigRule
  ElbCrossZoneLoadBalancingEnabled:
    Properties:
      ConfigRuleName: elb-cross-zone-load-balancing-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::ElasticLoadBalancing::LoadBalancer
      Source:
        Owner: AWS
        SourceIdentifier: ELB_CROSS_ZONE_LOAD_BALANCING_ENABLED
    Type: AWS::Config::ConfigRule
  ElbDeletionProtectionEnabled:
    Properties:
      ConfigRuleName: elb-deletion-protection-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::ElasticLoadBalancingV2::LoadBalancer
      Source:
        Owner: AWS
        SourceIdentifier: ELB_DELETION_PROTECTION_ENABLED
    Type: AWS::Config::ConfigRule
  ElbLoggingEnabled:
    Properties:
      ConfigRuleName: elb-logging-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::ElasticLoadBalancing::LoadBalancer
        - AWS::ElasticLoadBalancingV2::LoadBalancer
      Source:
        Owner: AWS
        SourceIdentifier: ELB_LOGGING_ENABLED
    Type: AWS::Config::ConfigRule
  ElbTlsHttpsListenersOnly:
    Properties:
      ConfigRuleName: elb-tls-https-listeners-only
      Scope:
        ComplianceResourceTypes:
        - AWS::ElasticLoadBalancing::LoadBalancer
      Source:
        Owner: AWS
        SourceIdentifier: ELB_TLS_HTTPS_LISTENERS_ONLY
    Type: AWS::Config::ConfigRule
  Elbv2AcmCertificateRequired:
    Properties:
      ConfigRuleName: elbv2-acm-certificate-required
      Source:
        Owner: AWS
        SourceIdentifier: ELBV2_ACM_CERTIFICATE_REQUIRED
    Type: AWS::Config::ConfigRule
  EmrKerberosEnabled:
    Properties:
      ConfigRuleName: emr-kerberos-enabled
      Source:
        Owner: AWS
        SourceIdentifier: EMR_KERBEROS_ENABLED
    Type: AWS::Config::ConfigRule
  EmrMasterNoPublicIp:
    Properties:
      ConfigRuleName: emr-master-no-public-ip
      Scope:
        ComplianceResourceTypes: []
      Source:
        Owner: AWS
        SourceIdentifier: EMR_MASTER_NO_PUBLIC_IP
    Type: AWS::Config::ConfigRule
  EncryptedVolumes:
    Properties:
      ConfigRuleName: encrypted-volumes
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::Volume
      Source:
        Owner: AWS
        SourceIdentifier: ENCRYPTED_VOLUMES
    Type: AWS::Config::ConfigRule
  GuarddutyEnabledCentralized:
    Properties:
      ConfigRuleName: guardduty-enabled-centralized
      Source:
        Owner: AWS
        SourceIdentifier: GUARDDUTY_ENABLED_CENTRALIZED
    Type: AWS::Config::ConfigRule
  GuarddutyNonArchivedFindings:
    Properties:
      ConfigRuleName: guardduty-non-archived-findings
      InputParameters:
        daysHighSev:
          Fn::If:
          - guarddutyNonArchivedFindingsParamDaysHighSev
          - Ref: GuarddutyNonArchivedFindingsParamDaysHighSev
          - Ref: AWS::NoValue
        daysLowSev:
          Fn::If:
          - guarddutyNonArchivedFindingsParamDaysLowSev
          - Ref: GuarddutyNonArchivedFindingsParamDaysLowSev
          - Ref: AWS::NoValue
        daysMediumSev:
          Fn::If:
          - guarddutyNonArchivedFindingsParamDaysMediumSev
          - Ref: GuarddutyNonArchivedFindingsParamDaysMediumSev
          - Ref: AWS::NoValue
      Source:
        Owner: AWS
        SourceIdentifier: GUARDDUTY_NON_ARCHIVED_FINDINGS
    Type: AWS::Config::ConfigRule
  IamGroupHasUsersCheck:
    Properties:
      ConfigRuleName: iam-group-has-users-check
      Scope:
        ComplianceResourceTypes:
        - AWS::IAM::Group
      Source:
        Owner: AWS
        SourceIdentifier: IAM_GROUP_HAS_USERS_CHECK
    Type: AWS::Config::ConfigRule
  IamNoInlinePolicyCheck:
    Properties:
      ConfigRuleName: iam-no-inline-policy-check
      Scope:
        ComplianceResourceTypes:
        - AWS::IAM::User
        - AWS::IAM::Role
        - AWS::IAM::Group
      Source:
        Owner: AWS
        SourceIdentifier: IAM_NO_INLINE_POLICY_CHECK
    Type: AWS::Config::ConfigRule
  IamPasswordPolicy:
    Properties:
      ConfigRuleName: iam-password-policy
      InputParameters:
        MaxPasswordAge:
          Fn::If:
          - iamPasswordPolicyParamMaxPasswordAge
          - Ref: IamPasswordPolicyParamMaxPasswordAge
          - Ref: AWS::NoValue
        MinimumPasswordLength:
          Fn::If:
          - iamPasswordPolicyParamMinimumPasswordLength
          - Ref: IamPasswordPolicyParamMinimumPasswordLength
          - Ref: AWS::NoValue
        PasswordReusePrevention:
          Fn::If:
          - iamPasswordPolicyParamPasswordReusePrevention
          - Ref: IamPasswordPolicyParamPasswordReusePrevention
          - Ref: AWS::NoValue
        RequireLowercaseCharacters:
          Fn::If:
          - iamPasswordPolicyParamRequireLowercaseCharacters
          - Ref: IamPasswordPolicyParamRequireLowercaseCharacters
          - Ref: AWS::NoValue
        RequireNumbers:
          Fn::If:
          - iamPasswordPolicyParamRequireNumbers
          - Ref: IamPasswordPolicyParamRequireNumbers
          - Ref: AWS::NoValue
        RequireSymbols:
          Fn::If:
          - iamPasswordPolicyParamRequireSymbols
          - Ref: IamPasswordPolicyParamRequireSymbols
          - Ref: AWS::NoValue
        RequireUppercaseCharacters:
          Fn::If:
          - iamPasswordPolicyParamRequireUppercaseCharacters
          - Ref: IamPasswordPolicyParamRequireUppercaseCharacters
          - Ref: AWS::NoValue
      Source:
        Owner: AWS
        SourceIdentifier: IAM_PASSWORD_POLICY
    Type: AWS::Config::ConfigRule
  IamPolicyNoStatementsWithAdminAccess:
    Properties:
      ConfigRuleName: iam-policy-no-statements-with-admin-access
      Scope:
        ComplianceResourceTypes:
        - AWS::IAM::Policy
      Source:
        Owner: AWS
        SourceIdentifier: IAM_POLICY_NO_STATEMENTS_WITH_ADMIN_ACCESS
    Type: AWS::Config::ConfigRule
  IamPolicyNoStatementsWithFullAccess:
    Properties:
      ConfigRuleName: iam-policy-no-statements-with-full-access
      Scope:
        ComplianceResourceTypes:
        - AWS::IAM::Policy
      Source:
        Owner: AWS
        SourceIdentifier: IAM_POLICY_NO_STATEMENTS_WITH_FULL_ACCESS
    Type: AWS::Config::ConfigRule
  IamRootAccessKeyCheck:
    Properties:
      ConfigRuleName: iam-root-access-key-check
      Source:
        Owner: AWS
        SourceIdentifier: IAM_ROOT_ACCESS_KEY_CHECK
    Type: AWS::Config::ConfigRule
  IamUserGroupMembershipCheck:
    Properties:
      ConfigRuleName: iam-user-group-membership-check
      Scope:
        ComplianceResourceTypes:
        - AWS::IAM::User
      Source:
        Owner: AWS
        SourceIdentifier: IAM_USER_GROUP_MEMBERSHIP_CHECK
    Type: AWS::Config::ConfigRule
  IamUserMfaEnabled:
    Properties:
      ConfigRuleName: iam-user-mfa-enabled
      Source:
        Owner: AWS
        SourceIdentifier: IAM_USER_MFA_ENABLED
    Type: AWS::Config::ConfigRule
  IamUserNoPoliciesCheck:
    Properties:
      ConfigRuleName: iam-user-no-policies-check
      Scope:
        ComplianceResourceTypes:
        - AWS::IAM::User
      Source:
        Owner: AWS
        SourceIdentifier: IAM_USER_NO_POLICIES_CHECK
    Type: AWS::Config::ConfigRule
  IamUserUnusedCredentialsCheck:
    Properties:
      ConfigRuleName: iam-user-unused-credentials-check
      InputParameters:
        maxCredentialUsageAge:
          Fn::If:
          - iamUserUnusedCredentialsCheckParamMaxCredentialUsageAge
          - Ref: IamUserUnusedCredentialsCheckParamMaxCredentialUsageAge
          - Ref: AWS::NoValue
      Source:
        Owner: AWS
        SourceIdentifier: IAM_USER_UNUSED_CREDENTIALS_CHECK
    Type: AWS::Config::ConfigRule
  IncomingSshDisabled:
    Properties:
      ConfigRuleName: restricted-ssh
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::SecurityGroup
      Source:
        Owner: AWS
        SourceIdentifier: INCOMING_SSH_DISABLED
    Type: AWS::Config::ConfigRule
  InstancesInVpc:
    Properties:
      ConfigRuleName: ec2-instances-in-vpc
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::Instance
      Source:
        Owner: AWS
        SourceIdentifier: INSTANCES_IN_VPC
    Type: AWS::Config::ConfigRule
  LambdaConcurrencyCheck:
    Properties:
      ConfigRuleName: lambda-concurrency-check
      Scope:
        ComplianceResourceTypes:
        - AWS::Lambda::Function
      Source:
        Owner: AWS
        SourceIdentifier: LAMBDA_CONCURRENCY_CHECK
    Type: AWS::Config::ConfigRule
  LambdaDlqCheck:
    Properties:
      ConfigRuleName: lambda-dlq-check
      Scope:
        ComplianceResourceTypes:
        - AWS::Lambda::Function
      Source:
        Owner: AWS
        SourceIdentifier: LAMBDA_DLQ_CHECK
    Type: AWS::Config::ConfigRule
  LambdaFunctionPublicAccessProhibited:
    Properties:
      ConfigRuleName: lambda-function-public-access-prohibited
      Scope:
        ComplianceResourceTypes:
        - AWS::Lambda::Function
      Source:
        Owner: AWS
        SourceIdentifier: LAMBDA_FUNCTION_PUBLIC_ACCESS_PROHIBITED
    Type: AWS::Config::ConfigRule
  LambdaInsideVpc:
    Properties:
      ConfigRuleName: lambda-inside-vpc
      Scope:
        ComplianceResourceTypes:
        - AWS::Lambda::Function
      Source:
        Owner: AWS
        SourceIdentifier: LAMBDA_INSIDE_VPC
    Type: AWS::Config::ConfigRule
  MfaEnabledForIamConsoleAccess:
    Properties:
      ConfigRuleName: mfa-enabled-for-iam-console-access
      Source:
        Owner: AWS
        SourceIdentifier: MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS
    Type: AWS::Config::ConfigRule
  MultiRegionCloudTrailEnabled:
    Properties:
      ConfigRuleName: multi-region-cloudtrail-enabled
      Source:
        Owner: AWS
        SourceIdentifier: MULTI_REGION_CLOUD_TRAIL_ENABLED
    Type: AWS::Config::ConfigRule
  NoUnrestrictedRouteToIgw:
    Properties:
      ConfigRuleName: no-unrestricted-route-to-igw
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::RouteTable
      Source:
        Owner: AWS
        SourceIdentifier: NO_UNRESTRICTED_ROUTE_TO_IGW
    Type: AWS::Config::ConfigRule
  RdsAutomaticMinorVersionUpgradeEnabled:
    Properties:
      ConfigRuleName: rds-automatic-minor-version-upgrade-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::RDS::DBInstance
      Source:
        Owner: AWS
        SourceIdentifier: RDS_AUTOMATIC_MINOR_VERSION_UPGRADE_ENABLED
    Type: AWS::Config::ConfigRule
  RdsEnhancedMonitoringEnabled:
    Properties:
      ConfigRuleName: rds-enhanced-monitoring-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::RDS::DBInstance
      Source:
        Owner: AWS
        SourceIdentifier: RDS_ENHANCED_MONITORING_ENABLED
    Type: AWS::Config::ConfigRule
  RdsInBackupPlan:
    Properties:
      ConfigRuleName: rds-in-backup-plan
      Source:
        Owner: AWS
        SourceIdentifier: RDS_IN_BACKUP_PLAN
    Type: AWS::Config::ConfigRule
  RdsInstanceDeletionProtectionEnabled:
    Properties:
      ConfigRuleName: rds-instance-deletion-protection-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::RDS::DBInstance
      Source:
        Owner: AWS
        SourceIdentifier: RDS_INSTANCE_DELETION_PROTECTION_ENABLED
    Type: AWS::Config::ConfigRule
  RdsInstancePublicAccessCheck:
    Properties:
      ConfigRuleName: rds-instance-public-access-check
      Scope:
        ComplianceResourceTypes:
        - AWS::RDS::DBInstance
      Source:
        Owner: AWS
        SourceIdentifier: RDS_INSTANCE_PUBLIC_ACCESS_CHECK
    Type: AWS::Config::ConfigRule
  RdsLoggingEnabled:
    Properties:
      ConfigRuleName: rds-logging-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::RDS::DBInstance
      Source:
        Owner: AWS
        SourceIdentifier: RDS_LOGGING_ENABLED
    Type: AWS::Config::ConfigRule
  RdsMultiAzSupport:
    Properties:
      ConfigRuleName: rds-multi-az-support
      Scope:
        ComplianceResourceTypes:
        - AWS::RDS::DBInstance
      Source:
        Owner: AWS
        SourceIdentifier: RDS_MULTI_AZ_SUPPORT
    Type: AWS::Config::ConfigRule
  RdsSnapshotEncrypted:
    Properties:
      ConfigRuleName: rds-snapshot-encrypted
      Scope:
        ComplianceResourceTypes:
        - AWS::RDS::DBSnapshot
        - AWS::RDS::DBClusterSnapshot
      Source:
        Owner: AWS
        SourceIdentifier: RDS_SNAPSHOT_ENCRYPTED
    Type: AWS::Config::ConfigRule
  RdsSnapshotsPublicProhibited:
    Properties:
      ConfigRuleName: rds-snapshots-public-prohibited
      Scope:
        ComplianceResourceTypes:
        - AWS::RDS::DBSnapshot
        - AWS::RDS::DBClusterSnapshot
      Source:
        Owner: AWS
        SourceIdentifier: RDS_SNAPSHOTS_PUBLIC_PROHIBITED
    Type: AWS::Config::ConfigRule
  RdsStorageEncrypted:
    Properties:
      ConfigRuleName: rds-storage-encrypted
      Scope:
        ComplianceResourceTypes:
        - AWS::RDS::DBInstance
      Source:
        Owner: AWS
        SourceIdentifier: RDS_STORAGE_ENCRYPTED
    Type: AWS::Config::ConfigRule
  RedshiftBackupEnabled:
    Properties:
      ConfigRuleName: redshift-backup-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::Redshift::Cluster
      Source:
        Owner: AWS
        SourceIdentifier: REDSHIFT_BACKUP_ENABLED
    Type: AWS::Config::ConfigRule
  RedshiftClusterConfigurationCheck:
    Properties:
      ConfigRuleName: redshift-cluster-configuration-check
      InputParameters:
        clusterDbEncrypted:
          Fn::If:
          - redshiftClusterConfigurationCheckParamClusterDbEncrypted
          - Ref: RedshiftClusterConfigurationCheckParamClusterDbEncrypted
          - Ref: AWS::NoValue
        loggingEnabled:
          Fn::If:
          - redshiftClusterConfigurationCheckParamLoggingEnabled
          - Ref: RedshiftClusterConfigurationCheckParamLoggingEnabled
          - Ref: AWS::NoValue
      Scope:
        ComplianceResourceTypes:
        - AWS::Redshift::Cluster
      Source:
        Owner: AWS
        SourceIdentifier: REDSHIFT_CLUSTER_CONFIGURATION_CHECK
    Type: AWS::Config::ConfigRule
  RedshiftClusterKmsEnabled:
    Properties:
      ConfigRuleName: redshift-cluster-kms-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::Redshift::Cluster
      Source:
        Owner: AWS
        SourceIdentifier: REDSHIFT_CLUSTER_KMS_ENABLED
    Type: AWS::Config::ConfigRule
  RedshiftClusterMaintenancesettingsCheck:
    Properties:
      ConfigRuleName: redshift-cluster-maintenancesettings-check
      InputParameters:
        allowVersionUpgrade:
          Fn::If:
          - redshiftClusterMaintenancesettingsCheckParamAllowVersionUpgrade
          - Ref: RedshiftClusterMaintenancesettingsCheckParamAllowVersionUpgrade
          - Ref: AWS::NoValue
      Scope:
        ComplianceResourceTypes:
        - AWS::Redshift::Cluster
      Source:
        Owner: AWS
        SourceIdentifier: REDSHIFT_CLUSTER_MAINTENANCESETTINGS_CHECK
    Type: AWS::Config::ConfigRule
  RedshiftClusterPublicAccessCheck:
    Properties:
      ConfigRuleName: redshift-cluster-public-access-check
      Scope:
        ComplianceResourceTypes:
        - AWS::Redshift::Cluster
      Source:
        Owner: AWS
        SourceIdentifier: REDSHIFT_CLUSTER_PUBLIC_ACCESS_CHECK
    Type: AWS::Config::ConfigRule
  RedshiftEnhancedVpcRoutingEnabled:
    Properties:
      ConfigRuleName: redshift-enhanced-vpc-routing-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::Redshift::Cluster
      Source:
        Owner: AWS
        SourceIdentifier: REDSHIFT_ENHANCED_VPC_ROUTING_ENABLED
    Type: AWS::Config::ConfigRule
  RedshiftRequireTlsSsl:
    Properties:
      ConfigRuleName: redshift-require-tls-ssl
      Scope:
        ComplianceResourceTypes:
        - AWS::Redshift::Cluster
      Source:
        Owner: AWS
        SourceIdentifier: REDSHIFT_REQUIRE_TLS_SSL
    Type: AWS::Config::ConfigRule
  RestrictedIncomingTraffic:
    Properties:
      ConfigRuleName: restricted-common-ports
      InputParameters:
        blockedPort1:
          Fn::If:
          - restrictedIncomingTrafficParamBlockedPort1
          - Ref: RestrictedIncomingTrafficParamBlockedPort1
          - Ref: AWS::NoValue
        blockedPort2:
          Fn::If:
          - restrictedIncomingTrafficParamBlockedPort2
          - Ref: RestrictedIncomingTrafficParamBlockedPort2
          - Ref: AWS::NoValue
        blockedPort3:
          Fn::If:
          - restrictedIncomingTrafficParamBlockedPort3
          - Ref: RestrictedIncomingTrafficParamBlockedPort3
          - Ref: AWS::NoValue
        blockedPort4:
          Fn::If:
          - restrictedIncomingTrafficParamBlockedPort4
          - Ref: RestrictedIncomingTrafficParamBlockedPort4
          - Ref: AWS::NoValue
        blockedPort5:
          Fn::If:
          - restrictedIncomingTrafficParamBlockedPort5
          - Ref: RestrictedIncomingTrafficParamBlockedPort5
          - Ref: AWS::NoValue
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::SecurityGroup
      Source:
        Owner: AWS
        SourceIdentifier: RESTRICTED_INCOMING_TRAFFIC
    Type: AWS::Config::ConfigRule
  RootAccountHardwareMfaEnabled:
    Properties:
      ConfigRuleName: root-account-hardware-mfa-enabled
      Source:
        Owner: AWS
        SourceIdentifier: ROOT_ACCOUNT_HARDWARE_MFA_ENABLED
    Type: AWS::Config::ConfigRule
  RootAccountMfaEnabled:
    Properties:
      ConfigRuleName: root-account-mfa-enabled
      Source:
        Owner: AWS
        SourceIdentifier: ROOT_ACCOUNT_MFA_ENABLED
    Type: AWS::Config::ConfigRule
  S3AccountLevelPublicAccessBlocksPeriodic:
    Properties:
      ConfigRuleName: s3-account-level-public-access-blocks-periodic
      InputParameters:
        BlockPublicAcls:
          Fn::If:
          - s3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicAcls
          - Ref: S3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicAcls
          - Ref: AWS::NoValue
        BlockPublicPolicy:
          Fn::If:
          - s3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicPolicy
          - Ref: S3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicPolicy
          - Ref: AWS::NoValue
        IgnorePublicAcls:
          Fn::If:
          - s3AccountLevelPublicAccessBlocksPeriodicParamIgnorePublicAcls
          - Ref: S3AccountLevelPublicAccessBlocksPeriodicParamIgnorePublicAcls
          - Ref: AWS::NoValue
        RestrictPublicBuckets:
          Fn::If:
          - s3AccountLevelPublicAccessBlocksPeriodicParamRestrictPublicBuckets
          - Ref: S3AccountLevelPublicAccessBlocksPeriodicParamRestrictPublicBuckets
          - Ref: AWS::NoValue
      Source:
        Owner: AWS
        SourceIdentifier: S3_ACCOUNT_LEVEL_PUBLIC_ACCESS_BLOCKS_PERIODIC
    Type: AWS::Config::ConfigRule
  S3BucketLevelPublicAccessProhibited:
    Properties:
      ConfigRuleName: s3-bucket-level-public-access-prohibited
      Scope:
        ComplianceResourceTypes:
        - AWS::S3::Bucket
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_LEVEL_PUBLIC_ACCESS_PROHIBITED
    Type: AWS::Config::ConfigRule
  S3BucketLoggingEnabled:
    Properties:
      ConfigRuleName: s3-bucket-logging-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::S3::Bucket
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_LOGGING_ENABLED
    Type: AWS::Config::ConfigRule
  S3BucketPolicyGranteeCheck:
    Properties:
      ConfigRuleName: s3-bucket-policy-grantee-check
      Scope:
        ComplianceResourceTypes:
        - AWS::S3::Bucket
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_POLICY_GRANTEE_CHECK
    Type: AWS::Config::ConfigRule
  S3BucketPublicReadProhibited:
    Properties:
      ConfigRuleName: s3-bucket-public-read-prohibited
      Scope:
        ComplianceResourceTypes:
        - AWS::S3::Bucket
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_PUBLIC_READ_PROHIBITED
    Type: AWS::Config::ConfigRule
  S3BucketPublicWriteProhibited:
    Properties:
      ConfigRuleName: s3-bucket-public-write-prohibited
      Scope:
        ComplianceResourceTypes:
        - AWS::S3::Bucket
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_PUBLIC_WRITE_PROHIBITED
    Type: AWS::Config::ConfigRule
  S3BucketReplicationEnabled:
    Properties:
      ConfigRuleName: s3-bucket-replication-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::S3::Bucket
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_REPLICATION_ENABLED
    Type: AWS::Config::ConfigRule
  S3BucketServerSideEncryptionEnabled:
    Properties:
      ConfigRuleName: s3-bucket-server-side-encryption-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::S3::Bucket
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED
    Type: AWS::Config::ConfigRule
  S3BucketSslRequestsOnly:
    Properties:
      ConfigRuleName: s3-bucket-ssl-requests-only
      Scope:
        ComplianceResourceTypes:
        - AWS::S3::Bucket
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_SSL_REQUESTS_ONLY
    Type: AWS::Config::ConfigRule
  S3BucketVersioningEnabled:
    Properties:
      ConfigRuleName: s3-bucket-versioning-enabled
      Scope:
        ComplianceResourceTypes:
        - AWS::S3::Bucket
      Source:
        Owner: AWS
        SourceIdentifier: S3_BUCKET_VERSIONING_ENABLED
    Type: AWS::Config::ConfigRule
  S3DefaultEncryptionKms:
    Properties:
      ConfigRuleName: s3-default-encryption-kms
      Scope:
        ComplianceResourceTypes:
        - AWS::S3::Bucket
      Source:
        Owner: AWS
        SourceIdentifier: S3_DEFAULT_ENCRYPTION_KMS
    Type: AWS::Config::ConfigRule
  SagemakerEndpointConfigurationKmsKeyConfigured:
    Properties:
      ConfigRuleName: sagemaker-endpoint-configuration-kms-key-configured
      Source:
        Owner: AWS
        SourceIdentifier: SAGEMAKER_ENDPOINT_CONFIGURATION_KMS_KEY_CONFIGURED
    Type: AWS::Config::ConfigRule
  SagemakerNotebookInstanceKmsKeyConfigured:
    Properties:
      ConfigRuleName: sagemaker-notebook-instance-kms-key-configured
      Source:
        Owner: AWS
        SourceIdentifier: SAGEMAKER_NOTEBOOK_INSTANCE_KMS_KEY_CONFIGURED
    Type: AWS::Config::ConfigRule
  SagemakerNotebookNoDirectInternetAccess:
    Properties:
      ConfigRuleName: sagemaker-notebook-no-direct-internet-access
      Source:
        Owner: AWS
        SourceIdentifier: SAGEMAKER_NOTEBOOK_NO_DIRECT_INTERNET_ACCESS
    Type: AWS::Config::ConfigRule
  SecretsmanagerRotationEnabledCheck:
    Properties:
      ConfigRuleName: secretsmanager-rotation-enabled-check
      Scope:
        ComplianceResourceTypes:
        - AWS::SecretsManager::Secret
      Source:
        Owner: AWS
        SourceIdentifier: SECRETSMANAGER_ROTATION_ENABLED_CHECK
    Type: AWS::Config::ConfigRule
  SecretsmanagerScheduledRotationSuccessCheck:
    Properties:
      ConfigRuleName: secretsmanager-scheduled-rotation-success-check
      Scope:
        ComplianceResourceTypes:
        - AWS::SecretsManager::Secret
      Source:
        Owner: AWS
        SourceIdentifier: SECRETSMANAGER_SCHEDULED_ROTATION_SUCCESS_CHECK
    Type: AWS::Config::ConfigRule
  SecretsmanagerSecretPeriodicRotation:
    Properties:
      ConfigRuleName: secretsmanager-secret-periodic-rotation
      InputParameters:
        maxDaysSinceRotation:
          Fn::If:
          - secretsmanagerSecretPeriodicRotationParamMaxDaysSinceRotation
          - Ref: SecretsmanagerSecretPeriodicRotationParamMaxDaysSinceRotation
          - Ref: AWS::NoValue
      Source:
        Owner: AWS
        SourceIdentifier: SECRETSMANAGER_SECRET_PERIODIC_ROTATION
    Type: AWS::Config::ConfigRule
  SecretsmanagerSecretUnused:
    Properties:
      ConfigRuleName: secretsmanager-secret-unused
      InputParameters:
        unusedForDays:
          Fn::If:
          - secretsmanagerSecretUnusedParamUnusedForDays
          - Ref: SecretsmanagerSecretUnusedParamUnusedForDays
          - Ref: AWS::NoValue
      Source:
        Owner: AWS
        SourceIdentifier: SECRETSMANAGER_SECRET_UNUSED
    Type: AWS::Config::ConfigRule
  SecretsmanagerUsingCmk:
    Properties:
      ConfigRuleName: secretsmanager-using-cmk
      Scope:
        ComplianceResourceTypes:
        - AWS::SecretsManager::Secret
      Source:
        Owner: AWS
        SourceIdentifier: SECRETSMANAGER_USING_CMK
    Type: AWS::Config::ConfigRule
  SecurityhubEnabled:
    Properties:
      ConfigRuleName: securityhub-enabled
      Source:
        Owner: AWS
        SourceIdentifier: SECURITYHUB_ENABLED
    Type: AWS::Config::ConfigRule
  SnsEncryptedKms:
    Properties:
      ConfigRuleName: sns-encrypted-kms
      Scope:
        ComplianceResourceTypes:
        - AWS::SNS::Topic
      Source:
        Owner: AWS
        SourceIdentifier: SNS_ENCRYPTED_KMS
    Type: AWS::Config::ConfigRule
  SsmDocumentNotPublic:
    Properties:
      ConfigRuleName: ssm-document-not-public
      Source:
        Owner: AWS
        SourceIdentifier: SSM_DOCUMENT_NOT_PUBLIC
    Type: AWS::Config::ConfigRule
  SubnetAutoAssignPublicIpDisabled:
    Properties:
      ConfigRuleName: subnet-auto-assign-public-ip-disabled
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::Subnet
      Source:
        Owner: AWS
        SourceIdentifier: SUBNET_AUTO_ASSIGN_PUBLIC_IP_DISABLED
    Type: AWS::Config::ConfigRule
  VpcDefaultSecurityGroupClosed:
    Properties:
      ConfigRuleName: vpc-default-security-group-closed
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::SecurityGroup
      Source:
        Owner: AWS
        SourceIdentifier: VPC_DEFAULT_SECURITY_GROUP_CLOSED
    Type: AWS::Config::ConfigRule
  VpcFlowLogsEnabled:
    Properties:
      ConfigRuleName: vpc-flow-logs-enabled
      Source:
        Owner: AWS
        SourceIdentifier: VPC_FLOW_LOGS_ENABLED
    Type: AWS::Config::ConfigRule
  VpcSgOpenOnlyToAuthorizedPorts:
    Properties:
      ConfigRuleName: vpc-sg-open-only-to-authorized-ports
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::SecurityGroup
      Source:
        Owner: AWS
        SourceIdentifier: VPC_SG_OPEN_ONLY_TO_AUTHORIZED_PORTS
    Type: AWS::Config::ConfigRule
  VpcVpn2TunnelsUp:
    Properties:
      ConfigRuleName: vpc-vpn-2-tunnels-up
      Scope:
        ComplianceResourceTypes:
        - AWS::EC2::VPNConnection
      Source:
        Owner: AWS
        SourceIdentifier: VPC_VPN_2_TUNNELS_UP
    Type: AWS::Config::ConfigRule
  Wafv2LoggingEnabled:
    Properties:
      ConfigRuleName: wafv2-logging-enabled
      Source:
        Owner: AWS
        SourceIdentifier: WAFV2_LOGGING_ENABLED
    Type: AWS::Config::ConfigRule
  SecurityAwarenessProgramExists:
    Properties:
      ConfigRuleName: security-awareness-program-exists
      Description: Establish and maintain a security awareness program for your organization. Security awareness programs educate employees on how to protect their organization from various security breaches or incidents.
      Source:
        Owner: AWS
        SourceIdentifier: AWS_CONFIG_PROCESS_CHECK
    Type: AWS::Config::ConfigRule
  AnnualRiskAssessmentPerformed:
    Properties:
      ConfigRuleName: annual-risk-assessment-performed
      Description: Perform an annual risk assessment on your organization. Risk assessments can assist in determining the likelihood and impact of identified risks and/or vulnerabilities affecting an organization.
      Source:
        Owner: AWS
        SourceIdentifier: AWS_CONFIG_PROCESS_CHECK
    Type: AWS::Config::ConfigRule
  ResponsePlanExistsMaintained:
    Properties:
      ConfigRuleName: response-plan-exists-maintained
      Description: Ensure incident response plans are established, maintained, and distrubuted to responsible personel.
      Source:
        Owner: AWS
        SourceIdentifier: AWS_CONFIG_PROCESS_CHECK
    Type: AWS::Config::ConfigRule
  ResponsePlanTested:
    Properties:
      ConfigRuleName: response-plan-tested
      Description: Ensure Incident response and recovery plans are tested. This can assist in understanding if your plan will be effective during an incident and if any gaps or updates need to be addressed.
      Source:
        Owner: AWS
        SourceIdentifier: AWS_CONFIG_PROCESS_CHECK
    Type: AWS::Config::ConfigRule
Conditions:
  accessKeysRotatedParamMaxAccessKeyAge:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: AccessKeysRotatedParamMaxAccessKeyAge
  cloudwatchAlarmActionCheckParamAlarmActionRequired:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: CloudwatchAlarmActionCheckParamAlarmActionRequired
  cloudwatchAlarmActionCheckParamInsufficientDataActionRequired:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: CloudwatchAlarmActionCheckParamInsufficientDataActionRequired
  cloudwatchAlarmActionCheckParamOkActionRequired:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: CloudwatchAlarmActionCheckParamOkActionRequired
  cwLoggroupRetentionPeriodCheckParamMinRetentionTime:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: CwLoggroupRetentionPeriodCheckParamMinRetentionTime
  guarddutyNonArchivedFindingsParamDaysHighSev:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: GuarddutyNonArchivedFindingsParamDaysHighSev
  guarddutyNonArchivedFindingsParamDaysLowSev:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: GuarddutyNonArchivedFindingsParamDaysLowSev
  guarddutyNonArchivedFindingsParamDaysMediumSev:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: GuarddutyNonArchivedFindingsParamDaysMediumSev
  iamPasswordPolicyParamMaxPasswordAge:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: IamPasswordPolicyParamMaxPasswordAge
  iamPasswordPolicyParamMinimumPasswordLength:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: IamPasswordPolicyParamMinimumPasswordLength
  iamPasswordPolicyParamPasswordReusePrevention:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: IamPasswordPolicyParamPasswordReusePrevention
  iamPasswordPolicyParamRequireLowercaseCharacters:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: IamPasswordPolicyParamRequireLowercaseCharacters
  iamPasswordPolicyParamRequireNumbers:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: IamPasswordPolicyParamRequireNumbers
  iamPasswordPolicyParamRequireSymbols:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: IamPasswordPolicyParamRequireSymbols
  iamPasswordPolicyParamRequireUppercaseCharacters:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: IamPasswordPolicyParamRequireUppercaseCharacters
  iamUserUnusedCredentialsCheckParamMaxCredentialUsageAge:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: IamUserUnusedCredentialsCheckParamMaxCredentialUsageAge
  redshiftClusterConfigurationCheckParamClusterDbEncrypted:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: RedshiftClusterConfigurationCheckParamClusterDbEncrypted
  redshiftClusterConfigurationCheckParamLoggingEnabled:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: RedshiftClusterConfigurationCheckParamLoggingEnabled
  redshiftClusterMaintenancesettingsCheckParamAllowVersionUpgrade:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: RedshiftClusterMaintenancesettingsCheckParamAllowVersionUpgrade
  restrictedIncomingTrafficParamBlockedPort1:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: RestrictedIncomingTrafficParamBlockedPort1
  restrictedIncomingTrafficParamBlockedPort2:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: RestrictedIncomingTrafficParamBlockedPort2
  restrictedIncomingTrafficParamBlockedPort3:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: RestrictedIncomingTrafficParamBlockedPort3
  restrictedIncomingTrafficParamBlockedPort4:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: RestrictedIncomingTrafficParamBlockedPort4
  restrictedIncomingTrafficParamBlockedPort5:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: RestrictedIncomingTrafficParamBlockedPort5
  s3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicAcls:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: S3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicAcls
  s3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicPolicy:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: S3AccountLevelPublicAccessBlocksPeriodicParamBlockPublicPolicy
  s3AccountLevelPublicAccessBlocksPeriodicParamIgnorePublicAcls:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: S3AccountLevelPublicAccessBlocksPeriodicParamIgnorePublicAcls
  s3AccountLevelPublicAccessBlocksPeriodicParamRestrictPublicBuckets:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: S3AccountLevelPublicAccessBlocksPeriodicParamRestrictPublicBuckets
  secretsmanagerSecretPeriodicRotationParamMaxDaysSinceRotation:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: SecretsmanagerSecretPeriodicRotationParamMaxDaysSinceRotation
  secretsmanagerSecretUnusedParamUnusedForDays:
    Fn::Not:
    - Fn::Equals:
      - ''
      - Ref: SecretsmanagerSecretUnusedParamUnusedForDays
EOT

}
