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
	listcpy = '!@deepcopy'(list)
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
	stacklist = '!@deepcopy'(stacklist)
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
	r2 = stack.'pop'('ResizablePMCArray')
	r1 = stack.'pop'('ResizablePMCArray')
	t = stack.'pop'('ResizablePMCArray')
	p = stack.'pop'('ResizablePMCArray')
	
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
	r2 = stack.'pop'('ResizablePMCArray')
	r1 = stack.'pop'('ResizablePMCArray')
	t = stack.'pop'('ResizablePMCArray')
	p = stack.'pop'('ResizablePMCArray')
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
	'binrec'()
	stack.'push'(p, t, r1, r2)
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
	r1 = stack.'pop'('ResizablePMCArray')
	t = stack.'pop'('ResizablePMCArray')
	p = stack.'pop'('ResizablePMCArray')

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
	
	r2 = stack.'pop'('ResizablePMCArray')
	r1 = stack.'pop'('ResizablePMCArray')
	t = stack.'pop'('ResizablePMCArray')
	p = stack.'pop'('ResizablePMCArray')
	
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
	p = stack.'pop'('ResizablePMCArray')
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

Begins a new continuation, copies C<X Y> over to it, then executes the list C<P>.
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

Begins a new continuation, copies C<X Y Z> over to it, then executes the list C<P>.
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

While executing C<B> yields true executes C<D>.

=cut

.sub 'while'
	.local pmc stack
	.local pmc b, d
	stack = get_global 'funstack'
	d = stack.'pop'('ResizablePMCArray')
	b = stack.'pop'('ResizablePMCArray')

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
	p2 = stack.'pop'('ResizablePMCArray')
	p1 = stack.'pop'('ResizablePMCArray')
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

=back
=cut

