=head1 Builtins

General purpose functions

=head2 Functions

=over 4

=cut

.namespace[]

=item '.'

The dot. This is the only function that is not pushed into the stack. When a '.' is hit in your program, the stack will execute down and functions will be ran as they are hit. The remaining value left on the stack once execution is halted will be popped off and printed to stdout.

In the future, the result behaviour of the dot may be customizable, which is why it is not in the IO section.

=cut

.sub '.'
	.local pmc stack, isempty
	stack = get_global 'funstack'
	isempty = stack.'run'()
	if isempty goto finish
	
	##Make this a hook or something? Dunno. 
	#Consider: What would the hook be written in? C? pir? fun?
	'putchars'()
	
finish:
.end

=back

=head1 Private Functions

Contains useful private functions

=cut

.namespace[]

.sub '!@mklist'
    .param pmc fields :slurpy
    .return (fields)
.end

.sub 'deepcopy'
	.param pmc val
	.local pmc valcpy
	
	$S0 = typeof val
	if $S0 == 'ResizablePMCArray' goto array_dup
	valcpy = clone val
	.return(valcpy)
	
#Iterate as much as possible. Recursion is expensive.
array_dup:
	.local pmc it
	it = iter val
	valcpy = new 'ResizablePMCArray'
	
iter_loop:
	unless it goto iter_end
	$P0 = shift it
	
	$S0 = typeof $P0
	if $S0 == 'ResizablePMCArray' goto follow_down
	
	$P0 = clone $P0
	goto push_val

follow_down:
	$P0 = deepcopy($P0)
	goto push_val

push_val:
	push valcpy, $P0
	goto iter_loop
	
iter_end:
	.return(valcpy)
.end

=head1 Combinators

These functions are designed to manipulate the way functions are composed and executed.
They are similar to code flow functions, except they focus more on execution style, rather than choices.

=head2 Functions

=over 4

=cut


=item i

 [P]  ->  ...

Executes the list C<P>

=cut

.sub 'i'
	.local pmc list, stack
	
	stack = get_global 'funstack'
	list = stack.'pop'('ResizablePMCArray')
	stack.'push'(list :flat)
	stack.'run'()

	.return ()
.end

=item x

 [P]  ->  [P] ...

Executes the list C<P> without removing it from the stack

=cut

.sub 'x'
	.local pmc list, listcpy, stack
	
	stack = get_global 'funstack'
	list = stack.'pop'('ResizablePMCArray')
	listcpy = 'deepcopy'(list)
	stack.'push'(list, listcpy :flat)
	stack.'run'()
.end

=item dip

 X [P] ->  ... X

Saves C<X>, executes C<P>, pushes C<X> back.

=cut

.sub 'dip'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('ResizablePMCArray')
	$P1 = stack.'pop'()
	
	stack.'push'($P0 :flat, $P1)
	stack.'run'()
.end

=item stack

 .. X Y Z  ->  .. X Y Z [Z Y X ..]

Pushes the stack as a list.

=cut

.sub 'stack'
	.local pmc stack, stacklist
	stack = get_global 'funstack'
	stacklist = stack.'getstack'()
	stacklist = 'deepcopy'(stacklist)
	stack.'push'(stacklist)
	'reverse'()
.end

=item unstack

 [X Y Z ..]  ->  .. Z Y X

The list [X Y Z ..] becomes the new stack.

=cut

.sub 'unstack'
	.local pmc stack, stacklist, newstack
	stack = get_global 'funstack'
	
	'reverse'()
	newstack = stack.'pop'('ResizablePMCArray')
	
	##May as well manipulate the stack directly.
	.tailcall stack.'setstack'(newstack)
.end

=item times

 N [P]  ->  ...

Executes C<P>, C<N> times

=cut

.sub 'times'
	.local pmc stack
	.local pmc p
	.local int n
	stack = get_global 'funstack'
	p = stack.'pop'('ResizablePMCArray')
	n = stack.'pop'('Integer')
	
	$I0 = 0
