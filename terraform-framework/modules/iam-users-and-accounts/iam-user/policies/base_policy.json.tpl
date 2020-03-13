{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "iam:ChangePassword",
            "iam:*LoginProfile",
            "iam:*AccessKey*",
            "iam:*SSHPublicKey*"
         ],
         "Resource":"arn:aws:iam::${account_id}:user/$${aws:username}"
      },
      {
         "Effect":"Allow",
         "Action":[
            "iam:ListAccount*",
            "iam:GetAccountSummary",
            "iam:GetAccountPasswordPolicy",
            "iam:ListUsers",
            "iam:DeactivateMFADevice",
            "iam:DeleteVirtualMFADevice",
            "iam:ListVirtualMFADevices",
            "iam:ListMFADevices"
         ],
         "Resource":"*"
      },
      {
         "Effect":"Deny",
         "Action":"*",
         "Resource":"*",
         "Condition":{
            "NumericGreaterThan":{
               "aws:MultiFactorAuthAge":"28800"
            }
         }
      },
      {
         "Effect":"Allow",
         "Action":[
            "iam:ListVirtualMFADevices",
            "iam:ListMFADevices"
         ],
         "Resource":[
            "arn:aws:iam::${account_id}:mfa/*",
            "arn:aws:iam::${account_id}:user/$${aws:username}"
         ]
      },
      {
         "Sid": "AllowIndividualUserToManageTheirMFA",
         "Effect":"Allow",
         "Action":[
            "iam:CreateVirtualMFADevice",
            "iam:DeactivateMFADevice",
            "iam:DeleteVirtualMFADevice",
            "iam:EnableMFADevice",
            "iam:ResyncMFADevice"
         ],
         "Resource":[
            "arn:aws:iam::${account_id}:mfa/$${aws:username}",
            "arn:aws:iam::${account_id}:user/$${aws:username}"
         ]
      },
      {
         "Sid": "DoNotAllowAnythingOtherThanAboveUnlessMFAd",
         "Effect": "Deny",
         "NotAction": "iam:*",
         "Resource": "*",
         "Condition": {
            "Null": {
               "aws:MultiFactorAuthAge": "true"
            }
         }
      },
      {
        "Sid": "DenyEverythingExceptForBelowUnlessMFAd",
        "Effect": "Deny",
        "NotAction": [
            "iam:ListVirtualMFADevices",
            "iam:ListMFADevices",
            "iam:ListUsers",
            "iam:ListAccountAliases",
            "iam:CreateVirtualMFADevice",
            "iam:DeactivateMFADevice",
            "iam:DeleteVirtualMFADevice",
            "iam:EnableMFADevice",
            "iam:ResyncMFADevice",
            "iam:ChangePassword",
            "iam:CreateLoginProfile",
            "iam:DeleteLoginProfile",
            "iam:GetAccountPasswordPolicy",
            "iam:GetAccountSummary",
            "iam:GetLoginProfile",
            "iam:UpdateLoginProfile"
        ],
        "Resource": "*",
        "Condition": {
            "Null": {
                "aws:MultiFactorAuthAge": "true"
            }
        }
      }
   ]
}
