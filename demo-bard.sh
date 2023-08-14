# Create a file containing the data to be signed.
echo "This is the data to be signed." > data.txt

# Generate a key pair.
openssl genrsa -out private.key 2048
openssl rsa -in private.key -pubout -out public.key

# Sign the data using the private key.
openssl cms -sign -in data.txt -out signed.cms -signer private.key

# Verify the signature using the public key.
openssl cms -verify -in signed.cms -signer public.key
