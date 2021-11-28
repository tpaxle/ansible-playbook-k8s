{
    "Version": "2012-10-17",
    "Id": "VaultKMSPolicy",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${aws_account}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow access for Key Administrators",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${aws_account}:role/${resource_prefix}-eks-administrator-${env}"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Enable Encrypt / Decrypt",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${aws_account}:role/${resource_prefix}-eks-worker-${env}"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:DescribeKey"
            ],
            "Resource": ["*"]
        },
        {
            "Sid": "Enable Encrypt / Decrypt",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${aws_account}:role/${resource_prefix}-${env}-sso-administrator"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:DescribeKey"
            ],
            "Resource": ["*"]
        },
        {
            "Sid": "Enable Encrypt / Decrypt",
            "Effect": "Allow",
            "Principal": {
              "AWS": "arn:aws:iam::585830602155:user/jenkins-platform"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:DescribeKey"
            ],
            "Resource": ["*"]
        }

    ]
}
