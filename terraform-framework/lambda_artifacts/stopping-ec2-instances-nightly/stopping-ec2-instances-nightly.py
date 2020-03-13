import boto3


# Notes
# Lambda Function
# Be sure to set the Lambda function timeout high enough (i.e. 1 minute) so that it can iterate through every instance in every region.
#
# CloudWatch Event Rule
# Cron expression: 0 23 ? * MON-FRI *
#
# 6:00pm EST (UTC-5) == 11:00pm (23:00) UTC
def lambda_handler(event, context):

    # Get list of regions
    ec2_client = boto3.client('ec2')
    regions = [region['RegionName']
               for region in ec2_client.describe_regions()['Regions']]

    # Iterate over each region
    for region in regions:
        ec2 = boto3.resource('ec2', region_name=region)

        print("Region:", region)

        # Get only running instances
        instances = ec2.instances.filter(
            Filters=[{'Name': 'instance-state-name',
                      'Values': ['running']}])

        # Stop the instances
        for instance in instances:
            instance.stop()
            print('Stopped instance: ', instance.id)