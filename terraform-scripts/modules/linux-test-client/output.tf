output "linux_text_client" {
    value = {
        instance = aws_instance.linux-test-client,
        sg = aws_security_group.ltc-admin
  }
}