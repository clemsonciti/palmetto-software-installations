#!/bin/bash
module load mono/5.2.0
cat << EOF > hello.cs 
// Hello1.cs
public class Hello1
{
   public static void Main()
   {
      System.Console.WriteLine("Hello, World!");
   }
}
EOF
mcs hello.cs
mono hello.exe
if [ "$?" == 0 ]; then
        echo "SUCCESS"
else
        echo "TERROR ERROR!"
fi
