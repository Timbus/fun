recfib [
	[small] []
	[-- dup --]
	[+]
	binrec
] ==

iterfib [
	--
	0 1 rolldown	
	[ dup swapd + ] times
] ==

fib [
	0 1
	[200 <]
	[
		dup swapd +
		dup tostr "Fibonacci number: " swap concat putchars
	] while
	pop pop
] ==