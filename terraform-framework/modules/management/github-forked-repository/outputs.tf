output "full_name" {
  value = data.github_repository.repository.full_name
}

output "git_clone_url" {
  value = data.github_repository.repository.git_clone_url
}
