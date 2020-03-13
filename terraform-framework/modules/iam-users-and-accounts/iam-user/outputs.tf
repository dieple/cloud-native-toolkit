output "aws_iam_user_encrypted_password" {
  description = "A map of users and their temporary passwords encrypted with their pgp key"
  value       = "\n\n-----BEGIN PGP MESSAGE-----\n\n${aws_iam_user_login_profile.user.encrypted_password}\n\n-----END PGP MESSAGE-----\n"
}
