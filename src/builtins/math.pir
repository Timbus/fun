=head1 Math

Functions for math type things

=head2 Functions

=over 4

=cut

.namespace[]

=item rand

 ->  I

Pushes a random integer.

=cut

.sub 'rand'
	.local pmc stack
	stack = get_global 'funstack'
	
	$P0 = get_global '!rand'
	unless null $P0 goto ret_rand
	$P0 = new 'Random'
	$I0 = time
	$P0 = $I0
	set_global '!rand', $P0
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
	stack = get_global 'funstack'
	
	seed = stack.'pop'('Integer')
	
	$P0 = get_global '!rand'
	unless null $P0 goto set_rand
	$P0 = new 'Random'
	set_global '!rand', $P0
set_rand:
	$P0 = seed
.end

=item acos

 F -> G

G is the arc cosine of F.

=cut

.sub 'acos'
	.local pmc stack
	stack = get_global 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = acos $N0
	.tailcall stack.'push'($N0)
.end

=item asin

 F -> G

G is the arc sine of F.

=cut

.sub 'asin'
	.local pmc stack
	stack = get_global 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = asin $N0
	.tailcall stack.'push'($N0)
.end

=item atan

 F -> G

G is the arc tangent of F.

=cut

.sub 'atan'
	.local pmc stack
	stack = get_global 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = atan $N0
	.tailcall stack.'push'($N0)
.end

=item atan

 F G -> H

H is the arc tangent of F / G.

=cut

.sub 'atan2'
	.local pmc stack
	stack = get_global 'funstack'
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
	stack = get_global 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = ceil $N0
	.tailcall stack.'push'($N0)
.end

=item cos

 F -> G

G is the cosine of F.

=cut

.sub 'cos'
	.local pmc stack
	stack = get_global 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = cos $N0
	.tailcall stack.'push'($N0)
.end

=item cosh

 F -> G

G is the hyperbolic cosine of F.

=cut

.sub 'cosh'
	.local pmc stack
	stack = get_global 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = cosh $N0
	.tailcall stack.'push'($N0)
.end

=item exp

 F -> G

G is e (2.718281828...) raised to the Fth power.

=cut

.sub 'exp'
	.local pmc stack
	stack = get_global 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	$N0 = exp $N0
	.tailcall stack.'push'($N0)
.end

=item floor

 F -> G

G is the floor of F.

=cut

.sub 'floor'
	.local pmc stack
	stack = get_global 'funstack'
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
	.local pmc stack, cfrexp
	stack = get_global 'funstack'
	$N0 = stack.'pop'('Float', 'Integer')
	cfrexp= get_global "cfrexp"
	$N0 = cfrexp($N0, $I0)
	.tailcall stack.'push'($N0, $I0)
.end

.sub '!!initfrexp' :anon :init
	.local pmc libc, cfrexp
	libc = loadlib "libc"
	cfrexp = dlfunc libc, "frexp", "dd3"
	set_global "cfrexp", cfrexp
.end

=back
=cut

