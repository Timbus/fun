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
	say $S0
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


=item putchars

 S ->  

Prints the string C<S> to stdout.

=cut

.sub 'putchars'
	.local pmc stack
	stack = get_global 'funstack'
	$S0 = stack.'pop'('String')
	say $S0
.end


=item stdin

  ->  S

Pushes the standard input stream.

=cut

.sub 'stdin'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = getstdin
	stack.'push'($P0)
.end

=item stdout

  ->  S

Pushes the standard output stream.

=cut

.sub 'stdout'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = getstdout
	stack.'push'($P0)
.end

=item stderr

  ->  S

Pushes the standard error stream.

=cut

.sub 'stderr'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = getstderr
	stack.'push'($P0)
.end

=item fopen

 P M  ->  S

The file system object with pathname P is opened with mode M (a char, or string continaing any combination of r, w, a, and p) and stream object S is pushed; if the open fails, false is pushed.

=cut

.sub 'fopen'
	.local pmc stack
	stack = get_global 'funstack'
	$S0 = stack.'pop'('String', 'Char')
	$S1 = stack.'pop'('String')
	
	$P0 = open $S1, $S0
	.tailcall stack.'push'($P0)
.end

=back

