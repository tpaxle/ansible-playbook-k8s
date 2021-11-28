{
    "Version" : "2012-10-17",
    "Statement" : [
        {
            "Sid" : "",
            "Effect" : "Allow",
            "Principal" : {
                "AWS" : "${current_account_id}"
            },
            "Action" : [
                "logs:PutSubscriptionFilter"
            ],
            "Resource" : [ "${log_destination_arn}" ]
        }
    ]
}