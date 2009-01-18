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
	list = stack.'pop'('List')
	stack.'push'(list :flat)

.end

=item x

 [P]  ->  [P] ...

Executes the list C<P> without removing it from the stack

=cut

.sub 'x'
	.local pmc list, listcpy, stack
	
	stack = get_global 'funstack'
	list = stack.'pop'('List')
	listcpy = '!@deepcopy'(list)
	stack.'push'(list, listcpy :flat)

.end

=item dip

 X [P] ->  ... X

Saves C<X>, executes C<P>, pushes C<X> back.

=cut

.sub 'dip'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = stack.'pop'('List')
	$P1 = stack.'pop'()
	
	stack.'push'($P0 :flat, $P1)

.end

=item stack

 .. X Y Z  ->  .. X Y Z [Z Y X ..]

Pushes the stack as a list.

=cut

.sub 'stack'
	.local pmc stack, stacklist
	stack = get_global 'funstack'
	#TODO: Fix this to work with continuations.
	stacklist = stack.'getstack'()
	stack.'push'(stacklist)
	'reverse'()
.end

=item unstack

 [X Y Z ..]  ->  .. Z Y X

The list C<[X Y Z ..]> becomes the new stack.
Be wary of using this.

=cut

.sub 'unstack'
	.local pmc stack, stacklist, newstack
	stack = get_global 'funstack'
	
	'reverse'()
	newstack = stack.'pop'('List')
	
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
	p = stack.'pop'('List')
	n = stack.'pop'('Integer')
	
	$I0 = 0
times_loop:
	if $I0 >= n goto loop_end
	$P0 = '!@deepcopy'(p)
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
	r2 = stack.'pop'('List')
	r1 = stack.'pop'('List')
	t = stack.'pop'('List')
	p = stack.'pop'('List')
	
	stack.'makecc'()
	$P0 = '!@deepcopy'(p)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	if $I0 goto do_true

	$P0 = '!@deepcopy'(r1)
	stack.'push'($P0 :flat)
	stack.'run'()
	
	stack.'push'(p, t, r1, r2)
	'linrec'()
	
	$P0 = '!@deepcopy'(r2)
	stack.'push'($P0 :flat)
	stack.'run'()
	.return()
	
do_true:
	stack.'push'(t :flat)
	stack.'run'()
.end

=item condlinrec

 [ [C1] [C2] .. [D] ]  ->  ...

Each [Ci] is of the forms [[B] [T]] or [[B] [R1] [R2]].
Tries each B. If that yields true and there is just a [T], executes T and exit.
If there are [R1] and [R2], executes R1, recurses, executes R2.
Subsequent case are ignored. If no B yields true, then [D] is used.
It is then of the forms [[T]] or [[R1] [R2]]. For the former, executes T.
For the latter executes R1, recurses, executes R2.

=cut

.sub 'condlinrec'
	.local pmc stack
	.local pmc condlist, reclist
	.local pmc condit, testit
	stack = get_hll_global 'funstack'
	condlist = stack.'pop'('List')
	unless condlist goto bad_list
	
	reclist = new 'List'
	
recurse:
	condit = iter condlist
	
iter_condlist:
	$P0 = shift condit
	$S0 = typeof $P0
	if $S0 != 'List' goto bad_list
	testit = iter $P0
	unless condit goto default
	
	$P0 = shift testit
	stack.'makecc'()
	$P0 = '!@deepcopy'($P0)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	if $I0 == 0 goto iter_condlist

default:
	#Change this to >2 if parrot fixes get_integer on iterators.
	$I0 = testit
	if $I0 > 3 goto bad_list

	#So just see if you can shift twice to determine if its recursive or not.
	
	$P0 = shift testit
	$P0 = '!@deepcopy'($P0)
	stack.'push'($P0 :flat)

	unless testit goto terminal_cond
	
	$P0 = shift testit
	reclist.'unshift'($P0)
	goto recurse
	
terminal_cond:
	#Now get the list of r2's and push them on the stack, flattened, in order.
	$P1 = new 'List'

flatten_reclist:
	unless reclist goto push_reclist
	$P1 = shift reclist
	$P0.'append'($P1)
	goto flatten_reclist

push_reclist:
	.tailcall stack.'push'($P0 :flat)
	
bad_list:
	$P0 = new 'Exception'
	$P0 = "The given list is invalid."
	throw $P0
.end

=item binrec

 [P] [T] [R1] [R2]  ->  ...

Executes C<P>. If that yields true, executes C<T>.
Else uses C<R1> to produce two intermediates, recurses twice,
then executes C<R2> (usually to combine their results).

NOTE: C<P> is executed within a new continuation, so that the test gobbles no value(s).

=cut

