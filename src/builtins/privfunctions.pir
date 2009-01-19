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

.sub '!@str2chars'
	.param string arg
	.local pmc chars, ret

	chars = split '', arg
	ret = new 'List'
	
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

#Frankly this should just be removed and replaced with proper get_string methods on every pmc. Effort..
.sub '!@mkstring'
	.param pmc value
	.local string type
	
	type = typeof value
	if type == 'List' goto format_list
	if type == 'Boolean' goto format_bool
	
	$S0 = value
	.return($S0)
	
format_bool:
	if value == 1 goto str_true
	.return("false")
  str_true:
	.return("true")


format_list:
	.local string ret
	.local pmc llist, it
	llist = new 'List'

follow_list:
	it = iter value
	ret .= "["
	unless it goto list_next
	
iter_loop:
	$P0 = shift it
	type = typeof $P0
	if type == 'Boolean' goto iter_format_bool
	if type != 'List' goto iter_format_normal
	
	#Save the iter position.
	llist.'push'(it)
	value = $P0
	goto follow_list

iter_format_normal:
	$S0 = $P0
	ret .= $S0
	goto iter_next
	
iter_format_bool:
	if $P0 == 1 goto ret_str_true
	ret .= "false"
	goto iter_next
  ret_str_true:
	ret .= "true"
	goto iter_next
	
iter_next:
	unless it goto list_next
	ret .= " "
	goto iter_loop

list_next:
	ret .= "]"
	unless llist goto finish
	#Restore the old iter from the prior list.
	it = llist.'pop'()
	#Is the previous iter done? No need to go to iter_loop.
	unless it goto list_next
	#Print a space if theres more iterating to do.
	ret .=  " "
	goto iter_loop

finish:
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
	$S1 = typeof $P1
	
	if $S0 != $S1 goto false
	
	if $S0 != 'List' goto simple_check
	
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

