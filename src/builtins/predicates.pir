=head1 Predicates

A collection of predicates used to compare and test values and value types.

=cut

.sub '<'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String', 'Char')
	$P1 = stack.'pop'('Integer', 'Float', 'String', 'Char')
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
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String', 'Char')
	$P1 = stack.'pop'('Integer', 'Float', 'String', 'Char')
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
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String', 'Char')
	$P1 = stack.'pop'('Integer', 'Float', 'String', 'Char')
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
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String', 'Char')
	$P1 = stack.'pop'('Integer', 'Float', 'String', 'Char')
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
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String', 'Char')
	$P1 = stack.'pop'('Integer', 'Float', 'String', 'Char')
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
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String', 'Char')
	$P1 = stack.'pop'('Integer', 'Float', 'String', 'Char')
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
	stack = get_hll_global ['private'], 'funstack'
	$I0 = stack.'pop'('Integer', 'Float', 'Boolean', 'List', 'String')
	$I1 = stack.'pop'('Integer', 'Float', 'Boolean', 'List', 'String')
	
	$I0 = or $I0, $I1
	$P0 = new 'Boolean'
	$P0 = $I0

	stack.'push'($P0)
	.return()
.end

.sub 'and'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$I0 = stack.'pop'('Integer', 'Float', 'Boolean', 'List', 'String')
	$I1 = stack.'pop'('Integer', 'Float', 'Boolean', 'List', 'String')

	$I0 = and $I0, $I1
	$P0 = new 'Boolean'
	$P0 = $I0
	
	stack.'push'($P0)
	.return()
.end

.sub 'xor'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$I0 = stack.'pop'('Integer', 'Float', 'Boolean', 'List', 'String')
	$I1 = stack.'pop'('Integer', 'Float', 'Boolean', 'List', 'String')

	$I0 = xor $I0, $I1
	$P0 = new 'Boolean'
	$P0 = $I0
	
	stack.'push'($P0)
	.return()
.end

.sub 'small'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$I0 = stack.'pop'('List', 'Integer', 'String') #TODO: Reconsider int being here?
	
	abs $I0
	$I0 = $I0 <= 1
	
	$P0 = new 'Boolean'
	$P0 = $I0
	
	.tailcall stack.'push'($P0)
.end

.sub 'null'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$I0 = stack.'pop'('List', 'String')
	
	abs $I0
	$I0 = $I0 == 0
	
	$P0 = new 'Boolean'
	$P0 = $I0
	
	.tailcall stack.'push'($P0)
.end

.sub 'not'
	.local pmc stack
	stack = get_hll_global ['private'], 'funstack'
	$I0 = stack.'pop'()
	not $I0
	$P0 = new 'Boolean'
	$P0 = $I0
	
	.tailcall stack.'push'($P0)
.end

.sub 'equal'
	.local pmc stack, ret
	stack = get_hll_global ['private'], 'funstack'
	ret = new 'Boolean'
	
	($P0, $S0) = stack.'pop'()
	($P1, $S1) = stack.'pop'()
	
	#Not the same type? Not equal.
	if $S0 != $S1 goto false

	#Array? Time to recurse.
	if $S0 == 'List' goto check_array_equal
	#Otherwise, normal check
	if $P1 == $P0 goto true
	goto false
	
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
	stack = get_hll_global ['private'], 'funstack'
	$P0 = stack.'pop'('Integer', 'Float', 'String', 'Boolean', 'Char')
	$P1 = stack.'pop'('Integer', 'Float', 'String', 'Boolean', 'Char')
	
	$I0 = cmp $P1, $P0
	stack.'push'($I0)
.end

=item has

 A X  ->  B

Tests whether aggregate A has X as a member.

=cut

.sub 'has'
	.local pmc stack, x, a
	stack = get_hll_global ['private'], 'funstack'
	(x, $S0) = stack.'pop'()
	(a, $S1) = stack.'pop'('List', 'String')
	
	if $S1 == 'List' goto do_loop
	if $S0 != 'Char' goto notchar_error

	$S0 = a
	a = split '', $S0

do_loop:
	unless a goto notin
	$P0 = a.'shift'()
	unless $P0 == x goto do_loop
	
	$P0 = new 'Boolean'
	$P0 = 1
	.tailcall stack.'push'($P0)
	
