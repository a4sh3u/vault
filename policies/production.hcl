path "sys/*" {
  policy = "deny"
}
path "production/*" {
  policy = "read"
}
