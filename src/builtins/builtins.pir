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

.sub 'evalfile'
    .param pmc options         :slurpy :named

    .local string filename
	filename = options['filename']
    .local string lang
    lang = options['lang']
    if lang == 'Parrot' goto lang_parrot
    if lang goto lang_compile
    lang = 'fun'
  lang_compile:
    .local pmc compiler
    compiler = compreg lang
    .tailcall compiler.'evalfiles'(filename)

  lang_parrot:
    load_bytecode filename
    .return (1)
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
	$S0 = concat "Can't find ", basename
	concat $S0, ' in $:'
	'die'($S0)
	.return (0)

  eval_parrot:
    .local pmc result
    result = 'evalfile'('filename' => realfilename, 'lang'=>'Parrot')
    goto done

  eval_fun:
    result = 'evalfile'('filename' => realfilename, 'lang'=>'fun')

  done:
    .return (result)
.end


.sub 'ban-space-kimchi'
	.local pmc stack
	stack = get_global 'funstack'
	$P0 = new 'String'
	$P0 = "He sucks."
	stack.'push'($P0)
.end

=back

