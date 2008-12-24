=head1 IO

Functions for reading and printing

=head2 Functions

=over 4

=cut

.namespace[]

=item put

 X ->  

Prints C<X> to stdout.

=cut

.sub 'put'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	$S0 = '!@mkstring'($P0)
	print $S0
	print "\n"
.end

=item putchars

 S ->  

Prints the string C<S> to stdout.

=cut

.sub 'putchars'
	.local pmc stack
	stack = get_global 'funstack'
	$S0 = stack.'pop'('String')
	print $S0
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
	$S0 = '!@mkstring'($P0)
	print $S0
.end

=back