times_loop:
	if $I0 >= n goto loop_end
	$P0 = 'deepcopy'(p)
	stack.'push'($P0 :flat)
	stack.'run'()
	inc $I0
	goto times_loop
loop_end:
.end

=item linrec

 [P] [T] [R1] [R2]  ->  ...

Executes C<P>. If that yields true, executes C<T>.
Else executes C<R1>, recurses, executes C<R2>.

NOTE: C<P> is executed within a new continuation, so that the test gobbles no value(s).

=cut

.sub 'linrec'
	.local pmc stack
	.local pmc p, t, r1, r2
	stack = get_global 'funstack'
	r2 = stack.'pop'('ResizablePMCArray')
	r1 = stack.'pop'('ResizablePMCArray')
	t = stack.'pop'('ResizablePMCArray')
	p = stack.'pop'('ResizablePMCArray')
	
	stack.'makecc'()
	$P0 = 'deepcopy'(p)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	if $I0 goto do_true

	$P0 = 'deepcopy'(r1)
	stack.'push'($P0 :flat)
	stack.'run'()
	
	stack.'push'(p, t, r1, r2)
	'linrec'()
	
	$P0 = 'deepcopy'(r2)
	stack.'push'($P0 :flat)
	stack.'run'()
	.return()
	
do_true:
	stack.'push'(t :flat)
	stack.'run'()
.end

=item binrec

 [P] [T] [R1] [R2]  ->  ...

Executes P. If that yields true, executes T.
Else uses R1 to produce two intermediates, recurses twice,
then executes R2 (usually to combine their results).

NOTE: C<P> is executed within a new continuation, so that the test gobbles no value(s).

=cut

.sub 'binrec'
	.local pmc stack
	.local pmc p, t, r1, r2
	stack = get_global 'funstack'
	r2 = stack.'pop'('ResizablePMCArray')
	r1 = stack.'pop'('ResizablePMCArray')
	t = stack.'pop'('ResizablePMCArray')
	p = stack.'pop'('ResizablePMCArray')
	stack.'makecc'()
	$P0 = 'deepcopy'(p)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	if $I0 goto do_true
	
	$P0 = 'deepcopy'(r1)
	stack.'push'($P0 :flat)
	stack.'run'()

	stack.'push'(p, t, r1, r2)
	'binrec'()
	stack.'push'(p, t, r1, r2)
	'binrec'()

	$P0 = 'deepcopy'(r2)
	stack.'push'($P0 :flat)
	stack.'run'()
	.return()
	
do_true:
	$P0 = 'deepcopy'(t)
	stack.'push'($P0 :flat)
	stack.'run'()
.end

=item tailrec

 [P] [T] [R1]  ->  ...

Executes P. If that yields true, executes T.
Else executes R1, recurses.

=cut

#Ironically, the implementation is not recursive.
.sub 'tailrec'
	.local pmc stack
	.local pmc p, t, r1
	stack = get_global 'funstack'
	r1 = stack.'pop'('ResizablePMCArray')
	t = stack.'pop'('ResizablePMCArray')
	p = stack.'pop'('ResizablePMCArray')

rec_loop:
	stack.'makecc'()
	$P0 = 'deepcopy'(p)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	if $I0 goto do_true
	
	$P0 = 'deepcopy'(r1)
	stack.'push'($P0 :flat)
	stack.'run'()
	goto rec_loop
	
do_true:
	stack.'push'(t :flat)
	.tailcall stack.'run'()
.end

=item genrec

 [P] [T] [R1] [R2]  ->  ...

Executes P, if that yields true executes T.
Else executes R1 and then [[P] [T] [R1] [R2] genrec] R2.

=cut

