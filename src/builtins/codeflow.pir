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
	.tailcall stack.'push'($P1)

false:
	.tailcall stack.'push'($P0)
.end

=item branch

 B [T] [F]  ->  ...

If B is true, then executes T else executes F.

=cut

.sub 'branch'
	.local pmc stack, ifcnd, then, else
	stack = get_global 'funstack'
	
	else = stack.'pop'('List')
	then = stack.'pop'('List')
	
	ifcnd = stack.'pop'('Boolean')
	
	if ifcnd == 0 goto run_else
	.tailcall stack.'push'(then :flat)

run_else:
	.tailcall stack.'push'(else :flat)
.end


=item ifte

 [B] [T] [F]  ->  ...

Executes B within a continuation. If that yields true, then executes T else executes F.

=cut

.sub 'ifte'
	.local pmc stack, ifcnd, then, else
	stack = get_global 'funstack'
	
	else = stack.'pop'('List')
	then = stack.'pop'('List')
	
	$P0 = stack.'pop'('List')
	stack.'makecc'()
	stack.'push'($P0 :flat)
	stack.'run'()
	ifcnd = stack.'pop'('Boolean')
	stack.'exitcc'()
	
	if ifcnd == 0 goto run_else
	.tailcall stack.'push'(then :flat)

run_else:
	.tailcall stack.'push'(else :flat)

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
	condlist = stack.'pop'('List')
	d = condlist.'pop'()
	
find_true:
	unless condlist goto do_default
	ti = shift condlist
	bi = shift ti
	stack.'push'(bi :flat)
	$I0 = stack.'pop'('Boolean')
	unless $I0 goto find_true
	
	.tailcall stack.'push'(ti :flat)

do_default:
	.tailcall stack.'push'(d :flat)
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
	caselist = stack.'pop'('List')
	d = pop caselist
	x = stack.'pop'()
	
find_true:
	unless caselist goto do_default
	xs = shift caselist
	$P0 = shift xs
	if $P0 != x goto find_true
	.tailcall stack.'push'(xs :flat)
	
do_default:
	.tailcall stack.'push'(d :flat)
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
	caselist = stack.'pop'('List')
	d = pop caselist
	x = stack.'pop'()
	x = typeof x
	
find_true:
	unless caselist goto do_default
	xs = shift caselist
	$P0 = shift xs
	$P0 = typeof $P0
	if $P0 != x goto find_true
	.tailcall stack.'push'(xs)

do_default:
	#Remove the first element of the default list.
	d.'pop'()
	#Now its cool.
	.tailcall stack.'push'(d)

.end

=item ifint

 X [T] [E]  ->  ...

If X is an integer, executes T else executes E.

=cut

.sub 'ifint'
	.local pmc stack, ifcnd, then, else
	stack = get_global 'funstack'
	
	else = stack.'pop'('List')
	then = stack.'pop'('List')
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 != 'Integer' goto run_else
	
	.tailcall stack.'push'(then :flat)
	
run_else:
	.tailcall stack.'push'(else :flat)
.end

=item iflbool

 X [T] [E]  ->  ...

If X is a logical or truth value, executes T else executes E.

=cut

.sub 'ifbool'
	.local pmc stack, ifcnd, then, else
	stack = get_global 'funstack'
	
	else = stack.'pop'('List')
	then = stack.'pop'('List')
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 != 'Boolean' goto run_else
	
	.tailcall stack.'push'(then :flat)
	
run_else:
	.tailcall stack.'push'(else :flat)
.end

=item ifstr

 X [T] [E]  ->  ...

If X is a string, executes T else executes E.

=cut

.sub 'ifstr'
	.local pmc stack, ifcnd, then, else
	stack = get_global 'funstack'
	
	else = stack.'pop'('List')
	then = stack.'pop'('List')
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 != 'String' goto run_else
	
	.tailcall stack.'push'(then :flat)
	
run_else:
	.tailcall stack.'push'(else :flat)
.end

=item iflist

 X [T] [E]  ->  ...

If X is a list, executes T else executes E.

=cut

.sub 'iflist'
	.local pmc stack, ifcnd, then, else
	stack = get_global 'funstack'
	
	else = stack.'pop'('List')
	then = stack.'pop'('List')
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 != 'List' goto run_else
	
	.tailcall stack.'push'(then :flat)
	
run_else:
	.tailcall stack.'push'(else :flat)
.end

=item ifnum

 X [T] [E]  ->  ...

If X is a float, executes T else executes E.

=cut

.sub 'ifnum'
	.local pmc stack, ifcnd, then, else
	stack = get_global 'funstack'
	
	else = stack.'pop'('List')
	then = stack.'pop'('List')
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 != 'Float' goto run_else
	
	.tailcall stack.'push'(then :flat)
	
run_else:
	.tailcall stack.'push'(else :flat)
.end

=item iffile

 X [T] [E]  ->  ...

If X is a file, executes T else executes E.

=cut

.sub 'iffile'
	.local pmc stack, ifcnd, then, else
	stack = get_global 'funstack'
	
	else = stack.'pop'('List')
	then = stack.'pop'('List')
	
	$P0 = stack.'pop'()
	$S0 = typeof $P0
	if $S0 != 'FileHandle' goto run_else
	
	.tailcall stack.'push'(then :flat)
	
run_else:
	.tailcall stack.'push'(else :flat)
.end

=back

