sslmd5key() {
  openssl rsa -noout -modulus | openssl md5 | tr -d '(stdin)= '
}

sslmd5crt() {
  openssl x509 -noout -modulus | openssl md5 | tr -d '(stdin)= '
}
