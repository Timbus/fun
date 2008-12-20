#fib [
#	--
#	0 1 rolldown	
#	[ dup swapd + ] times
#] ==

#12 fib .

fib [
	0 1
	[200 <]
	[
		dup swapd +
		dup tostring "Fibonacci number: " swap concat putchars
	] while
	pop pop
] ==