.sub 'genrec'
	.local pmc stack
	.local pmc p, t, r1, r2
	stack = get_global 'funstack'
	
	r2 = stack.'pop'('ResizablePMCArray')
	r1 = stack.'pop'('ResizablePMCArray')
	t = stack.'pop'('ResizablePMCArray')
	p = stack.'pop'('ResizablePMCArray')
	
	stack.'makecc'()
	$P0 = 'deepcopy'(p)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	if $I0 goto do_true
	
	$P0 = 'deepcopy'(r1)
	stack.'push'($P0 :flat)
	stack.'run'()

	$P0 = get_global "genrec"
	$P1 = '!@mklist'(p, t, r1, r2, $P0)
	stack.'push'($P1)


	$P0 = 'deepcopy'(r2)
	stack.'push'($P0 :flat)
	.tailcall stack.'run'()
	
do_true:
	stack.'push'(t :flat)
	.tailcall stack.'run'()
.end

=item nullary

 [P]  ->  R

Begins a new continuation, then executes the list C<P>.
The result of C<P> is copied back to the prior continuation.
The end result is that nothing is removed from the stack.

=cut

.sub 'nullary'
	.local pmc stack
	.local pmc p
	stack = get_global 'funstack'
	p = stack.'pop'('ResizablePMCArray')
	stack.'makecc'()
	stack.'push'(p :flat)
	$P0 = stack.'pop'()
	stack.'exitcc'()
	stack.'push'($P0)
.end

=item unary

 X [P]  ->  R

Begins a new continuation, copies X over to it, then executes the list C<P>.
The result of C<P> is copied back to the prior continuation.
C<X> will always be removed.

=cut

.sub 'unary'
	.local pmc stack
	.local pmc p, x
	stack = get_global 'funstack'
	p = stack.'pop'('ResizablePMCArray')
	x = stack.'pop'()
	stack.'makecc'()
	stack.'push'(x, p :flat)
	stack.'run'()
	$P0 = stack.'pop'()
	stack.'exitcc'()
	stack.'push'($P0)
.end

=item binary

 X Y [P]  ->  R

Begins a new continuation, copies X Y over to it, then executes the list C<P>.
The result of C<P> is copied back to the prior continuation.
C<X> and C<Y> will always be removed.

=cut

.sub 'binary'
	.local pmc stack
	.local pmc p, x, y
	stack = get_global 'funstack'
	p = stack.'pop'('ResizablePMCArray')
	y = stack.'pop'()
	x = stack.'pop'()
	stack.'makecc'()
	stack.'push'(x, y, p :flat)
	$P0 = stack.'pop'()
	stack.'exitcc'()
	stack.'push'($P0)
.end

=item ternary

 X Y Z [P]  ->  R

Begins a new continuation, copies X Y Z over to it, then executes the list C<P>.
The result of C<P> is copied back to the prior continuation.
C<X>, C<Y> and C<Z> will always be removed.

=cut

.sub 'ternary'
	.local pmc stack
	.local pmc p, x, y, z
	stack = get_global 'funstack'
	p = stack.'pop'('ResizablePMCArray')
	z = stack.'pop'()
	y = stack.'pop'()
	x = stack.'pop'()
	stack.'makecc'()
	stack.'push'(x, y, z, p :flat)
	$P0 = stack.'pop'()
	stack.'exitcc'()
	stack.'push'($P0)
.end

=item while

 [B] [D]  ->  ...

While executing B yields true executes D.

=cut

.sub 'while'
	.local pmc stack
	.local pmc b, d
	stack = get_global 'funstack'
	d = stack.'pop'('ResizablePMCArray')
	b = stack.'pop'('ResizablePMCArray')

loop:
	stack.'makecc'()
	$P0 = 'deepcopy'(b)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	if $I0 == 0 goto finish
	
	$P0 = 'deepcopy'(d)
	stack.'push'($P0 :flat)
	stack.'run'()
	goto loop
	
finish:
.end

=back
=cut

=head1 Composers

Composition functions primaraly affect the shape of the stack. They are mostly 'padding' functions, in the sense that they tend to be placed inbetween other functions so as to properly prepare the stack for the next operation.

=head2 Functions

=over 4

