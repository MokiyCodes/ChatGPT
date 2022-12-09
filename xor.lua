-- require the bit32 library
local bit32 = require("bit32")

-- define a function to encrypt a string using XOR
function encrypt(str, key)
  -- throw an error if the key is shorter than the input string
  if #key < #str then
    error("Key is too short")
  end

  local result = ""

  -- iterate over each character in the string
  for i = 1, #str do
    -- get the ASCII code of the character and XOR it with the corresponding character in the key
    local charCode = string.byte(str, i)
    local keyCode = string.byte(key, i)
    charCode = bit32.bxor(charCode, keyCode)

    -- convert the XORed ASCII code back into a character and add it to the result string
    result = result .. string.char(charCode)
  end

  return result
end

-- define a function to decrypt a string using XOR
function decrypt(str, key)
  -- the decryption process is the same as the encryption process, so we can simply
  -- call the encrypt function with the encrypted string and the key as the inputs
  return encrypt(str, key)
end

-- test the encryption and decryption functions
local original = "hello world"
local key = "this is a secret key"
local encrypted = encrypt(original, key)
local decrypted = decrypt(encrypted, key)

print("original: " .. original)
print("encrypted: " .. encrypted)
print("decrypted: " .. decrypted)
