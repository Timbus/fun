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
	($P0, $S0) = stack.'pop'('List', 'String')
	
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
	($P0, $S0) = stack.'pop'('List', 'String')

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
	
	($P0, $S0) = stack.'pop'('List', 'String')
	
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

.sub 'unswons'
	.local pmc stack
	stack = get_global 'funstack'
	
	swap()
	
	($P0, $S0) = stack.'pop'('List', 'String')
	
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
	($P0, $S0) = stack.'pop'('List', 'String')
	
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
	($P0, $S0) = stack.'pop'('List', 'String')
	
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
	(a, $S0) = stack.'pop'('List', 'String')

	if $S0 == 'List' goto loop_agg
	a = '!@str2chars'(a)
		
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
	(a, $S0) = stack.'pop'('List', 'String')
	stack.'push'(v0)
	
	if $S0 == 'List' goto loop_agg
	a = '!@str2chars'(a)
	
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
	.local string type
	stack = get_global 'funstack'
	p = stack.'pop'('List')
	(a, type) = stack.'pop'('List', 'String')
	b = new 'List'

	if type == 'List' goto loop_agg
	a = '!@str2chars'(a)
	
loop_agg:
	unless a goto loop_end
	$P0 = a.'shift'()
	##TODO: Make tests to see if this copy is required at all. For now, be safe.
	$P1 = '!@deepcopy'(p)

	stack.'makecc'()
	stack.'push'($P0, $P1 :flat)

	#Make sure we're popping a char type if we're iterating a string.
	if type == 'String' goto safecheck
	$P0 = stack.'pop'()
	goto cont
safecheck:
	$P0 = stack.'pop'('Char')

cont:
	stack.'exitcc'()
	b.'push'($P0)
	goto loop_agg

loop_end:
	if type == 'String' goto sdone
	.tailcall stack.'push'(b)
	
sdone:
	$S0 = join '', b
	.tailcall stack.'push'($S0)
.end

=item split 

 A [P]  ->  A1 A2

Uses test P to split aggregate A into sametype aggregates A1 and A2.

=cut

.sub 'split'
	.local pmc stack
	.local pmc a, p, x1, x2
	.local string type
	stack = get_global 'funstack'
	p = stack.'pop'('List')
	(a, type) = stack.'pop'('List', 'String')
	x1 = new 'List'
	x2 = new 'List'
	
	if type == 'List' goto loop_agg
	a = '!@str2chars'(a)
	
loop_agg:
	unless a goto loop_end
	$P0 = shift a
	$P1 = '!@deepcopy'($P0)
	$P2 = '!@deepcopy'(p)
	
	stack.'makecc'()
	stack.'push'($P0, $P2 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	
	unless $I0 goto add_false
	push x1, $P1
	goto next
add_false:
	push x2, $P1
next:
	goto loop_agg
loop_end:
	if type == 'String' goto sdone
	.tailcall stack.'push'(x1, x2)

sdone:
	$S0 = join '', x1
	$S1 = join '', x2
	.tailcall stack.'push'($S0, $S1)
.end

=item filter

 A [P]  ->  B

Uses test P to filter aggregate A producing sametype aggregate B.

=cut

.sub 'filter'
	.local pmc stack
	.local pmc a, p, b
	.local string type
	stack = get_global 'funstack'
	p = stack.'pop'('List')
	(a, type) = stack.'pop'('List', 'String')
	b = new 'List'

	if type == 'List' goto loop_agg
	a = '!@str2chars'(a)
	
loop_agg:
	unless a goto loop_end
	$P0 = shift a
	$P1 = '!@deepcopy'($P0)
	$P2 = '!@deepcopy'(p)
	
	stack.'makecc'()
	stack.'push'($P0, $P2 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	
	unless $I0 goto loop_agg
	b.'push'($P1)
	goto loop_agg

loop_end:
	if type == 'String' goto sdone
	.tailcall stack.'push'(b)

sdone:
	$S0 = join '', b
	.tailcall stack.'push'($S0)
.end

=item any

 A [P]  ->  X

Applies test P to members of aggregate A, X = true if any pass.

=cut

.sub 'any'
	.local pmc stack
	.local pmc a, p, x
	.local string type
	stack = get_global 'funstack'
	
	p = stack.'pop'('List')
	(a, type) = stack.'pop'('List', 'String')
	x = new 'Boolean'

	if type == 'List' goto loop_agg
	a = '!@str2chars'(a)
	
loop_agg:
	unless a goto ret_false
	$P0 = shift a
	$P1 = '!@deepcopy'(p)
	stack.'push'($P0, $P1 :flat)
	$I0 = stack.'pop'('Boolean')
	if $I0 == 0 goto loop_agg
	
	x = 1
	.tailcall stack.'push'(x)

ret_false:
	x = 0
	.tailcall stack.'push'(x)
.end

=item all

 A [P]  ->  X

Applies test P to members of aggregate A, X = true if all pass.

=cut

.sub 'all'
	.local pmc stack
	.local pmc a, p, x
	.local string type
	stack = get_global 'funstack'
	
	p = stack.'pop'('List')
	(a, type) = stack.'pop'('List', 'String')
	x = new 'Boolean'

	if type == 'List' goto loop_agg
	a = '!@str2chars'(a)
	
loop_agg:
	unless a goto ret_true
	$P0 = shift a
	$P1 = '!@deepcopy'(p)
	stack.'push'($P0, $P1 :flat)
	$I0 = stack.'pop'('Boolean')
	if $I0 == 1 goto loop_agg
	
	x = 0
	.tailcall stack.'push'(x)

ret_true:
	x = 1
	.tailcall stack.'push'(x)
.end

=item drop

 A N  ->  B

Aggregate B is the result of deleting the first N elements of A.

=cut

.sub 'drop'
	.local pmc stack
	.local pmc a
	.local int n
	.local string type
	stack = get_global 'funstack'
	n = stack.'pop'('Integer')
	if n < 0 goto drop_negative
	
	(a, type) = stack.'pop'('List', 'String')
	if type == 'List' goto drop_list
	
	$S0 = a
	$I0 = length $S0
	if n > $I0 goto drop_too_many 
	$S0 = substr $S0, n
	.tailcall stack.'push'($S0)
	
drop_list:
	$P0 = new 'List'
	splice a, $P0, 0, n
	.tailcall stack.'push'(a)
	
drop_negative:
	die "Trying to drop a negative number of elements."
	
drop_too_many:
	die "Trying to drop more elements than the aggregate even holds."
.end

=item take

 A N  ->  B

Aggregate B is the result of retaining just the first N elements of A.

=cut

.sub 'take'
	.local pmc stack
	.local pmc a
	.local int n
	.local string type
	stack = get_global 'funstack'
	n = stack.'pop'('Integer')
	if n < 0 goto take_negative
	
	(a, type) = stack.'pop'('List', 'String')
	if type == 'List' goto take_list
	
	$S0 = a
	$I0 = length $S0
	if n > $I0 goto take_too_many 
	$S0 = substr $S0, 0, n
	.tailcall stack.'push'($S0)
	
take_list:
	$I0 = a
	if n > $I0 goto take_too_many 
	#Just setting the new length will effectivly chop off the end elements.
	a = n
	.tailcall stack.'push'(a)
		
take_negative:
	die "Trying to take a negative number of elements."
	
take_too_many:
	die "Trying to take more elements than the aggregate even holds."
.end


=back
=cut