=cut


=item dup

 X  ->   X X

Pushes an extra copy of X onto stack.

=cut

.sub 'dup'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	$P1 = 'deepcopy'($P0)
	stack.'push'($P0, $P1)
.end

=item dupd

 Y Z  ->  Y Y Z

As if defined by:   dupd  ==  [dup] dip

=cut

.sub 'dupd'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	$P1 = stack.'pop'()
	$P2 = 'deepcopy'($P1)
	stack.'push'($P1, $P2, $P0)
.end


=item swap

 X Y  ->   Y X

Interchanges X and Y on top of the stack.

=cut

.sub 'swap'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	$P1 = stack.'pop'()
	
	stack.'push'($P0, $P1)
.end

=item swapd

 X Y Z  ->  Y X Z

As if defined by:   swapd  ==  [ [swap] dip ]

=cut

.sub 'swapd'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	$P1 = stack.'pop'()
	$P2 = stack.'pop'()
	stack.'push'($P1, $P2, $P0)
.end

=item pop

 X  ->

Removes X from top of the stack.

=cut

.sub 'pop'
	.local pmc stack
	stack = get_global 'funstack'
	stack.'pop'()
.end

=item popd

 Y Z  ->  Z

As if defined by: popd  ==  [ [pop] dip ] 

=cut

.sub 'popd'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	stack.'pop'()
	stack.'push'($P0)
.end

=item rollup

 X Y Z  ->  Z X Y

Moves X and Y up, moves Z down

=cut

.sub 'rollup'
	.local pmc stack
	.local pmc x, y, z
	stack = get_global 'funstack'
	z = stack.'pop'()
	y = stack.'pop'()
	x = stack.'pop'()
	stack.'push'(z, x, y)
.end
#))

=item rolldown

 X Y Z  ->  Y Z X

Moves Y and Z down, moves X up

=cut

.sub 'rolldown'
	.local pmc stack
	.local pmc x, y, z
	stack = get_global 'funstack'
	z = stack.'pop'()
	y = stack.'pop'()
	x = stack.'pop'()
	stack.'push'(y, z, x)
.end

=item rollupd

 X Y Z W  ->  Z X Y W

As if defined by:   rollupd  ==  [ [rollup] dip ]

=cut

.sub 'rollupd'
	.local pmc stack
	.local pmc x, y, z, w
	stack = get_global 'funstack'
	w = stack.'pop'()
	z = stack.'pop'()
	y = stack.'pop'()
	x = stack.'pop'()
	stack.'push'(z, x, y, w)
.end
#,,

=item rolldownd

 X Y Z W  ->  Y Z X W

As if defined by:   rolldownd  ==  [rolldown] dip 

=cut

.sub 'rolldownd'
	.local pmc stack
	.local pmc x, y, z, w
	stack = get_global 'funstack'
	w = stack.'pop'()
	z = stack.'pop'()
	y = stack.'pop'()
	x = stack.'pop'()
	stack.'push'(y, z, x, w)
.end

=item rotate

 X Y Z  ->  Z Y X

Interchanges X and Z

=cut

.sub 'rotate'
	.local pmc stack
	.local pmc x, y, z
	stack = get_global 'funstack'
	z = stack.'pop'()
	y = stack.'pop'()
	x = stack.'pop'()
	stack.'push'(z, y, x)
.end

=item rotated

 X Y Z W  ->  Z Y X W

As if defined by:   rotated  ==  [rotate] dip

=cut

.sub 'rotated'
	.local pmc stack
	.local pmc x, y, z, w
	stack = get_global 'funstack'
	w = stack.'pop'()
	z = stack.'pop'()
	y = stack.'pop'()
	x = stack.'pop'()
	stack.'push'(z, y, x, w)
.end
#,

=back
=cut
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

.sub '!@arrays_equal'
	.param pmc ar1
	.param pmc ar2
	$I0 = ar1
	$I1 = ar2
	if $I0 != $I1 goto false

