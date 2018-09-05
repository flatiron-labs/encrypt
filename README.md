# Encrypt
A command line encryption engine.
## Installation

`mix escript.install hex encrypt`

## Usage
1. Generate a secret:
```
~/.mix/escripts/encrypt --action generate_secret
```
2. Save your secret
3. Encrypt a file:

```
~/.mix/escripts/encrypt --file ./top_secret.txt --action encrypt --key $ENCRYPTION_SECRET
```
4. Decrypt a file

```
~/.mix/escripts/encrypt --file ./top_secret.txt --action decrypt --key $ENCRYPTION_SECRET
```
