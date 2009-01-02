=head1 Predicates

A collection of predicates used to compare and test values and value types.

=cut

.sub '<'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	
	if $P1 < $P0 goto true
	
	$P2 = 0
	.tailcall stack.'push'($P2)

true:
	$P2 = 1
	.tailcall stack.'push'($P2)
.end

.sub '>'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	
	if $P1 > $P0 goto true

	$P2 = 0
	.tailcall stack.'push'($P2)

true:
	$P2 = 1
	.tailcall stack.'push'($P2)
.end

.sub '='
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	
	if $P1 == $P0 goto true

	$P2 = 0
	.tailcall stack.'push'($P2)

true:
	$P2 = 1
	.tailcall stack.'push'($P2)
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
	.tailcall stack.'push'($P2)

true:
	$P2 = 1
	.tailcall stack.'push'($P2)
.end

.sub '<='
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	$P2 = 1
	
	if $P1 <= $P0	goto true

	$P2 = 0
	.tailcall stack.'push'($P2)

true:
	$P2 = 1
	.tailcall stack.'push'($P2)
.end

.sub '>='
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String')
	$P1 = stack.'pop'('Integer', 'Float', 'String')
	$P2 = new 'Boolean'
	$P2 = 1
	
	if $P1 >= $P0 goto true
	
	$P2 = 0
	.tailcall stack.'push'($P2)

true:
	$P2 = 1
	.tailcall stack.'push'($P2)
.end


.sub 'or'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer', 'Float', 'Boolean', 'List')
	$I1 = stack.'pop'('Integer', 'Float', 'Boolean', 'List')
	
	$I0 = or $I0, $I1
	$P0 = new 'Boolean'
	$P0 = $I0

	stack.'push'($P0)
	.return()
.end

.sub 'and'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer', 'Float', 'Boolean', 'List')
	$I1 = stack.'pop'('Integer', 'Float', 'Boolean', 'List')

	$I0 = and $I0, $I1
	$P0 = new 'Boolean'
	$P0 = $I0
	
	stack.'push'($P0)
	.return()
.end

.sub 'xor'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('Integer', 'Float', 'Boolean', 'List')
	$I1 = stack.'pop'('Integer', 'Float', 'Boolean', 'List')

	$I0 = xor $I0, $I1
	$P0 = new 'Boolean'
	$P0 = $I0
	
	stack.'push'($P0)
	.return()
.end

.sub 'small'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('List', 'Integer', 'String', 'Boolean')
	
	abs $I0
	$I0 = $I0 <= 1
	
	$P0 = new 'Boolean'
	$P0 = $I0
	
	.tailcall stack.'push'($P0)
.end

.sub 'null'
	.local pmc stack
	stack = get_global 'funstack'
	$I0 = stack.'pop'('List', 'Integer', 'String', 'Boolean')
	
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
	
	$P0 = stack.'pop'()
	$P1 = stack.'pop'()
	
	$S0 = typeof $P0
	$S1 = typeof $P1
	
	#Not the same type? Not equal.
	if $S0 != $S1 goto false

	#Array? Time to recurse.
	if $S0 == 'List' goto check_array_equal
	#Otherwise, normal check
	if $P1 != $P0 goto false
	goto true
	
check_array_equal:
	$I0 = '!@arrays_equal'($P0, $P1)
	unless $I0 goto false
	
true:
	ret = 1
	.tailcall stack.'push'(ret)

false:
	ret = 0
	.tailcall stack.'push'(ret)
.end

.sub 'cmp'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String', 'Boolean')
	$P1 = stack.'pop'('Integer', 'Float', 'String', 'Boolean')
	
	$I0 = cmp $P1, $P0
	stack.'push'($I0)
.end

.sub 'num?'
	.local pmc stack, ret
	stack = get_global 'funstack'
	ret = new 'Boolean'
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 == "Float" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

.sub 'int?'
	.local pmc stack, ret
	stack = get_global 'funstack'
	ret = new 'Boolean'
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 == "Integer" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

.sub 'bool?'
	.local pmc stack, ret
	stack = get_global 'funstack'
	ret = new 'Boolean'
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 == "Boolean" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

.sub 'str?'
	.local pmc stack, ret
	stack = get_global 'funstack'
	ret = new 'Boolean'
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 == "String" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

.sub 'list?'
	.local pmc stack, ret
	stack = get_global 'funstack'
	ret = new 'Boolean'
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 == "List" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

.sub 'file?'
	.local pmc stack, ret
	stack = get_global 'funstack'
	ret = new 'Boolean'
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 == "FileHandle" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end