check_loop:
	unless ar1 goto true
	$P0 = shift ar1
	$P1 = shift ar2
	
	$S0 = typeof $P0
	if $S0 != 'ResizablePMCArray' goto simple_check
	$S0 = typeof $P1
	if $S0 != 'ResizablePMCArray' goto false
	$I0 = '!@arrays_equal'($P0, $P1)
	unless $I0 goto false
	goto check_loop
	
simple_check:
	if $P0 != $P1 goto false
	goto check_loop
	
#No need for a bool type, its not being pushed
true:
	.return(1)
false:
	.return(0)
.end

=head1 IO

Functions for reading and printing

=head2 Functions

=over 4

=cut

.namespace[]

=item say

 X ->  

Prints C<X> to stdout. Uses the same format as '.' does.

=cut

.sub 'putchars'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	'!@print_rec'($P0)
	print "\n"
.end

=item print

 X ->  

Prints C<X> to stdout. Does not add a newline

=cut

.sub 'print'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	'!@print_rec'($P0)
.end


.sub '!@print_rec'
	.param pmc value
	.local string type
	type = typeof value
	if type == 'Boolean' goto print_bool
	if type == 'ResizablePMCArray' goto print_array
	
	print value
	goto finish
	
print_bool:
	if value == 1 goto print_true
	print "false"
	goto finish
print_true:
	print "true"
	goto finish
	
print_array:
	.local pmc it
	it = iter value
	print "["
	unless it goto iter_end
iter_loop:
	$P0 = shift it
	'!@print_rec'($P0) #Recursive way to follow lists
	unless it goto iter_end
	print " "
	goto iter_loop

iter_end:
	print "]"

finish:
.end

=back

=head1 Codeflow

Functions for controlling code flow

=head2 Functions

=over 4

=cut


=item choice

 B T F  ->  X

If B is true, then X = T else X = F.

=cut

.sub 'choice'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'()
	$P1 = stack.'pop'()
	
	$P2 = stack.'pop'('Boolean')
	
	if $P2 == 0 goto false
	stack.'push'($P1)
	goto finish
false:
	stack.'push'($P0)
	
finish:
	.return()
.end

=item branch

 B [T] [F]  ->  ...

If B is true, then executes T else executes F.

=cut

.sub 'branch'
	.local pmc stack, ifcnd, then, else
	stack = get_global 'funstack'
	
	else = stack.'pop'('ResizablePMCArray')
	then = stack.'pop'('ResizablePMCArray')
	
	ifcnd = stack.'pop'('Boolean')
	
	if ifcnd == 0 goto run_else
	stack.'push'(then :flat)
	goto finish

run_else:
	stack.'push'(else :flat)
	
finish:
	stack.'run'()
.end


=item ifte

 [B] [T] [F]  ->  ...

Executes B. If that yields true, then executes T else executes F.

=cut

.sub 'ifte'
	.local pmc stack, ifcnd, then, else
	stack = get_global 'funstack'
	
	else = stack.'pop'('ResizablePMCArray')
	then = stack.'pop'('ResizablePMCArray')
	
	$P0 = stack.'pop'('ResizablePMCArray')
	stack.'push'($P0 :flat)
	stack.'run'()
	ifcnd = stack.'pop'('Boolean')
	
	if ifcnd == 0 goto run_else
	stack.'push'(then :flat)
	stack.'run'()
	.return()

run_else:
	stack.'push'(else :flat)
	stack.'run'()
	.return()
.end

=item cond

 [..[[Bi] Ti]..[D]]  ->  ...

Tries each C<Bi>. If that yields true, then executes C<Ti> and exits.
If no C<Bi> yields true, executes default C<D>.

=cut

.sub 'cond'
	.local pmc stack, condlist 
	.local pmc bi, ti, d
	
	stack = get_global 'funstack'
	condlist = stack.'pop'('ResizablePMCArray')
	d = condlist.'pop'()
	
