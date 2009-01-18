'1..9' .

#Test the core var types:
"ok 1" .
1 'ok 2' .
1.5 'ok 3' .
-1 'ok 4' .
-1.5 'ok 5' .
i 'ok 6' .

user-func? ['ok 7'] ==
user-func? .

['ok 8'] user-func-2 ==
user-func-2 .

true false 'ok 9' .
