output "login" {
  # Again, the value is not important because we're just
  # using this for its dependencies.
  value = {}

  # Anything that refers to this output must wait until
  # the actions for helm_release.stable-prometheus-operator
  # to have completed first.
  depends_on = [null_resource.login]
}
