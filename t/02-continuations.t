'1..3' .
#Test a nested continuation that takes nested outer values to test nested lazy stack copies
"ok 3" "ok " 1 [ 2 [pop tostring concat] nullary put swapd tostring concat] binary put .

