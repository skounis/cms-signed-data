#!/bin/bash

# Create a text file to be signed
echo "Hello, this is the content to be signed." > data.txt

# Generate a self-signed certificate and private key (for demonstration purposes)
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -subj "/CN=Test Certificate"

# Hash the content of the text file
hash=$(openssl dgst -sha256 -binary < data.txt)

# Sign the hash using the private key
signature=$(openssl rsautl -sign -inkey key.pem -keyform PEM -in <(echo -n "$hash"))

# Verify the signature
echo "$signature" | openssl rsautl -verify -inkey cert.pem -keyform PEM -pubin -in <(echo -n "$hash")

if [ $? -eq 0 ]; then
    echo "Signature verified successfully. Content is authentic."
else
    echo "Signature verification failed. Content may have been tampered with."
fi

# Clean up temporary files
rm data.txt key.pem cert.pem
