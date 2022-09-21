output "build-index" {
  value       = random_string.build-index.result
  description = "The build-index used for naming"
}

output "website" {
  value       = "https://appacrappsvctest-${random_string.build-index.result}.azurewebsites.net"
  description = "Website URL"
}
