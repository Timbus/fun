=head1 IO

Functions for reading and printing

=head2 Functions

=over 4

=cut

.namespace[]

=item say

 X ->  

Prints C<X> to stdout. Uses the same format as '.' does.

=cut

.sub 'putchars'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	'!@print_rec'($P0)
	print "\n"
.end

=item print

 X ->  

Prints C<X> to stdout. Does not add a newline

=cut

.sub 'print'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	'!@print_rec'($P0)
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

=back