find_true:
	unless condlist goto do_default
	ti = shift condlist
	bi = shift ti
	stack.'push'(bi :flat)
	$I0 = stack.'pop'('Boolean')
	unless $I0 goto find_true
	
	stack.'push'(ti :flat)
	stack.'run'()
	.return()

do_default:
	stack.'push'(d :flat)
	stack.'run'()
	.return()
.end

=item case

 X [..[X Xs]..]  ->  Xs

Indexing on the B<value> of X, execute the matching Xs. Defaults to the last case if no match found.
Note: Uses '=' not 'equals' to check for a matching index. I<Do not> use lists (or functions) to index.

=cut

.sub 'case'
	.local pmc stack
	.local pmc caselist, x, xs, d
	stack = get_global 'funstack'
	caselist = stack.'pop'('ResizablePMCArray')
	d = pop caselist
	x = stack.'pop'()
	
find_true:
	unless caselist goto do_default
	xs = shift caselist
	$P0 = shift xs
	if $P0 != x goto find_true
	stack.'push'(xs :flat)
	goto finish
	
do_default:
	stack.'push'(d :flat)
finish:
.end

=item opcase

 X [..[X Xs]..]  ->  [Xs]

Indexing on the B<type> of X, returns the list [Xs].
Defaults to the last case if no match found.

=cut

.sub 'opcase'
	.local pmc stack
	.local pmc caselist, x, xs, d
	stack = get_global 'funstack'
	caselist = stack.'pop'('ResizablePMCArray')
	d = pop caselist
	x = stack.'pop'()
	x = typeof x
	
find_true:
	unless caselist goto do_default
	xs = shift caselist
	$P0 = shift xs
	$P0 = typeof $P0
	if $P0 != x goto find_true
	stack.'push'(xs :flat)
	goto finish
	
do_default:
	stack.'push'(d :flat)
finish:
.end

=back

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
	$P0 = stack.'pop'('ResizablePMCArray')
	$P1 = stack.'pop'()
		
	$P0.'unshift'($P1)
	stack.'push'($P0)
	.return ()
.end

=item uncons

 A  ->  F R

F and R are the first and the rest of non-empty aggregate A.

=cut

.sub 'uncons'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('ResizablePMCArray')
	$P1 = shift $P0
	stack.'push'($P1, $P0)
.end

=item swons

 A X  ->  B

Aggregate B is A with a new member X (first member for sequences).

=cut

.sub 'swons'
	.local pmc stack
	stack = get_global 'funstack'
	$P1 = stack.'pop'()
	$P0 = stack.'pop'('ResizablePMCArray')
		
	$P0.'unshift'($P1)
	stack.'push'($P0)
.end

=item unswons

 A  ->  R F

R and F are the rest and the first of non-empty aggregate A.

=cut

.sub 'unswons'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('ResizablePMCArray')
	$P1 = shift $P0
	stack.'push'($P0, $P1)
.end

=item first

 A  ->  F

F is the first member of the non-empty aggregate A.

=cut

.sub 'first'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('ResizablePMCArray')
	$P0 = $P0[0]
	stack.'push'($P0)
.end

=item rest

 A  ->  R

R is the non-empty aggregate A with its first member removed.

=cut

.sub 'rest'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('ResizablePMCArray')
	$P0.'shift'()
	stack.'push'($P0)
.end

=item step

 A [P]  ->  ...

Sequentially pushes members of aggregate A onto the stack
and executes P for each member of A pushed.

=cut

.sub 'step'
	.local pmc stack
	.local pmc p, a
	stack = get_global 'funstack'
	
	p = stack.'pop'('ResizablePMCArray')
	a = stack.'pop'('ResizablePMCArray')
	
loop_agg:
	unless a goto loop_end
	$P0 = shift a
	stack.'push'($P0, p :flat)
	goto loop_agg

loop_end:
	stack.'run'()
.end

=item fold

 A V0 [P]  ->  ...

Starting with value V0, sequentially pushes members of aggregate A
and executes P for each member of A pushed.

