=head1 Private Functions

Contains useful private functions

=cut

.namespace[]

.sub '!@mklist'
    .param pmc fields :slurpy
    .return (fields)
.end

.sub '!@deepcopy'
	.param pmc val
	.local pmc valcpy
	
	$S0 = typeof val
	if $S0 == 'ResizablePMCArray' goto array_dup
	valcpy = clone val
	.return(valcpy)
	
#Iterate as much as possible. Recursion is expensive.
array_dup:
	.local pmc it
	it = iter val
	valcpy = new 'ResizablePMCArray'
	
iter_loop:
	unless it goto iter_end
	$P0 = shift it
	
	$S0 = typeof $P0
	if $S0 == 'ResizablePMCArray' goto follow_down
	
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

.sub '!@print_rec'
	.param pmc value
	.local string type
	type = typeof value
	if type == 'Boolean' goto print_bool
	if type == 'ResizablePMCArray' goto print_array
	
	print value
	goto finish
	
print_bool:
	if value == 1 goto print_true
	print "false"
	goto finish
print_true:
	print "true"
	goto finish
	
print_array:
	.local pmc it
	it = iter value
	print "["
	unless it goto iter_end
iter_loop:
	$P0 = shift it
	'!@print_rec'($P0) #Recursive way to follow lists
	unless it goto iter_end
	print " "
	goto iter_loop

iter_end:
	print "]"

finish:
.end


