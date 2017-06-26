#!/bin/bash
module load mathematica/11.1
cat << EOF > test.m 
Print["Hello World"]
Do[Print[i, " - " , Sin[i]], {i, 0, Pi/2, 0.01}]
Exit[]
EOF
math -noprompt -run '<<test.m' > output.txt
if [ "$?" == 0 ]; then
        echo "SUCCESS"
else
        echo "TERROR ERROR!"
fi

