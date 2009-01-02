=head1 Operands

Simple math operators.

=cut

.namespace[]

.sub '+'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float')
	$P1 = stack.'pop'('Integer', 'Float')
	$P1 += $P0
	stack.'push'($P1)
	.return ()
.end

.sub '-'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float')
	$P1 = stack.'pop'('Integer', 'Float')
	$P1 -= $P0
	stack.'push'($P1)
	.return ()
.end

.sub '*'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float')
	$P1 = stack.'pop'('Integer', 'Float')
	$P1 *= $P0
	stack.'push'($P1)
	.return ()
.end

.sub '/'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float')
	$P1 = stack.'pop'('Integer', 'Float')
	$P1 /= $P0
	stack.'push'($P1)
	.return ()
.end

.sub '++'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float')
	inc $P0
	stack.'push'($P0)
	.return ()
.end

.sub '--'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float')
	dec $P0
	stack.'push'($P0)
	.return ()
.end


.sub 'mod'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float')
	$P1 = stack.'pop'('Integer', 'Float')
	
	mod $P1, $P0
	stack.'push'($P1)
.end

.sub 'rem'
	.tailcall 'mod'()
.end

.sub 'div'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer', 'Float')
	$I1 = stack.'pop'('Integer', 'Float')
	
	$I2 = $I1 / $I0 
	mod $I1, $I0
	
	stack.'push'($I2, $I1)
	.return()
.end

.sub 'sign'
	.local pmc stack, val
	stack = get_global 'funstack'
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

.sub 'abs'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer', 'Float')
	abs $I0
	stack.'push'($I0)
.end

.sub 'neg'
	.local pmc stack, val
	stack = get_global 'funstack'
	val = stack.'pop'('Integer', 'Float')
	val = val * -1
	stack.'push'($P0)
.end
