from __future__ import print_function
import os
import boto3
import urllib

print("Loading Image Copy Lambda")
s3_move = boto3.client('s3')

def lambda_handler(event, context):
    source_bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'])
    target_bucket = os.environ['DESTINATION_BUCKET']
    copy_source = {'Bucket': source_bucket, 'Key':key}
    try:
        print("Waiting for file to persist source s3 SVP Images bucket")
        waiter = s3_move.get_waiter('object_exists')
        waiter.wait(Bucket=source_bucket, Key=key)
        image_key = "{0}/{1}".format(os.environ['IMAGE_PREFIX'],key) # Remove share/ part of key
        print("Moving image file {0} from Source s3 to temporary svp image Target s3".format(key))
        if key.find(os.environ['IMAGE_PREFIX']) == -1:
            s3_move.copy_object(Bucket=target_bucket, Key=image_key, CopySource=copy_source)
        print("Completed Image File {0} Move to image prefix".format(key))
    except Exception as e:
        print(e)
        print("Error getting object")
        raise e
