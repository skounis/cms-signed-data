# Setup
mkdir -p work
# Generate a private-public key pair
echo "1. Create a self signet certificate"
openssl genrsa -out work/keypair.pem 2048

# Extract the public part
echo "2. Extract the public part"
openssl rsa -in work/keypair.pem -pubout -out work/publickey.crt

# Create a self-signed certificate
echo "3. Create a self-signed certificate"
openssl req -new -x509 -key work/keypair.pem -out work/mycert.pem

# Create a CMS message
echo "4. Create a CMS message"
openssl cms -sign -in message.txt -text -out work/mail.msg -signer work/mycert.pem -inkey work/keypair.pem

# Verify a CMS message
echo "5. Verify a CMS message"
openssl cms -verify -in work/mail.msg -CAfile work/mycert.pem

# Clean up
rm ./work/*