=cut

.sub 'fold'
	.local pmc stack
	.local pmc a, v0, p
	stack = get_global 'funstack'
	
	p = stack.'pop'('ResizablePMCArray')
	v0 = stack.'pop'()
	a = stack.'pop'('ResizablePMCArray')
	
	stack.'push'(v0)	
loop_agg:
	unless a goto loop_end
	$P0 = shift a
	$P1 = deepcopy(p)
	stack.'push'($P0, $P1 :flat)
	goto loop_agg
loop_end:
	stack.'run'()
.end

=item map

 A [P]  ->  B

Executes P on each member of aggregate A,
collects results in sametype aggregate B.

=cut

.sub 'map'
	.local pmc stack
	.local pmc p, a, b
	stack = get_global 'funstack'
	p = stack.'pop'('ResizablePMCArray')
	a = stack.'pop'('ResizablePMCArray')
	b = new 'ResizablePMCArray'

loop_agg:
	unless a goto loop_end
	$P0 = shift a
	$P1 = deepcopy(p)
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

Note: Make sure P does not result in more than one value (a true or a false) on the stack.

=cut

.sub 'split'
	.local pmc stack
	.local pmc a, p, x1, x2
	stack = get_global 'funstack'
	p = stack.'pop'('ResizablePMCArray')
	a = stack.'pop'('ResizablePMCArray')
	x1 = new 'ResizablePMCArray'
	x2 = new 'ResizablePMCArray'
	
loop_agg:
	unless a goto loop_end
	$P0 = shift a
	$P1 = 'deepcopy'($P0)
	stack.'makecc'()
	$P2 = 'deepcopy'(p)
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

Note: Make sure P does not result in more than one value (a true or a false) on the stack.

=cut

.sub 'filter'
	.local pmc stack
	.local pmc a, p, b
	stack = get_global 'funstack'
	p = stack.'pop'('ResizablePMCArray')
	a = stack.'pop'('ResizablePMCArray')
	b = new 'ResizablePMCArray'
	
loop_agg:
	unless a goto loop_end
	$P0 = shift a
	$P1 = 'deepcopy'($P0)
	stack.'makecc'()
	$P2 = 'deepcopy'(p)
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
	$P0 = stack.'pop'('String', 'ResizablePMCArray')
	$S0 = typeof $P0
	$P1 = stack.'pop'($S0)

	if $S0 == 'String' goto concat_string
	
concat_array:
	$P1.'append'($P0)
	stack.'push'($P1)
	goto finish

concat_string:
	concat $P1, $P0
	stack.'push'($P1)
	
finish:
.end

=item reverse

 S  ->  R

Sequence R is the reverse of sequence S.

=cut

.sub 'reverse'
	.local pmc stack, value
	stack = get_global 'funstack'
	value = stack.'pop'('String', 'ResizablePMCArray')
	$S0 = typeof value
	if $S0 == 'ResizablePMCArray' goto reverse_array
	
reverse_string:
	value.'reverse'(value)
	stack.'push'(value)
	goto finish
	
reverse_array:
	.local pmc revarray
	revarray = new 'ResizablePMCArray'
	
iter_loop:
	unless value goto iter_end
	$P0 = shift value
	unshift revarray, $P0
	goto iter_loop
iter_end:
	stack.'push'(revarray)

finish:
	.return()
.end

=item at

 S I  ->  X

X is the member of S at position I. (Same thing as S[I])

=cut

.sub 'at'
	.local pmc stack, value, pos
	stack = get_global 'funstack'
	pos = stack.'pop'('Integer')
	value = stack.'pop'('String', 'ResizablePMCArray')
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
	value = stack.'pop'('String', 'ResizablePMCArray')
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


.sub 'tostring'
	.local pmc stack, value
	stack = get_global 'funstack'
	value = stack.'pop'('Integer', 'Float')
	$S0 = value
	.tailcall stack.'push'($S0)
.end

=back
=cut
