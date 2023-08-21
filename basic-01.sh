# Setup
mkdir -p work

# Create a self signet certificate
echo "1. Create a self signet certificate"
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout work/mycert.pem -out work/mycert.pem
# Create a CMS message
echo "2. Create a CMS message"
openssl cms -sign -in message.txt -text -out work/mail.msg -signer work/mycert.pem
# Verify a CMS message
echo "3. Verify a CMS message"
openssl cms -verify -in work/mail.msg -CAfile work/mycert.pem

# Clean up
rm ./work/*