notin:
	$P0 = new 'Boolean'
	$P0 = 0
	.tailcall stack.'push'($P0)
	
notchar_error:
	$S1 = "Bad type '"
	$S1 .= $S0
	$S1 .= "' popped from the stack.\nWas expecting a 'Char'."
	die $S1
.end

=item in

 X A  ->  B

Tests whether X is a member of aggregate A.

=cut

.sub 'in'
	.local pmc stack, x, a
	stack = get_hll_global ['private'], 'funstack'
	(a, $S1) = stack.'pop'('List', 'String')
	(x, $S0) = stack.'pop'()
	
	if $S1 == 'List' goto do_loop
	if $S0 != 'Char' goto notchar_error

	$S0 = a
	a = split '', $S0

do_loop:
	unless a goto notin
	$P0 = a.'shift'()
	unless $P0 == x goto do_loop
	
	$P0 = new 'Boolean'
	$P0 = 1
	.tailcall stack.'push'($P0)
	
notin:
	$P0 = new 'Boolean'
	$P0 = 0
	.tailcall stack.'push'($P0)
	
notchar_error:
	$S1 = "Bad type '"
	$S1 .= $S0
	$S1 .= "' popped from the stack.\nWas expecting a 'Char'."
	die $S1
.end

=item num?

 X  ->  B

Tests whether X is a floating point number.

=cut

.sub 'num?'
	.local pmc stack, ret
	stack = get_hll_global ['private'], 'funstack'
	ret = new 'Boolean'
	
	($P0, $S0) = stack.'pop'()
	if $S0 == "Float" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

=item int?

 X  ->  B

Tests whether X is an integer.

=cut

.sub 'int?'
	.local pmc stack, ret
	stack = get_hll_global ['private'], 'funstack'
	ret = new 'Boolean'
	
	($P0, $S0) = stack.'pop'()
	if $S0 == "Integer" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

=item bool?

 X  ->  B

Tests whether X is a boolean.

=cut

.sub 'bool?'
	.local pmc stack, ret
	stack = get_hll_global ['private'], 'funstack'
	ret = new 'Boolean'
	
	($P0, $S0) = stack.'pop'()
	if $S0 == "Boolean" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

=item str?

 X  ->  B

Tests whether X is a string.

=cut

.sub 'str?'
	.local pmc stack, ret
	stack = get_hll_global ['private'], 'funstack'
	ret = new 'Boolean'
	
	($P0, $S0) = stack.'pop'()
	if $S0 == "String" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

=item char?

 X  ->  B

Tests whether X is a char.

=cut

.sub 'char?'
	.local pmc stack, ret
	stack = get_hll_global ['private'], 'funstack'
	ret = new 'Boolean'
	
	($P0, $S0) = stack.'pop'()
	if $S0 == "Char" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

=item list?

 X  ->  B

Tests whether X is a list.

=cut

.sub 'list?'
	.local pmc stack, ret
	stack = get_hll_global ['private'], 'funstack'
	ret = new 'Boolean'
	
	($P0, $S0) = stack.'pop'()
	if $S0 == "List" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

=item leaf?

 X  ->  B

Tests whether X is not a list.

=cut

.sub 'leaf?'
	.local pmc stack, ret
	stack = get_hll_global ['private'], 'funstack'
	ret = new 'Boolean'
	
	($P0, $S0) = stack.'pop'()
	if $S0 != "List" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

=item file?

 X  ->  B

Tests whether X is a file stream.

=cut

.sub 'file?'
	.local pmc stack, ret
	stack = get_hll_global ['private'], 'funstack'
	ret = new 'Boolean'
	
	($P0, $S0) = stack.'pop'()
	if $S0 == "FileHandle" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

=item user?

 X  ->  B

Tests whether X is a user-defined symbol.
NOTE: Keep in mind this function requires a value to be removed from the stack without being executed. So it will not chain down.

=cut

.sub 'user?'
	.local pmc stack, ret
	stack = get_hll_global ['private'], 'funstack'
	ret = new 'Boolean'
	
	($P0, $S0) = stack.'pop_raw'()
	if $S0 == "DelayedSub" goto true

	ret = 0
	.tailcall stack.'push'(ret)
true:
	ret = 1
	.tailcall stack.'push'(ret)
.end

