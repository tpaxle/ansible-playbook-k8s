{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect" : "Allow",
            "Action" : [
                "firehose:*"
            ],
            "Resource" : [
                "arn:aws:firehose:${region}:${current_account_id}:*"
            ]
        },
        {
            "Effect" : "Allow",
            "Action" : [
                "iam:PassRole"
            ],
            "Resource" : [
                "${firehose_role_arn}"
            ]
        }
    ]
}