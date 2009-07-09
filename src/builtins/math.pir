=head1 Math

Functions for math type things

=head2 Functions

=over 4

=cut

.namespace[]

=item rand

 ->  I

Pushes a random integer. Will seed the generator if it's not already seeded.

=cut

.sub 'rand'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	
	$P0 = get_hll_global ['Math'; 'Rand'], 'rand'
	unless null $P0 goto ret_rand
	load_bytecode 'library/Math/Rand.pbc'
	$P0 = get_hll_global ['Math'; 'Rand'], 'srand'
	$I0 = time
	$P0($I0)
	#Rand should now exist.
	$P0 = get_hll_global ['Math'; 'Rand'], 'rand'
ret_rand:
	$I0 = $P0
	.tailcall stack.'push'($I0)
.end

=item srand

 I  ->

Takes an integer to set the random generator seed.

=cut

.sub 'srand'
	.local pmc stack, seed
	stack = get_hll_global ['private'], 'funstack'

	seed = stack.'pop'('Integer')

	$P0 = get_hll_global ['private'], 'srand'
	unless null $P0 goto set_rand
	load_bytecode 'library/Math/Rand.pbc'
	$P0 = get_hll_global ['Math'; 'Rand'], 'srand'
set_rand:
	$P0(seed)
.end

=item acos

 F  ->  G

G is the arc cosine of F.

=cut

.sub 'acos'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = acos $N0
	.tailcall stack.'push'($N0)
.end

=item asin

 F  ->  G

G is the arc sine of F.

=cut

.sub 'asin'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = asin $N0
	.tailcall stack.'push'($N0)
.end

=item atan

 F  ->  G

G is the arc tangent of F.

=cut

.sub 'atan'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = atan $N0
	.tailcall stack.'push'($N0)
.end

=item atan

 F G  ->  H

H is the arc tangent of F / G.

=cut

.sub 'atan2'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N1 = stack.'pop'('Float', 'Integer')
	$N0 = atan $N1, $N0
	.tailcall stack.'push'($N0)
.end

=item ceil

 F  ->  G

G is the float ceiling of F.

=cut

.sub 'ceil'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = ceil $N0
	.tailcall stack.'push'($N0)
.end

=item cos

 F  ->  G

G is the cosine of F.

=cut

.sub 'cos'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = cos $N0
	.tailcall stack.'push'($N0)
.end

=item cosh

 F  ->  G

G is the hyperbolic cosine of F.

=cut

.sub 'cosh'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = cosh $N0
	.tailcall stack.'push'($N0)
.end

=item exp

 F  ->  G

G is e (2.718281828...) raised to the Fth power.

=cut

.sub 'exp'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = exp $N0
	.tailcall stack.'push'($N0)
.end

=item floor

 F  ->  G

G is the floor of F.

=cut

.sub 'floor'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = floor $N0
	.tailcall stack.'push'($N0)
.end

=item frexp

 F  ->  G I

G is the mantissa and I is the exponent of F.
Unless F = 0, 0.5 <= abs(G) < 1.0.

=cut

.sub 'frexp'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')	
	$N0 = frexp $N0, $I0
	.tailcall stack.'push'($N0, $I0)
.end

=item ldexp

 F I  ->  G

G is F times 2 to the Ith power.

=cut

.sub 'ldexp'
	.local pmc stack, cfrexp
	stack = get_hll_global ['private'], 'funstack'
	$I0 = stack.'pop'('Integer')
	$N0 = stack.'pop'('Float', 'Integer')
	$N1 = pow 2, $I0
	$N0 = $N0 * $N1
	.tailcall stack.'push'($N0)
.end

=item log

 F  ->  G

G is the natural logarithm of F.

=cut

.sub 'log'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = log2 $N0
	.tailcall stack.'push'($N0)
.end

=item log10

 F  ->  G

G is the common logarithm of F.

=cut

.sub 'log10'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = log10 $N0
	.tailcall stack.'push'($N0)
.end

=item modf

 F  ->  G H

G is the fractional part and H is the integer part (expressed as a float) of F.

=cut

.sub 'modf'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$I0 = $N0
	$N1 = $N0 - $I0
	$N0 = $I0
	stack.'push'($N1, $N0)
.end

=item pow

 F G  ->  H

H is F raised to the Gth power.

=cut

.sub 'pow'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N1 = stack.'pop'('Float', 'Integer')
	$N0 = pow $N1, $N0
	.tailcall stack.'push'($N0)
.end

=item sin

 F  ->  G

G is the sine of F.

=cut

.sub 'sin'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = sin $N0
	.tailcall stack.'push'($N0)
.end

=item sinh

 F  ->  G

G is the hyperbolic sine of F.

=cut

.sub 'sinh'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = sinh $N0
	.tailcall stack.'push'($N0)
.end

=item sqrt

 F  ->  G

G is the square root of F.

=cut

.sub 'sqrt'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = sqrt $N0
	.tailcall stack.'push'($N0)
.end

=item tan

 F  ->  G

G is the tangent of F.

=cut

.sub 'tan'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = tan $N0
	.tailcall stack.'push'($N0)
.end

=item tanh

 F  ->  G

G is the hyperbolic tangent of F.

=cut

.sub 'tanh'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = tanh $N0
	.tailcall stack.'push'($N0)
.end

=item trunc

 F  ->  I

I is an integer equal to the truncated float F.

=cut

.sub 'trunc'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$I0 = $N0
	.tailcall stack.'push'($I0)
.end

=back
=cut

