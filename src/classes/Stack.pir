=head1 TITLE

Stack.pir

=head1 DESCRIPTION

Stack class for the 'fun' language.
Handles pop/push, and continuations(stack copies).

=cut

.namespace ['Stack']

.sub onload :anon :init :load
	.local pmc class
	class = newclass 'Stack'
	addattribute class, 'topcc'
	addattribute class, 'rootcc'
.end

.sub init :vtable :method
	$P0 = new 'Stack::Continuation'
	
	setattribute self, 'topcc', $P0
	setattribute self, 'rootcc', $P0
.end

.sub get_integer :vtable :method
	$P0 = getattribute self, 'rootcc'
	$I0 = $P0
	.return($I0)
.end

##Stack manipulation:
.sub 'pop' :method
	.param pmc args :slurpy
	.local pmc currentc, value
	
	currentc = getattribute self, 'topcc'
	value = currentc.'pop'()

	#No args means no typechecking.
	$I0 = args
	if $I0 == 0 goto finish
	
	.local string type
	type = typeof value
	
iter_loop:
	unless args goto typefail
	$S0 = shift args
	if $S0 == type goto finish
	goto iter_loop
	
finish:
	.return(value)

typefail:
	#May as well salvage what we can.
	self.'push'(value)
	#Die out.
	$S0 = 'Bad type "'
	$S0 .= type
	$S0 .= '" popped from the stack'
	
	$P0 = new 'Exception'
	$P0['message'] = $S0	
	throw $P0
	#die $S0
	.return()

.end

#Used to grab a value without running it.
.sub 'pop_raw' :method
	.local pmc currentc
	currentc = getattribute self, 'topcc'	
	.tailcall currentc.'pop_raw'()
.end

.sub 'run' :method
	#For now, no params.
	.local pmc currentc
	currentc = getattribute self, 'topcc'
	.tailcall currentc.'run'()
.end

.sub 'push' :method
	.param pmc args :slurpy
	.local pmc currentc
	
	currentc = getattribute self, 'topcc'
	
	##Not needed for now (Hopefully not needed ever).
	#currentc.'push'(args)
	
	$P0 = currentc.'getstack'()
	$P0.'append'(args)
.end

.sub 'getstack' :method
	.local pmc topcc, flatstack
	topcc = getattribute self, 'topcc'
	flatstack = new 'List'
	
	$I0 = topcc
iter_loop:
	dec $I0
	unless $I0 >= 0 goto done
	$P0 = topcc.'getat'($I0)
	flatstack.'push'($P0)
	goto iter_loop
done:
	.return (flatstack)
.end

.sub 'setstack' :method
	.param pmc newstack
	$P0 = getattribute self, 'topcc'
	$P0 = $P0.'getstack'()
	assign $P0, newstack
.end

## Continuation-related stuff: ##
.sub 'makecc' :method
	.local pmc oldcc, newcc
	newcc = new 'Stack::Continuation'
	oldcc = getattribute self, 'topcc'
	
	newcc.'setparent'(oldcc)
	
	$I0 = oldcc
	newcc.'setposition'($I0)
	
	setattribute self, 'topcc', newcc
.end

.sub 'exitcc' :method
	#Basically: topcc = topcc->parent
	
	$P0 = getattribute self, 'topcc'
	$P0 = $P0.'getparent'()
	if_null $P0, no_stack
	setattribute self, 'topcc', $P0
	.return()

no_stack:
	die "Fatal Error: No prior continuation found!"
.end

.sub 'dump' :method
	.local pmc currentc
	currentc = getattribute self, 'topcc'
	
	print "stackdump:\n"
loop:
	$P0 = currentc.'getstack'()
	$S0 = '!@mkstring'($P0)
	print $S0
	print "\n"
	currentc = currentc.'getparent'()
	if_null currentc, finish
	goto loop
finish:
.end

