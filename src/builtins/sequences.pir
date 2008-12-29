=head1 Sequence Functions

Sequences are at the moment, lists and strings.
If any other form of sequence should be included, these functions will also work with them.

=head2 Functions

=over 4

=cut


=item concat

 S T  ->  U

Sequence U is the concatenation of sequences S and T.

=cut

.sub 'concat'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('String', 'List')
	$S0 = typeof $P0
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

Sequence U is the concatenation of sequences S and T with X inserted between S and T.
Equivalent to [swapd cons concat]

=cut

.sub 'enconcat'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('String', 'List')
	$S0 = typeof $P0
	$P1 = stack.'pop'($S0)
	
	if $S0 == 'String' goto enconcat_string

enconcat_array:
	$P2 = stack.'pop'()
	$P1.'push'($P2)
	$P1.'append'($P0)
	.tailcall stack.'push'($P1)
	
enconcat_string:
	$P2 = stack.'pop'('String')
	concat $P1, $P2
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
	value = stack.'pop'('String', 'List')
	$S0 = typeof value
	if $S0 == 'List' goto reverse_array
	isstr = 1
	$S0 = value
	value = split '', $S0
	
reverse_array:
	.local pmc revarray
	revarray = new 'List'
	
iter_loop:
	unless value goto iter_end
	$P0 = shift value
	unshift revarray, $P0
	goto iter_loop
iter_end:
	if isstr == 1 goto push_string
	.tailcall stack.'push'(revarray)

push_string:
	$S0 = join '', revarray
	.tailcall stack.'push'($S0)
.end

=item at

 S I  ->  X

X is the member of S at position I. (Same thing as S[I])

=cut

.sub 'at'
	.local pmc stack, value, pos
	stack = get_global 'funstack'
	pos = stack.'pop'('Integer')
	value = stack.'pop'('String', 'List')
	$S0 = typeof value
	if $S0 == 'String' goto at_string
	
	$P0 = value[pos]
	.tailcall stack.'push'($P0)
	
at_string:
	$S0 = value
	$I0 = pos
	$S0 = substr $S0, $I0, 1
	.tailcall stack.'push'($S0)
	
.end

=item of

 I S  ->  X

X is the I-th member of aggregate S. (Same thing as S[I])

=cut

.sub 'of'
	.local pmc stack, value, pos
	stack = get_global 'funstack'
	value = stack.'pop'('String', 'List')
	pos = stack.'pop'('Integer')
	$S0 = typeof value
	if $S0 == 'String' goto at_string
	
	$P0 = value[pos]
	.tailcall stack.'push'($P0)
	
at_string:
	$S0 = value
	$I0 = pos
	$S0 = substr $S0, $I0, 1
	.tailcall stack.'push'($S0)
	
.end

=item ord

 S  ->  I

Integer I is the ascii value of character C (taken from the first letter of the given string).

=cut

.sub 'ord'
	.local pmc stack
	stack = get_global 'funstack'
	$S0 = stack.'pop'('String')
	$I0 = ord $S0
	.tailcall stack.'push'($I0)
.end

=item chr

 I  ->  S

String S contains the character whose ascii value is I.

=cut

.sub 'chr'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer')
	$S0 = chr $I0
	.tailcall stack.'push'($S0)
.end

=back
=cut