.sub 'binrec'
	.local pmc stack
	.local pmc p, t, r1, r2
	stack = get_global 'funstack'
	r2 = stack.'pop'('List')
	r1 = stack.'pop'('List')
	t = stack.'pop'('List')
	p = stack.'pop'('List')
	
	stack.'makecc'()
	$P0 = '!@deepcopy'(p)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	
	if $I0 goto do_true
	
	$P0 = '!@deepcopy'(r1)
	stack.'push'($P0 :flat)
	#Save the second of the values to use after the first recursion halts.
	$P0 = stack.'pop'()

	stack.'push'(p, t, r1, r2)
	'binrec'()
	
	stack.'push'($P0, p, t, r1, r2)
	'binrec'()

	$P0 = '!@deepcopy'(r2)
	stack.'push'($P0 :flat)
	stack.'run'()
	.return()
	
do_true:
	$P0 = '!@deepcopy'(t)
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
	r1 = stack.'pop'('List')
	t = stack.'pop'('List')
	p = stack.'pop'('List')

rec_loop:
	stack.'makecc'()
	$P0 = '!@deepcopy'(p)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	if $I0 goto do_true
	
	$P0 = '!@deepcopy'(r1)
	stack.'push'($P0 :flat)
	stack.'run'()
	goto rec_loop
	
do_true:
	stack.'push'(t :flat)
	.tailcall stack.'run'()
.end

=item genrec

 [P] [T] [R1] [R2]  ->  ...

Executes C<P>, if that yields true executes C<T>.
Else executes C<R1> and then C<[[P] [T] [R1] [R2] genrec] R2>.

=cut

.sub 'genrec'
	.local pmc stack
	.local pmc p, t, r1, r2
	stack = get_global 'funstack'
	
	r2 = stack.'pop'('List')
	r1 = stack.'pop'('List')
	t = stack.'pop'('List')
	p = stack.'pop'('List')
	
	stack.'makecc'()
	$P0 = '!@deepcopy'(p)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	if $I0 goto do_true
	
	$P0 = '!@deepcopy'(r1)
	stack.'push'($P0 :flat)
	stack.'run'()

	$P0 = get_global "genrec"
	$P1 = '!@mklist'(p, t, r1, r2, $P0)
	stack.'push'($P1)


	$P0 = '!@deepcopy'(r2)
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
	p = stack.'pop'('List')
	stack.'makecc'()
	stack.'push'(p :flat)
	$P0 = stack.'pop'()
	stack.'exitcc'()
	stack.'push'($P0)
.end

=item unary

 X [P]  ->  R

Begins a new continuation, copies C<X> over to it, then executes the list C<P>.
The result of C<P> is copied back to the prior continuation.
C<X> will always be removed.

=cut

.sub 'unary'
	.local pmc stack
	.local pmc p, x
	stack = get_global 'funstack'
	p = stack.'pop'('List')
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

Begins a new continuation, copies C<X Y> over to it, then executes the list C<P>.
The result of C<P> is copied back to the prior continuation.
C<X> and C<Y> will always be removed.

=cut

.sub 'binary'
	.local pmc stack
	.local pmc p, x, y
	stack = get_global 'funstack'
	p = stack.'pop'('List')
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

Begins a new continuation, copies C<X Y Z> over to it, then executes the list C<P>.
The result of C<P> is copied back to the prior continuation.
C<X>, C<Y> and C<Z> will always be removed.

=cut

.sub 'ternary'
	.local pmc stack
	.local pmc p, x, y, z
	stack = get_global 'funstack'
	p = stack.'pop'('List')
	z = stack.'pop'()
	y = stack.'pop'()
	x = stack.'pop'()
	stack.'makecc'()
	stack.'push'(x, y, z, p :flat)
	$P0 = stack.'pop'()
	stack.'exitcc'()
	stack.'push'($P0)
.end

=item unary2

 X1 X2 [P]  ->  R1 R2

Executes P twice, with X1 and X2 on top of the stack. Returns the two values R1 and R2.

=cut

.sub 'unary2'
	.local pmc stack
	.local pmc p, pc, x1, x2
	stack = get_global 'funstack'
	p = stack.'pop'('List')
	x2 = stack.'pop'()
	x1 = stack.'pop'()
	
	stack.'makecc'()
	pc = '!@deepcopy'(p)
	stack.'push'(x1, pc :flat)
	stack.'run'()
	$P0 = stack.'pop'()
	stack.'exitcc'()
	
	stack.'makecc'()
	stack.'push'(x2, p :flat)
	stack.'run'()
	$P1 = stack.'pop'()
	stack.'exitcc'()
	
	stack.'push'($P0, $P1)
.end

=item unary3

 X1 X2 X3 [P]  ->  R1 R2 R3

Executes P three times, with Xi, returns Ri (i = 1..3).

=cut

