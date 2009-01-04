=head1 Private Functions

Contains useful private functions

=cut

.namespace[]

.sub '!@mklist'
    .param pmc fields :slurpy
	$P0 = new 'List'
	assign $P0, fields
    .return ($P0)
.end

.sub '!@mkchars'
	.param string arg
	.local pmc chars, ret

	chars = split '', arg
	ret = new 'ResizablePMCArray'
	
	.local pmc it, char
	it = iter chars
	
iter_loop:
	unless it goto iter_end
	$S0 = shift it
	char = new 'Char'
	char = $S0
	ret.'push'(char)
	goto iter_loop

iter_end:
	.return(ret)
.end

.sub '!@deepcopy'
	.param pmc val
	.local pmc valcpy
	
	$S0 = typeof val
	if $S0 == 'List' goto array_dup
	valcpy = clone val
	.return(valcpy)
	
#Iterate as much as possible. Recursion is expensive.
array_dup:
	.local pmc it
	it = iter val
	valcpy = new 'List'
	
iter_loop:
	unless it goto iter_end
	$P0 = shift it
	
	$S0 = typeof $P0
	if $S0 == 'List' goto follow_down
	
	$P0 = clone $P0
	goto push_val

follow_down:
	$P0 = '!@deepcopy'($P0)
	goto push_val

push_val:
	push valcpy, $P0
	goto iter_loop
	
iter_end:
	.return(valcpy)
.end

.sub '!@mkstring'
	.param pmc value
	.local string type, ret
	type = typeof value
	if type == 'Boolean' goto ret_bool
	if type == 'List' goto ret_array
	
	#Otherwise it'll translate just fine as-is.
	.return(value)
	
ret_bool:
	if value == 1 goto ret_true
	.return("false")
ret_true:
	.return("true")
	
ret_array:
	.local pmc it
	it = iter value
	ret = "["
	unless it goto iter_end
iter_loop:
	$P0 = shift it
	type = typeof $P0
	if type == 'Boolean' goto iter_retbool
	if type == 'List' goto iter_retarray
	
	$S0 = $P0
	ret .= $S0
	goto iter_next
	
iter_retbool:
	if $P0 == 1 goto iter_rettrue
	ret .= "false"
	goto iter_next
iter_rettrue:
	ret .= "true"
	goto iter_next
	
iter_retarray:
	$S0 = '!@mkstring'($P0) #Recursive way to follow lists
	ret .= $S0
	
iter_next:
	unless it goto iter_end
	ret .= " "
	goto iter_loop

iter_end:
	ret .= "]"
	.return(ret)
.end


.sub '!@arrays_equal'
	.param pmc ar1
	.param pmc ar2
	$I0 = ar1
	$I1 = ar2
	if $I0 != $I1 goto false

check_loop:
	unless ar1 goto true
	$P0 = shift ar1
	$P1 = shift ar2
	
	$S0 = typeof $P0
	if $S0 != 'List' goto simple_check
	$S0 = typeof $P1
	if $S0 != 'List' goto false
	$I0 = '!@arrays_equal'($P0, $P1)
	unless $I0 goto false
	goto check_loop
	
simple_check:
	if $P0 != $P1 goto false
	goto check_loop
	
#No need for a bool type, its not being pushed
true:
	.return(1)
false:
	.return(0)
.end

