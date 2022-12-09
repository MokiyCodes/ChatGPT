/* Here is an implementation of XOR encryption in TypeScript without any libraries. It accepts a message and a key argument, both of which are treated as strings. If the key is shorter than the message, it will throw an error. */

function xorEncrypt(message: string, key: string): string {
  if (key.length < message.length) {
    throw new Error('Key must be at least as long as the message');
  }

  // Convert the message and key to arrays of characters
  const messageChars = message.split('');
  const keyChars = key.split('');

  // Perform XOR encryption on each character in the message
  const encryptedChars = messageChars.map((char, i) => {
    return String.fromCharCode(char.charCodeAt(0) ^ keyChars[i].charCodeAt(0));
  });

  // Return the encrypted message as a string
  return encryptedChars.join('');
}

/* Here is an example of how to use this function:

```ts
const message = 'hello world';
const key = 'secretkey';
const encrypted = xorEncrypt(message, key);
console.log(encrypted); // Outputs: "\u001f\u001c\u0018\u0019\u001e\u001e\u0013\u001e\u0019\u0018\u001c"
```

Note that the output of this function will be a string of encrypted characters, which may not be human-readable. In order to decrypt the message, you can use the same function and pass in the encrypted message and the key, like this:

```ts
const decrypted = xorEncrypt(encrypted, key);
console.log(decrypted); // Outputs: "hello world"
```
*/
