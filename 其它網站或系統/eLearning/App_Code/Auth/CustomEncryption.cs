using System;
using System.Security.Cryptography;
using System.Text;
using System.IO;

namespace CustomSecurity
{
    public sealed class CustomEncryption
    {
        private static string key = "sfdjf48mdfdf3054";

        public CustomEncryption()
        {
        }

        public static string Encrypt(String plainText)
        {
            string encrypted = null;
            try
            {
                byte[] inputBytes = ASCIIEncoding.ASCII.GetBytes(encode(plainText));
                byte[] pwdhash = null;
                MD5CryptoServiceProvider hashmd5;

                //generate an MD5 hash from the password. 
                //a hash is a one way encryption meaning once you generate
                //the hash, you cant derive the password back from it.
                hashmd5 = new MD5CryptoServiceProvider();
                pwdhash = hashmd5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(key));
                hashmd5 = null;

                // Create a new TripleDES service provider 
                TripleDESCryptoServiceProvider tdesProvider = new TripleDESCryptoServiceProvider();
                tdesProvider.Key = pwdhash;
                tdesProvider.Mode = CipherMode.ECB;

                encrypted = Convert.ToBase64String(
                    tdesProvider.CreateEncryptor().TransformFinalBlock(inputBytes, 0, inputBytes.Length));
            }
            catch (Exception e)
            {
                string str = e.Message;
                throw;
            }
            return encrypted;
        }

        public static String Decrypt(string encryptedString)
        {
            string decyprted = null;
            byte[] inputBytes = null;

            try
            {
                inputBytes = Convert.FromBase64String(encryptedString);
                byte[] pwdhash = null;
                MD5CryptoServiceProvider hashmd5;

                //generate an MD5 hash from the password. 
                //a hash is a one way encryption meaning once you generate
                //the hash, you cant derive the password back from it.
                hashmd5 = new MD5CryptoServiceProvider();
                pwdhash = hashmd5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(key));
                hashmd5 = null;

                // Create a new TripleDES service provider 
                TripleDESCryptoServiceProvider tdesProvider = new TripleDESCryptoServiceProvider();
                tdesProvider.Key = pwdhash;
                tdesProvider.Mode = CipherMode.ECB;

                decyprted = ASCIIEncoding.ASCII.GetString(
                    tdesProvider.CreateDecryptor().TransformFinalBlock(inputBytes, 0, inputBytes.Length));
            }
            catch (Exception e)
            {
                string str = e.Message;
                throw;
            }
            return decode(decyprted);
        }

        //½s½X
        public static string encode(String strData)
        {
            try { return System.Convert.ToBase64String(System.Text.UTF8Encoding.UTF8.GetBytes(strData)); }
            catch { return ""; }
        }

        //¸Ñ½X
        public static string decode(String strData)
        {
            try { return System.Text.UTF8Encoding.UTF8.GetString(System.Convert.FromBase64String(strData)); }
            catch { return ""; }
        }


        public static string Encrypt(string Message, String Passphrase)
        {
            byte[] Results;
            System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();

            // Step 1. We hash the passphrase using MD5
            // We use the MD5 hash generator as the result is a 128 bit byte array
            // which is a valid length for the TripleDES encoder we use below

            MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
            byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(Passphrase));

            // Step 2. Create a new TripleDESCryptoServiceProvider object
            TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();

            // Step 3. Setup the encoder
            TDESAlgorithm.Key = TDESKey;
            TDESAlgorithm.Mode = CipherMode.ECB;
            TDESAlgorithm.Padding = PaddingMode.PKCS7;

            // Step 4. Convert the input string to a byte[]
            byte[] DataToEncrypt = UTF8.GetBytes(Message);

            // Step 5. Attempt to encrypt the string
            try
            {
                ICryptoTransform Encryptor = TDESAlgorithm.CreateEncryptor();
                Results = Encryptor.TransformFinalBlock(DataToEncrypt, 0, DataToEncrypt.Length);
            }
            finally
            {
                // Clear the TripleDes and Hashprovider services of any sensitive information
                TDESAlgorithm.Clear();
                HashProvider.Clear();
            }

            // Step 6. Return the encrypted string as a base64 encoded string
            return Convert.ToBase64String(Results);
        }

        public static string Decrypt(string Message, string Passphrase)
        {
            byte[] Results;
            System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();

            // Step 1. We hash the passphrase using MD5
            // We use the MD5 hash generator as the result is a 128 bit byte array
            // which is a valid length for the TripleDES encoder we use below

            MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
            byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(Passphrase));

            // Step 2. Create a new TripleDESCryptoServiceProvider object
            TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();

            // Step 3. Setup the decoder
            TDESAlgorithm.Key = TDESKey;
            TDESAlgorithm.Mode = CipherMode.ECB;
            TDESAlgorithm.Padding = PaddingMode.PKCS7;

            // Step 4. Convert the input string to a byte[]
            byte[] DataToDecrypt = Convert.FromBase64String(Message);

            // Step 5. Attempt to decrypt the string
            try
            {
                ICryptoTransform Decryptor = TDESAlgorithm.CreateDecryptor();
                Results = Decryptor.TransformFinalBlock(DataToDecrypt, 0, DataToDecrypt.Length);
            }
            finally
            {
                // Clear the TripleDes and Hashprovider services of any sensitive information
                TDESAlgorithm.Clear();
                HashProvider.Clear();
            }

            // Step 6. Return the decrypted string in UTF8 format
            return UTF8.GetString(Results);
        }

        public static void Main(string[] args)
        {
            // The message to encrypt.
            string Msg = "This world is round, not flat, don't believe them!";
            string Password = "secret";

            string EncryptedString = Encrypt(Msg, Password);
            string DecryptedString = Decrypt(EncryptedString, Password);

            Console.WriteLine("Message: {0}", Msg);
            Console.WriteLine("Password: {0}", Password);
            Console.WriteLine("Encrypted string: {0}", EncryptedString);
            Console.WriteLine("Decrypted string: {0}", DecryptedString);
        }
    }
}