.sub 'unary3'
	.local pmc stack
	.local pmc p, pc, x1, x2, x3
	stack = get_global 'funstack'
	p = stack.'pop'('List')
	x3 = stack.'pop'()
	x2 = stack.'pop'()
	x1 = stack.'pop'()
	
	stack.'makecc'()
	pc = '!@deepcopy'(p)
	stack.'push'(x1, pc :flat)
	stack.'run'()
	$P0 = stack.'pop'()
	stack.'exitcc'()
	
	stack.'makecc'()
	pc = '!@deepcopy'(p)
	stack.'push'(x2, pc :flat)
	stack.'run'()
	$P1 = stack.'pop'()
	stack.'exitcc'()
	
	stack.'makecc'()
	stack.'push'(x3, p :flat)
	stack.'run'()
	$P2 = stack.'pop'()
	stack.'exitcc'()
	
	stack.'push'($P0, $P1, $P2)
.end

=item unary4

 X1 X2 X3 X4 [P]  ->  R1 R2 R3 R4

Executes P four times, with Xi, returns Ri (i = 1..4).

=cut

.sub 'unary4'
	.local pmc stack
	.local pmc p, pc, x1, x2, x3, x4
	stack = get_global 'funstack'
	p = stack.'pop'('List')
	x4 = stack.'pop'()
	x3 = stack.'pop'()
	x2 = stack.'pop'()
	x1 = stack.'pop'()
	
	stack.'makecc'()
	pc = '!@deepcopy'(p)
	stack.'push'(x1, pc :flat)
	stack.'run'()
	$P0 = stack.'pop'()
	stack.'exitcc'()
	
	stack.'makecc'()
	pc = '!@deepcopy'(p)
	stack.'push'(x2, pc :flat)
	stack.'run'()
	$P1 = stack.'pop'()
	stack.'exitcc'()
	
	stack.'makecc'()
	pc = '!@deepcopy'(p)
	stack.'push'(x3, pc :flat)
	stack.'run'()
	$P2 = stack.'pop'()
	stack.'exitcc'()
	
	stack.'makecc'()
	stack.'push'(x4, p :flat)
	stack.'run'()
	$P3 = stack.'pop'()
	stack.'exitcc'()
	
	stack.'push'($P0, $P1, $P2, $P3)
.end

=item while

 [B] [D]  ->  ...

While executing C<B> yields true executes C<D>.

=cut

.sub 'while'
	.local pmc stack
	.local pmc b, d
	stack = get_global 'funstack'
	d = stack.'pop'('List')
	b = stack.'pop'('List')

loop:
	stack.'makecc'()
	$P0 = '!@deepcopy'(b)
	stack.'push'($P0 :flat)
	$I0 = stack.'pop'('Boolean')
	stack.'exitcc'()
	if $I0 == 0 goto finish
	
	$P0 = '!@deepcopy'(d)
	stack.'push'($P0 :flat)
	stack.'run'()
	goto loop
	
finish:
.end

=item cleave

 X [P1] [P2]  ->  R1 R2

Executes C<P1> and C<P2>, each with C<X> on top, producing two results.

=cut

.sub 'cleave'
	.local pmc stack
	.local pmc x, p1, p2, r1, r2
	stack = get_global 'funstack'
	p2 = stack.'pop'('List')
	p1 = stack.'pop'('List')
	x = stack.'pop'()
	#Make a copy of 'x' since it will be ran twice
	$P0 = '!@deepcopy'(x)
	
	#Make a cc to contain any possible overflow, then run p1
	stack.'makecc'()
	stack.'push'($P0, p1 :flat)
	r1 = stack.'pop'()
	stack.'endcc'()
	
	#Now run p2
	stack.'makecc'()
	stack.'push'(x, p2 :flat)
	r2 = stack.'pop'()
	stack.'endcc'()
	
	stack.'push'(r1, r2)
.end

=item treerec

 T [O] [C]  ->  ...

T is a tree. If T is a leaf, executes O. Else executes [[O] [C] treerec] C.

=cut

.sub 'treerec'
	.local pmc stack
	.local pmc t, o, c
	stack = get_global 'funstack'
	c = stack.'pop'('List')
	o = stack.'pop'('List')
	(t, $S0) = stack.'pop'()
	
	if $S0 == 'List' goto recurse
	$P0 = '!@deepcopy'(o)
	.tailcall stack.'push'(t, $P0 :flat)
	
recurse:
	$P0 = get_global "treerec"
	$P0 = '!@mklist'(o, c, $P0)
	$P1 = '!@deepcopy'(c)
	.tailcall stack.'push'(t, $P0, $P1 :flat)
.end

=item treegenrec

 T [O1] [O2] [C]  ->  ...

T is a tree. If T is a leaf, executes O1.
Else executes O2 and then [[O1] [O2] [C] treegenrec] C.

=cut

=back
=cut

