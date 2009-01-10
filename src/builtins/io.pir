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

=item fclose

 S  ->  

Stream S is closed and removed from the stack.

=cut

.sub 'fclose'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('FileHandle')
	close $P0
.end

=item fgetch

 S  ->  S C

C is the next available character from stream S.

=cut

.sub 'fgetch'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('FileHandle')
	$S0 = read $P0, 1
	$P1 = new 'Char'
	$P1 = $S0
	stack.'push'($P0, $P1)
.end

=item fgets

 S  ->  S L

L is the next available line (as a string) from stream S.

=cut

.sub 'fgets'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('FileHandle')
	$S0 = readline $P0
	stack.'push'($P0, $S0)
.end

=item fread

 S I  ->  S L

I bytes are read from the current position of stream S and returned as a string L.

=cut

.sub 'fread'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer')
	$P0 = stack.'pop'('FileHandle')
	$S0 = read $P0, $I0
	stack.'push'($P0, $S0)
.end

=item fflush

 S  ->  S

Flush stream S, forcing all buffered output to be written.

=cut

.sub 'fflush'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('FileHandle')
	$P0.'flush'()
	stack.'push'($P0)
.end

=back

