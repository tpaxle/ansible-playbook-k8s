{
  "Version": "2012-10-17",
  "Statement": [
     {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::061370748086:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "BoolIfExists": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
        "arn:aws:iam::${account}:role/vmware-dev-sso-limited",
        "arn:aws:iam::${account}:role/vmware-dev-sso-administrator"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
