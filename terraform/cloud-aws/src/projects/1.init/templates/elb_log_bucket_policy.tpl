{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSELBLogPolicy",
      "Action": "s3:PutObject",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${elb_account_id}"
      },
      "Resource": "arn:aws:s3:::${bucket_name}/*"
    }
  ]
}
