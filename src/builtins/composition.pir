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
	$P1 = '!@deepcopy'($P0)
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
	$P2 = '!@deepcopy'($P1)
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
