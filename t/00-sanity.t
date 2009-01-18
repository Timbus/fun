"1..11" .

#Test the core var types:
"ok 1" .
`ok 2` .
1 "ok 3" .
1.5 "ok 4" .
-1 "ok 5" .
-1.7 "ok 6" .
i "ok 7" .

user-func? ["ok 8"] ==
user-func? .

["ok 9"] user-func-2 ==
user-func-2 .

true false "ok 10" .

'a "ok 11" .