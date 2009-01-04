=head1 List Utilities

Functions to manipulate lists

=head2 Functions

=over 4

=cut


=item cons

 X A  ->  B

Aggregate B is A with a new member X (first member for sequences).

=cut

.sub 'cons'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('List', 'String')
	$S0 = typeof $P0
	if $S0 == 'String' goto cons_string
	
	$P1 = stack.'pop'()
	$P0.'unshift'($P1)
	.tailcall stack.'push'($P0)
	
cons_string:
	$S0 = stack.'pop'('Char')
	$S1 = $P0
	$S0 .= $S1
	.tailcall stack.'push'($S0)
.end

=item uncons

 A  ->  F R

F and R are the first and the rest of non-empty aggregate A.

=cut

.sub 'uncons'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('List', 'String')
	$S0 = typeof $P0
	if $S0 == 'String' goto uncons_string
	
	$P1 = shift $P0
	.tailcall stack.'push'($P1, $P0)
	
uncons_string:
	$S0 = $P0
	$S1 = substr $S0, 0, 1
	$S0 = substr $S0, 1
	.tailcall stack.'push'($S1, $S0)
.end

=item swons

 A X  ->  B

Aggregate B is A with a new member X at the front.

=cut

.sub 'swons'
	.local pmc stack
	stack = get_global 'funstack'
	
	#This isnt normally a good idea but it sure is for this situation.
	swap()
	
	$P0 = stack.'pop'('List', 'String')
	$S0 = typeof $P0
	if $S0 == 'String' goto swons_string
	
	$P0.'unshift'($P1)
	.tailcall stack.'push'($P0)
	
swons_string:
	$S0 = stack.'pop'('Char')
	$S1 = $P0
	$S0 .= $S1
	.tailcall stack.'push'($S0)
.end

=item unswons

 A  ->  R F

R and F are the rest and the first of non-empty aggregate A.

=cut

.sub 'uncons'
	.local pmc stack
	stack = get_global 'funstack'
	
	swap()
	
	$P0 = stack.'pop'('List', 'String')
	$S0 = typeof $P0
	if $S0 == 'String' goto unswons_string
	
	$P1 = shift $P0
	.tailcall stack.'push'($P1, $P0)
	
unswons_string:
	$S0 = $P0
	$S1 = substr $S0, 0, 1
	$S0 = substr $S0, 1
	.tailcall stack.'push'($S1, $S0)
.end

=item first

 A  ->  F

F is the first member of the non-empty aggregate A.

=cut

.sub 'first'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('List', 'String')
	$S0 = typeof $P0
	if $S0 == 'String' goto first_string
	
	$P0 = $P0[0]
	.tailcall stack.'push'($P0)
	
first_string:
	$S0 = $P0
	$S0 = substr $S0, 0, 1
	$P0 = new 'Char'
	$P0 = $S0
	.tailcall stack.'push'($P0)
.end

=item rest

 A  ->  R

R is the non-empty aggregate A with its first member removed.

=cut

.sub 'rest'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('List', 'String')
	$S0 = typeof $P0
	if $S0 == 'String' goto rest_string
	$P0.'shift'()
	.tailcall stack.'push'($P0)

rest_string:
	$S0 = $P0
	$S0 = substr $S0, 1
	.tailcall stack.'push'($S0)
.end

=item step

 A [P]  ->  ...

Sequentially pushes members of aggregate A onto the stack and executes P for each member of A pushed.

=cut

.sub 'step'
	.local pmc stack
	.local pmc p, a
	stack = get_global 'funstack'
	
	p = stack.'pop'('List')
	a = stack.'pop'('List', 'String')
	$S0 = typeof a
	if $S0 == 'List' goto loop_agg
	a = '!@mkchars'(a)
		
loop_agg:
	unless a goto loop_end
	$P0 = shift a
	##TODO: Make tests to see if this copy is required at all. For now, be safe.
	$P1 = '!@deepcopy'(p)
	stack.'push'($P0, $P1 :flat)
	goto loop_agg
loop_end:
.end

=item fold

 A V0 [P]  ->  ...

Starting with value V0, sequentially pushes members of aggregate A, and executes P for each member of A pushed.

=cut

.sub 'fold'
	.local pmc stack
	.local pmc a, v0, p
	stack = get_global 'funstack'
	
	p = stack.'pop'('List')
	v0 = stack.'pop'()
	a = stack.'pop'('List', 'String')
	stack.'push'(v0)
	
	$S0 = typeof a
	if $S0 == 'List' goto loop_agg
	a = '!@mkchars'(a)
	
loop_agg:
	unless a goto loop_end
	$P0 = shift a
	##TODO: Make tests to see if this copy is required at all. For now, be safe.
	$P1 = '!@deepcopy'(p)
	stack.'push'($P0, $P1 :flat)
	goto loop_agg
loop_end:
.end

=item map

 A [P]  ->  B

Executes P on each member of aggregate A, collects results in sametype aggregate B.

=cut

.sub 'map'
	.local pmc stack
	.local pmc p, a, b
	stack = get_global 'funstack'
	p = stack.'pop'('List')
	a = stack.'pop'('List')
	b = new 'List'

loop_agg:
	unless a goto loop_end
	$P0 = shift a
	##TODO: Make tests to see if this copy is required at all. For now, be safe.
	$P1 = '!@deepcopy'(p)
	stack.'makecc'()
	stack.'push'($P0, $P1 :flat)
	$P0 = stack.'pop'()
	push b, $P0
	stack.'exitcc'()
	goto loop_agg
loop_end:
	stack.'push'(b)
.end

=item split 

 A [P]  ->  A1 A2

Uses test P to split aggregate A into sametype aggregates A1 and A2.

=cut

.sub 'split'
	.local pmc stack
	.local pmc a, p, x1, x2
	stack = get_global 'funstack'
	p = stack.'pop'('List')
	a = stack.'pop'('List')
	x1 = new 'List'
	x2 = new 'List'
	
loop_agg:
	unless a goto loop_end
	$P0 = shift a
	##TODO: Make tests to see if this copy is required at all. For now, be safe.
	$P1 = '!@deepcopy'($P0)
	stack.'makecc'()
	$P2 = '!@deepcopy'(p)
	stack.'push'($P0, $P2 :flat)
	$I0 = stack.'pop'('Boolean')
	unless $I0 goto add_false
	push x1, $P1
	goto next
add_false:
	push x2, $P1
next:
	stack.'exitcc'()
	goto loop_agg
loop_end:
	stack.'push'(x1, x2)
.end

=item filter

 A [P]  ->  B

Uses test P to filter aggregate A producing sametype aggregate B.

=cut

.sub 'filter'
	.local pmc stack
	.local pmc a, p, b
	stack = get_global 'funstack'
	p = stack.'pop'('List')
	a = stack.'pop'('List')
	b = new 'List'
	
loop_agg:
	unless a goto loop_end
	$P0 = shift a
	$P1 = '!@deepcopy'($P0)
	stack.'makecc'()
	$P2 = '!@deepcopy'(p)
	stack.'push'($P0, $P2 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	
	unless $I0 goto loop_agg
	b.'push'($P1)
	goto loop_agg

loop_end:
	stack.'push'(b)
.end

=back
=cut
