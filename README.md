# CMS Signed Data Example
CMS (Cryptographic Message Syntax) Signed Data structure example

## Background

CMS (Cryptographic Message Syntax) Signed Data structure is a format defined by the Cryptographic Message Syntax standard (often referred to as PKCS #7, or RFC 5652) for creating digitally signed messages. It is commonly used to sign and authenticate data in various security applications, such as secure email, code signing, and digital document verification.

The CMS Signed Data structure allows you to achieve the following:

1. **Message Digest Calculation**: The content to be signed is hashed (usually using a cryptographic hash function like SHA-256) to generate a message digest. This digest ensures the integrity of the content being signed.

2. **Signing**: The message digest is then encrypted using the private key of the signer to create a digital signature. This signature is attached to the original content along with information about the signer's certificate.

3. **Certificate Inclusion**: The signer's X.509 digital certificate can also be included in the CMS Signed Data structure. This certificate contains the signer's public key and additional information, allowing recipients to verify the signer's identity and use their public key to validate the signature.

4. **Optional Data**: The CMS structure can also include optional attributes like signing time, countersignatures (signatures of previously signed data), and more.

When a recipient receives a CMS Signed Data structure, they can verify the authenticity and integrity of the content by performing the following steps:

1. Verify the signer's certificate.
2. Extract the signature from the CMS structure.
3. Hash the content of the message and compare the calculated digest to the decrypted signature.
4. If the digests match, the content has not been tampered with, and the signature is valid.

Overall, the CMS Signed Data structure provides a standardized way to ensure the security and authenticity of data through digital signatures, making it a fundamental component of modern digital communication and security protocols.

## Demos

### Use self signed certificate containing the private key
```bash
make demo1
```

### Use self signed certificate and private key seperately 
```bash
make demo2
```
