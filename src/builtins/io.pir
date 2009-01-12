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

=item fseek

 S P W  ->  S

Stream S is repositioned to position P relative to the point W (0 for the start of the file, 1 for the current position, and 2 for the end of the file).

=cut

.sub 'fseek'
	.local pmc stack
	.local pmc w, p, fh
	stack = get_global 'funstack'
	w = stack.'pop'('Integer')
	p = stack.'pop'('Integer')
	fh = stack.'pop'('FileHandle')
	
	seek fh, $I1, $I2
	stack.'push'(fh)
.end

=item ftell

 S  ->  S I

I is the current position of stream S.

=cut

.sub 'ftell'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('FileHandle')
	
	$I0 = tell $P0
	stack.'push'($P0, $I0)
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
	.tailcall stack.'push'($P0, $P1)
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
	.tailcall stack.'push'($P0, $S0)
.end

=item fgetchars

 S  ->  S L

I bytes are read from the current position of stream S and returned as a string L.

=cut

.sub 'fgetchars'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer')
	$P0 = stack.'pop'('FileHandle')
	$S0 = read $P0, $I0
	.tailcall stack.'push'($P0, $S0)
.end

=item fread

 S I  ->  S L

I bytes are read from the current position of stream S and returned as the list of chars L.

=cut

.sub 'fread'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer')
	$P0 = stack.'pop'('FileHandle')
	$S0 = read $P0, $I0
	$P1 = '!@str2chars'($S0)
	.tailcall stack.'push'($P0, $P1)
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
	.tailcall stack.'push'($P0)
.end

=item feof

 S  ->  S B

B is the end-of-file status of stream S.

=cut

.sub 'feof'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('FileHandle')
	$I0 = $P0.'eof'()
	$P1 = new 'Boolean'
	$P1 = $I0
	.tailcall stack.'push'($P0, $P1)
.end

=item fprint

 S X  ->  S

The item X will be written to the current position of stream S.

=cut

.sub 'fprint'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	$S0 = '!@mkstring'($P0)
	$P0 = stack.'pop'('FileHandle')
	
	print $P0, $S0
	.tailcall stack.'push'($P0)
.end

=item fput

 S X  ->  S

The item X will be written to the current position of stream S, with an added trailing newline.

=cut

.sub 'fput'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	$S0 = '!@mkstring'($P0)
	$P0 = stack.'pop'('FileHandle')
	
	print $P0, $S0
	print $P0, "\n"
	.tailcall stack.'push'($P0)
.end

=item fwrite

 S L  ->  S

A list of integers or charcters are written as bytes to the current position of stream S.

=cut

.sub 'fwrite'
	.local pmc stack
	.local pmc l, fh
	.local string result
	stack = get_global 'funstack'
	l = stack.'pop'('List')
	fh = stack.'pop'('FileHandle')
	
loop:
	unless l goto loop_end
	$P0 = l.'shift'()
	$S0 = typeof $P0
	if $S0 == 'Integer' goto printint
	if $S0 == 'Char' goto printchar
	
	$S1 = "The type '"
	$S1 .= $S0 
	$S1 .= "' was found in the given list,\nbut a 'Char' or 'Integer' was expected."
	die $S1
	
printint:
	$I0 = $P0
	$S0 = chr $I0
	result .= $S0
	goto loop
printchar:
	$S0 = $P0
	result .= $S0
	goto loop

loop_end:
	print fh, result
	.tailcall stack.'push'(fh)
.end

=item fremove 

 P  ->  B

Removes the file or empty directory specified by the path P. B is a boolean indicating success or failure.

=cut

.sub 'fremove'
	.local pmc stack
	.local pmc os, ret
	stack = get_global 'funstack'
	$S0 = stack.'pop'('String')
	os = new 'OS'
	ret = new 'Boolean'
	
	push_eh rm_fail
	os.'rm'($S0)
	pop_eh
	
	ret = 1
	.tailcall stack.'push'($P0)
	
rm_fail:
	ret = 0
	.tailcall stack.'push'($P0)
.end

=item frename

 P1 P2  ->  B

The file system object with pathname P1 is renamed to P2. B is a boolean indicating success or failure.

=cut

.sub 'frename'
	.local pmc stack
	.local pmc file, ret
	stack = get_global 'funstack'
	$S0 = stack.'pop'('string')
	$S1 = stack.'pop'('string')
	file = new 'File'
	ret = new 'Boolean'
	
	push_eh mv_fail
	file.'rename'($S1, $S0)
	pop_eh
	
	ret = 1
	.tailcall stack.'push'($P0)
	
mv_fail:
	ret = 0
	.tailcall stack.'push'($P0)
	
.end

=back

