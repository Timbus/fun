'1..9' .
#Test lists and simple (no continuation) ways of running them
["ok 1"] i .
["ok "] x "2" concat swap i "3" concat swap . .
"ok 4" ['ok 5'] dip . .

#Now for continuation combinators
"ok 6" "fail 6" [pop] nullary .

"ok 9" 6 2 ["ok " print ++ dup putchars] times pop .