#! /bin/bash
#
# author: Timothy C. Arlen
#         tim.arlen@geniussports.com
#
# date:   14 February 2018
#
# Uploads local client labels to s3, and THEN also downloads any labels from s3
# to local client.
#

if [ $# -eq 0 ]
then
    echo 'No arguments supplied'
    usage=$0' <local_path_to_labels>'
    echo usage: $usage
    exit
fi

LOCAL_LABEL_PATH=$1

BUCKET_NAME=geniussports-computer-vision-data
S3_PATH=internal-experiments/basketball/bhjc/20180123/labels/
S3_URL=s3://$BUCKET_NAME/$S3_PATH

cmd='aws s3 sync $LOCAL_LABEL_PATH $S3_URL'
echo 'uploading local changes to s3...'
eval $cmd

cmd='aws s3 sync $S3_URL $LOCAL_LABEL_PATH'
echo 'uploading s3 changes to local...'
eval $cmd
