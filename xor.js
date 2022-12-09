// define a function to encrypt a string using XOR
function encrypt(str, key) {
  // throw an error if the key is shorter than the input string
  if (key.length < str.length) {
    throw new Error("Key is too short");
  }

  let result = "";

  // iterate over each character in the string
  for (let i = 0; i < str.length; i++) {
    // get the ASCII code of the character and XOR it with the corresponding character in the key
    let charCode = str.charCodeAt(i);
    let keyCode = key.charCodeAt(i);
    charCode = charCode ^ keyCode;

    // convert the XORed ASCII code back into a character and add it to the result string
    result += String.fromCharCode(charCode);
  }

  return result;
}

// define a function to decrypt a string using XOR
function decrypt(str, key) {
  // the decryption process is the same as the encryption process, so we can simply
  // call the encrypt function with the encrypted string and the key as the inputs
  return encrypt(str, key);
}

// test the encryption and decryption functions
const original = "hello world";
const key = "this is a secret key";
const encrypted = encrypt(original, key);
const decrypted = decrypt(encrypted, key);

console.log("original: " + original);
console.log("encrypted: " + encrypted);
console.log("decrypted: " + decrypted);
