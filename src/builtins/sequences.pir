=head1 Sequence Functions

Sequences are at the moment, lists and strings.
If any other form of sequence should be included, these functions will also work with them.

=head2 Functions

=over 4

=cut


=item concat

 S T  ->  U

Sequence U is the concatenation of same type sequences S and T.

=cut

.sub 'concat'
	.local pmc stack
	stack = get_global 'funstack'
	($P0, $S0) = stack.'pop'('String', 'List')
	$P1 = stack.'pop'($S0)

	if $S0 == 'String' goto concat_string
	
concat_array:
	$P1.'append'($P0)
	.tailcall stack.'push'($P1)

concat_string:
	concat $P1, $P0
	.tailcall stack.'push'($P1)
.end

=item enconcat

 X S T  ->  U

Sequence U is the concatenation of sequences S and T with element X inserted between S and T.
Equivalent to [swapd cons concat]

=cut

.sub 'enconcat'
	.local pmc stack
	stack = get_global 'funstack'
	($P0, $S0) = stack.'pop'('String', 'List')
	$P1 = stack.'pop'($S0)
	
	if $S0 == 'String' goto enconcat_string

enconcat_array:
	$P2 = stack.'pop'()
	$P1.'push'($P2)
	$P1.'append'($P0)
	.tailcall stack.'push'($P1)
	
enconcat_string:
	$S0 = stack.'pop'('Char')
	concat $P1, $S0
	concat $P1, $P0
	
	.tailcall stack.'push'($P1)
.end

=item reverse

 S  ->  R

Sequence R is the reverse of sequence S.

=cut

.sub 'reverse'
	.local pmc stack, value
	.local int isstr
	stack = get_global 'funstack'
	(value, $S0) = stack.'pop'('String', 'List')
	if $S0 == 'List' goto reverse_array
	isstr = 1

	value = '!@str2chars'(value)
	
reverse_array:
	.local pmc revarray
	revarray = new 'List'
	
iter_loop:
	unless value goto iter_end
	$P0 = shift value
	unshift revarray, $P0
	goto iter_loop
iter_end:
	unless isstr == 1 goto push_list
	$S0 = join '', revarray
	.tailcall stack.'push'($S0)
push_list:
	.tailcall stack.'push'(revarray)
.end

=item at

 S I  ->  X

X is the member of sequence S at position I.

=cut

.sub 'at'
	.local pmc stack, value, pos
	stack = get_global 'funstack'
	pos = stack.'pop'('Integer')
	(value, $S0) = stack.'pop'('String', 'List')
	if $S0 == 'String' goto at_string
	
	$P0 = value[pos]
	.tailcall stack.'push'($P0)
	
at_string:
	$S0 = value
	$I0 = pos
	$S0 = substr $S0, $I0, 1
	$P0 = new 'Char'
	$P0 = $S0
	.tailcall stack.'push'($P0)
	
.end

=item of

 I S  ->  X

X is the I-th member of aggregate S.

=cut

.sub 'of'
	.local pmc stack, value, pos
	stack = get_global 'funstack'
	(value, $S0) = stack.'pop'('String', 'List')
	pos = stack.'pop'('Integer')

	if $S0 == 'String' goto at_string
	
	$P0 = value[pos]
	.tailcall stack.'push'($P0)
	
at_string:
	$S0 = value
	$I0 = pos
	$S0 = substr $S0, $I0, 1
	$P0 = new 'Char'
	$P0 = $S0
	.tailcall stack.'push'($P0)
	
.end

=item ord

 C  ->  I

Integer I is the ascii value of character C. 
C can also be a string, and the first letter of the given string will be converted to an int.

=cut

.sub 'ord'
	.local pmc stack
	stack = get_global 'funstack'
	($P0, $S0) = stack.'pop'('String', 'Char')
	if $S0 == 'Char' goto push_char
	
	$S0 = $P0
	$I0 = ord $S0
	.tailcall stack.'push'($I0)
	
push_char:
	$I0 = $P0
	stack.'push'($I0)
.end

=item chr

 I  ->  C

Char C is the character whose ascii value is I.

=cut

.sub 'chr'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer')
	$P0 = new 'Char'
	$P0 = $I0
	.tailcall stack.'push'($P0)
.end

=back
=cut
