#!/bin/bash

# Create a text file to be signed
echo "Hello, this is the content to be signed." > data.txt

# Generate a self-signed certificate and private key (for demonstration purposes)
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -subj "/CN=Test Certificate"

# Hash the content of the text file and encode it in base64
openssl dgst -sha256 -binary < data.txt > digest.bin
base64digest=$(base64 < digest.bin)

# Save the base64-encoded digest to a text file
echo "$base64digest" > digest.txt

# Sign the hash using the private key and create a CMS Signed Data structure
openssl cms -sign -inkey key.pem -signer cert.pem -nodetach -in digest.txt -out signature.p7s

# Verify the signature
openssl cms -verify -in signature.p7s -inform PEM -content digest.txt -out verified.txt
openssl cms -verify -in signature.p7s -inform PEM -content digest.txt -out -out /dev/null 2>&1


# Compare the original content and the verified content
if cmp -s data.txt verified.txt; then
    echo "Signature verified successfully. Content is authentic."
else
    echo "Signature verification failed. Content may have been tampered with."
fi

# Clean up temporary files
rm data.txt digest.txt signature.p7s verified.txt key.pem cert.pem
rm data.txt digest.bin digest.txt signature.p7s verified.txt key.pem cert.pem

