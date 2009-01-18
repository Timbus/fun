"1..11" .
#Test lists and simple (no continuation) ways of running them
["ok 1"] i .
["ok "] x "2" concat swap i "3" concat swap . .
"ok 4" ['ok 5'] dip . .

#Now for continuation combinators
"ok 6" "fail 6" [pop] nullary .

"ok 9" 6 2 ["ok " print ++ dup put] times pop .

1 [1 =] ["ok 10"] ["fail 10"] ifte .
1 1 + [3 <] ["ok 11"] ["fail 11"] ifte .
