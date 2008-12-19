=head1 Math

Functions for math type things

=head2 Functions

=over 4

=cut

.namespace[]

=item 'rand'

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

=item 'rand'

 ->  I

Pushes a random integer.

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
