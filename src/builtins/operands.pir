=head1 Operands

Simple math operators.

=head2 Functions

=over 4

=cut

.namespace[]

=item +

 I J  ->  K

K is the result of adding J to I.

=cut

.sub '+'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	($P0, $S0) = stack.'pop'('Integer', 'Float', 'Char')
	
	if $S0 == 'Float' goto addfloat
	if $S0 == 'Char' goto addchar

	$P1 = stack.'pop'('Integer', 'Float', 'Char')
	#If S0 is an int, $P0 can be added just fine.
	$P1 += $P0
	.tailcall stack.'push'($P1)
	
addfloat:
	$P1 = stack.'pop'('Integer', 'Float')
	$P0 += $P1
	.tailcall stack.'push'($P0)
	
addchar:
	$P1 = stack.'pop'('Integer', 'Char')
	$P0 += $P1
	.tailcall stack.'push'($P0)
.end

=item -

 I J  ->  K

K is the result of subtracting J from I.

=cut

.sub '-'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	($P0, $S0) = stack.'pop'('Integer', 'Float', 'Char')
	
	if $S0 == 'Float' goto subfloat
	if $S0 == 'Char' goto subchar

	$P1 = stack.'pop'('Integer', 'Float', 'Char')
	#If S0 is an int, $P0 can be added just fine.
	$P1 -= $P0
	.tailcall stack.'push'($P1)
	
subfloat:
	$P1 = stack.'pop'('Integer', 'Float')
	$P0 -= $P1
	.tailcall stack.'push'($P0)
	
subchar:
	$P1 = stack.'pop'('Integer', 'Char')
	$P0 -= $P1
	.tailcall stack.'push'($P0)	
.end

=item *

 I J  ->  K

K is the result of multiplying I by J.

=cut

.sub '*'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float')
	$P1 = stack.'pop'('Integer', 'Float')
	$P1 *= $P0
	.tailcall stack.'push'($P1)
.end

=item /

 I J  ->  K

K is the result of dividing I by J.

=cut

.sub '/'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float')
	$P1 = stack.'pop'('Integer', 'Float')
	$P1 /= $P0
	.tailcall stack.'push'($P1)
.end

=item ++

 N  ->  N+1

Gives the numeric successor of N.

=cut

.sub '++'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'Char')
	inc $P0
	.tailcall stack.'push'($P0)
.end

=item --

 N  ->  N-1

Gives the numeric predecessor of N.

=cut

.sub '--'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'Char')
	dec $P0
	.tailcall stack.'push'($P0)
.end

=item mod

 I J  ->  K

Integer K is the remainder of dividing I by J.

=cut

.sub 'mod'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float')
	$P1 = stack.'pop'('Integer', 'Float')
	
	mod $P1, $P0
	.tailcall stack.'push'($P1)
.end

.sub 'rem'
	.tailcall 'mod'()
.end

=item div

 I J  ->  K L

Integers K and L are the quotient and remainder of dividing I by J.

=cut

.sub 'div'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$I0 = stack.'pop'('Integer', 'Float')
	$I1 = stack.'pop'('Integer', 'Float')
	
	$I2 = $I1 / $I0 
	mod $I1, $I0
	
	.tailcall stack.'push'($I2, $I1)
.end

=item sign

 N  ->  S

S is the sign (-1 or 0 or +1) of numeric N

=cut

.sub 'sign'
	.local pmc stack, val
	stack = get_hll_global ['private'], 'funstack'
	val = stack.'pop'('Integer', 'Float')
	
	if val < 0 goto negative
	if val > 0 goto positive

	val = 0
	.tailcall stack.'push'(val)
	
negative:
	val = -1
	.tailcall stack.'push'(val)
	
positive:
	val = 1
	.tailcall stack.'push'(val)
.end

=item neg

 N  ->  +N

Returns the absolute value of numeric N

=cut

.sub 'abs'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$I0 = stack.'pop'('Integer', 'Float')
	abs $I0
	.tailcall stack.'push'($I0)
.end

=item neg

 N  ->  -N

Returns the negative value of numeric N

=cut

.sub 'neg'
	.local pmc stack, val
	stack = get_hll_global ['private'], 'funstack'
	val = stack.'pop'('Integer', 'Float')
	val = val * -1
	.tailcall stack.'push'($P0)
.end

=item max

 N1 N2  ->  N

N is the maximum of numeric values N1 and N2.  Also supports char.

=cut

.sub 'max'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'Char')
	$P1 = stack.'pop'('Integer', 'Float', 'Char')
	
	if $P0 > $P1 goto rightval
	.tailcall stack.'push'($P1)
rightval:
	.tailcall stack.'push'($P0)
.end

=item min

 N1 N2  ->  N

N is the minimum of numeric values N1 and N2.  Also supports char.

=cut

.sub 'min'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'Char')
	$P1 = stack.'pop'('Integer', 'Float', 'Char')
	
	if $P0 < $P1 goto rightval
	.tailcall stack.'push'($P1)
rightval:
	.tailcall stack.'push'($P0)
.end

=back
=cut

