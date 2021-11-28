{
    "Version": "2012-10-17",
    "Id": "S3BucketPolicyML",
    "Statement": [
        {
            "Sid": "Allow Read Write",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${aws_account}:role/${resource_prefix}-eks-worker-${env}"
            },
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${bucket_name}/*",
                "arn:aws:s3:::${bucket_name}"
            ]
        }
    ]
}
