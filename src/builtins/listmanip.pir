=head1 List Utilities

Functions to manipulate lists

=head2 Functions

=over 4

=cut


=item treestep

 T [P]  ->  ...

Recursively traverses leaves of tree T, executes P for each leaf.

=cut

.sub 'treestep'
	.local pmc stack
	.local pmc p, t, tlist
	stack = get_global 'funstack'
	
	p = stack.'pop'('List')
	t = stack.'pop'('List')
	tlist = new "List"
	
loop:
	unless t goto travel_up
	$P0 = t.'shift'()
	
	$S0 = typeof $P0
	if $S0 == 'List' goto travel_down

	$P1 = '!@deepcopy'(p)
	stack.'push'($P0, $P1 :flat)
	goto loop

travel_down:
	tlist.'push'(t)
	t = $P0
	goto loop

travel_up:
	unless tlist goto end_loop
	t = tlist.'pop'()
	goto loop
	
end_loop:
.end

=back
=cut

