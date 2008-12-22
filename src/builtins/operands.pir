=head1 Operands

Simple math ops and predicates.

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


.sub '<'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	$P2 = 0
	
	if $P1 < $P0 goto true
	goto false
true:
	$P2 = 1
false:
	stack.'push'($P2)
	.return ()
.end

.sub '>'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	$P2 = 0
	
	if $P1 > $P0 goto true
	goto false
true:
	$P2 = 1
false:
	stack.'push'($P2)
	.return ()
.end

.sub '='
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	$P2 = 1
	
	if $P1 == $P0 goto true
	$P2 = 0
true:
	stack.'push'($P2)
	.return ()
.end

.sub '!='
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	$P2 = 1
	
	if $P1 != $P0 goto true
	$P2 = 0
true:
	stack.'push'($P2)
	.return ()
.end

.sub '<='
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	$P2 = 0
	
	if $P1 <= $P0	goto true
	goto false
true:
	$P2 = 1
false:
	stack.'push'($P2)
	.return ()
.end

.sub '>='
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	$P2 = 0
	
	if $P1 >= $P0 goto true
	goto false
true:
	$P2 = 1
false:
	stack.'push'($P2)
	.return ()
.end


.sub 'or'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer', 'Float', 'Boolean', 'ResizablePMCArray')
	$I1 = stack.'pop'('Integer', 'Float', 'Boolean', 'ResizablePMCArray')
	
	$I0 = or $I0, $I1
	$P0 = new 'Boolean'
	$P0 = $I0

	stack.'push'($P0)
	.return()
.end

.sub 'and'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer', 'Float', 'Boolean', 'ResizablePMCArray')
	$I1 = stack.'pop'('Integer', 'Float', 'Boolean', 'ResizablePMCArray')

	$I0 = and $I0, $I1
	$P0 = new 'Boolean'
	$P0 = $I0
	
	stack.'push'($P0)
	.return()
.end

.sub 'xor'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer', 'Float', 'Boolean', 'ResizablePMCArray')
	$I1 = stack.'pop'('Integer', 'Float', 'Boolean', 'ResizablePMCArray')

	$I0 = xor $I0, $I1
	$P0 = new 'Boolean'
	$P0 = $I0
	
	stack.'push'($P0)
	.return()
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

.sub 'cmp'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String', 'Boolean')
	$P1 = stack.'pop'('Integer', 'Float', 'String', 'Boolean')
	
	$I0 = cmp $P1, $P0
	stack.'push'($I0)
.end

.sub 'small'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('ResizablePMCArray', 'Integer', 'String', 'Boolean')
	
	abs $I0
	$I0 = $I0 <= 1
	
	$P0 = new 'Boolean'
	$P0 = $I0
	
	.tailcall stack.'push'($P0)
.end

.sub 'null'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('ResizablePMCArray', 'Integer', 'String', 'Boolean')
	
	abs $I0
	$I0 = $I0 == 0
	
	$P0 = new 'Boolean'
	$P0 = $I0
	
	.tailcall stack.'push'($P0)
.end

.sub 'not'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'()
	not $I0
	$P0 = new 'Boolean'
	$P0 = $I0
	
	.tailcall stack.'push'($P0)
.end

.sub 'equal'
	.local pmc stack, ret
	stack = get_global 'funstack'
	ret = new 'Boolean'
	ret = 0
	
	$P0 = stack.'pop'()
	$P1 = stack.'pop'()
	
	$S0 = typeof $P0
	$S1 = typeof $P1
	
	#Not the same type? Not equal.
	if $S0 != $S1 goto false

	#Array? Time to recurse.
	if $S0 == 'ResizablePMCArray' goto check_array_equal
	#Otherwise, normal check
	if $P1 != $P0 goto false
	goto true
	
check_array_equal:
	$I0 = '!@arrays_equal'($P0, $P1)
	unless $I0 goto false
	
true:
	ret = 1
false:
	stack.'push'(ret)
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

