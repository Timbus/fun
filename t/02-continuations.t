"1..3" .
#Test a nested continuation that takes outer values to test lazy stack copies
"ok 3" "ok " 1 [ 2 [pop tostr concat] nullary put swapd tostr concat] binary put .
