# Encrypt
A command line encryption engine.

1. Generate a secret:
```
./encrypt --action generate_secret
```
2. Save your secret
3. Encrypt a file:

```
./encrypt --file ./top_secret.txt --action encrypt --key $ENCRYPTION_SECRET
```
4. Decrypt a file

```
./encrypt --file ./top_secret.txt --action decrypt --key $ENCRYPTION_SECRET
```
