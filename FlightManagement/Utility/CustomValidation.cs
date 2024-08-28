using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace FlightManagement.Utility
{
    
    
        public class CustomValidation
        {
            //username should not be empty
            //username should contain only letters,numbers,underscores,anddot
            public static bool IsValidUserName(string userName)
            {
                return !string.IsNullOrWhiteSpace(userName) &&
                    Regex.IsMatch(userName, @"^[a-zA-Z0-9_.]+$");
            }
            //PASSWORD SHOULD HAVE ATLEAST 4 CHARACTERS
            //INCLUDING ATLEAST ONE UPPERCASE LETTER,ONE LOWERCASE
            //ONE DIGIT,AND ONE SPECIAL CHARCTER

            public static bool IsValidPassword(string password)
            {
                return !string.IsNullOrWhiteSpace(password) && Regex.IsMatch(password, @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{4,}$");
            }
            //REPLACE ALPHABETS WITH * SYMBOL FOR PASSWORD
            public static string ReadPassword()
            {
                string password = "";
                ConsoleKeyInfo key;
                do
                {
                    key = Console.ReadKey(true);
                    //1 each keystroke fromthe user,replaces it
                    //with an astrisk(*)
                    //and add it to the password string
                    //untill the user pressetrue the enter key
                    if (key.Key != ConsoleKey.Backspace && key.Key != ConsoleKey.Enter)
                    {
                        password += key.KeyChar;
                        Console.Write('*');
                    }
                    else if (key.Key == ConsoleKey.Backspace && password.Length > 0)
                    {

                        password = password.Substring(0, password.Length - 1);
                        Console.Write("\b \b");
                    }
                }
                while (key.Key != ConsoleKey.Enter);
                Console.WriteLine();
                return password;
            }
        }
    }
