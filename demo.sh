#!/bin/bash

# Create a text file to be signed
echo "Hello, this is the content to be signed." > data.txt

# Generate a self-signed certificate and private key (for demonstration purposes)
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -subj "/CN=Test Certificate"

# Hash the content of the text file
openssl dgst -sha256 -binary < data.txt > digest.txt


# Sign the hash using the private key and create a CMS Signed Data structure
openssl cms -sign -in digest.txt -signer cert.pem -inkey key.pem -out signature.p7s

echo "-----BEGIN CMS-----" > signature.p7s.new
cat signature.p7s >> signature.p7s.new
echo "" >> signature.p7s.new # Add a newline character
mv signature.p7s.new signature.p7s

# Verify the signature
echo "Verifying ..."
openssl cms -verify -in signature.p7s -inform PEM -content digest.txt -out verified.txt

# Compare the original content and the verified content
if cmp -s data.txt verified.txt; then
    echo "Signature verified successfully. Content is authentic."
else
    echo "Signature verification failed. Content may have been tampered with."
fi

# Clean up temporary files
# rm data.txt digest.txt signature.p7s verified.txt key.pem cert.pem
