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

=item 'rand'

 ->  I

Pushes a random integer.

=cut

.sub 'rand'
	.local pmc stack
	stack = get_global 'funstack'
	
	$P0 = new 'Random'
	$I0 = $P0

	.tailcall stack.'push'($I0)
.end



.sub 'include'
	.local pmc stack
	stack = get_global 'funstack'

	.local int iscompiled, noext
	iscompiled = 1
	noext = 0
	
	.local string name
	name = stack.'pop'('String')
	$I0 = length name
	if $I0 <= 5 goto no_ext
	
	substr $S0, name, -4
	if $S0 == '.pbc' goto already_compiled
	if $S0 == '.pir' goto already_compiled
	if $S0 == '.fun' goto has_ext

  no_ext:
	noext = 1
  has_ext:
	iscompiled = 0
  already_compiled:
 	##  loop through inc
#	.local pmc inc_it
#	$P0 = get_hll_global '@INC'
#	inc_it = iter $P0
#  inc_loop:
#	unless inc_it goto inc_end
	.local string basename, realfilename
#	$S0 = shift inc_it
#	basename = concat $S0, '/'
#	basename .= name
	basename = name

	if noext goto check_noext

  check_withext:
	realfilename = basename
	$I0 = stat realfilename, 0
#	unless $I0 goto inc_loop
	unless $I0 goto inc_end
	if iscompiled goto eval_parrot
	goto eval_fun

  check_noext:
	realfilename = concat basename, '.pbc'
	$I0 = stat realfilename, 0
	if $I0 goto eval_parrot
	realfilename = concat basename, '.pir'
	$I0 = stat realfilename, 0
	if $I0 goto eval_parrot
	realfilename = concat basename, '.fun'
	$I0 = stat realfilename, 0
	if $I0 goto eval_fun
#	goto inc_loop
  inc_end:
	$S0 = concat "Can't find module or file '", basename
	$S0 .= "'"
	$P0 = new 'Exception'
	$P0 = $S0
	throw $P0
	.return ()

  eval_parrot:
	load_bytecode realfilename
	.return (1)
  eval_fun:
	.local pmc compiler
	compiler = compreg 'fun'
	.tailcall compiler.'evalfiles'(realfilename)
.end

.sub 'ban-space-kimchi'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = new 'String'
	$P0 = "He sucks."
	stack.'push'($P0)
.end

=back

