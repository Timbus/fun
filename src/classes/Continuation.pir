=head1 TITLE

Contination.pir

=head1 DESCRIPTION

Continuation class for the 'fun' language.
To be used exclusively by the 'Stack' object.

=head1 THEORY

The theory behind continuations is simple: Save the program state, change context, then later on jump back to the saved state. Most operating systems employ such a technique regularly to provide a way for programs to run in a simulated parallel manner.
In joy, Continuations are no different; The program state is saved, and then reverted back to when the continuation is left. The problem however, is that joy is a stack based language. That means to make a continuation, one must save the entire stack. This in turn means massive overhead, especially with functions like map creating a new continuation for every iteration over the list.
The solution? Don't copy the entire stack. Only copy what is used from it.

=cut

.namespace ['Stack::Continuation']

.sub onload :anon :load :init 
	.local pmc class
	class = newclass 'Stack::Continuation'

	addattribute class, 'stack'
	addattribute class, 'parent'
	addattribute class, 'position'
.end

.sub init :vtable :method
	null $P0
	setattribute self, 'parent', $P0

	$P0 = new 'Integer'
	$P0 = 0
	setattribute self, 'position', $P0

	$P0 = new 'ResizablePMCArray'
	setattribute self, 'stack', $P0
.end

.sub 'setparent' :method
	.param pmc parent
	setattribute self, 'parent', parent
.end

.sub 'getparent' :method
	$P0 = getattribute self, 'parent'
	.return($P0)
.end

.sub 'setposition' :method
	.param pmc position
	setattribute self, 'position', position
.end

.sub 'getposition' :method
	$P0 = getattribute self, 'position'
	.return($P0)
.end

.sub 'getstack' :method
	$P0 = getattribute self, 'stack'
	.return($P0)
.end

.sub get_integer :vtable :method
	$P0 = getattribute self, 'stack'
	$I0 = $P0
	$P0 = getattribute self, 'position'
	$I1 = $P0
	$I0 += $I1
	.return($I0)
.end

##MAYBE use a return value for this pop, and put thrown errors in Stack.pir instead.
.sub 'pop' :method
	.local int isempty
	isempty = self.'run'()
	if isempty == 1 goto stack_empty

	$P0 = getattribute self, 'stack'
	$P0 = $P0.'pop'()
	.return($P0)

stack_empty:
	$P0 = new 'Exception'
	$P0['message'] = 'Cannot pop from empty stack'
	throw $P0
	.return()
.end

.sub 'run' :method
	.local pmc stack
	stack = getattribute self, 'stack'

run_down:
	#Test to see if we can just pop.
	$I0 = stack
	if $I0 goto just_run

	#If we need to walk down the continuation list, need to test a couple things
	.local pmc mypos, parent
	mypos = getattribute self, 'position'
	if mypos < 1 goto stack_empty
	parent = getattribute self, 'parent'
	if_null parent, stack_empty

	#Tests cleared, we grab the value copy:
	dec mypos
	$P0 = parent.'getat'(mypos)
	$S0 = typeof $P0
	if $S0 == 'Sub' goto runval
	if $S0 == 'Closure' goto runval
	stack.'push'($P0)
	.return(0)
	
just_run:
	.local pmc value
	value = stack[-1]
	if null value goto undefined_func
	$S0 = typeof value
	if $S0 == 'Sub' goto pre_runval
	if $S0 == 'Closure' goto pre_runval
	.return(0)

pre_runval:
	#This is popping from the continuation pmcarray, not the stack.
	#Don't confuse yourself
	stack.'pop'()
runval:
	push_eh run_error
	value()
	pop_eh
	goto run_down
	
stack_empty:
	.return(1)
	
undefined_func:
	$P0 = new 'Exception'
	$S0 = "Undefined symbol hit.\nPerhaps you misspelled a function name?"
	$P0['message'] = $S0
	throw $P0
	.return()
	
run_error:
	.local pmc exception
	.get_results (exception) 
	$I0 = exception['type']
	if $I0 == -1 goto error_exit
	
	.local string errstr
	errstr = "Error in function '"
	$S0 = value
	errstr .= $S0
	errstr .= "': "
	printerr errstr
	exception['type'] = -1
	
error_exit:
	rethrow exception
	#die errstr
.end


.sub 'getat' :method
	.param int pos
	
	$P0 = getattribute self, 'position'
	$I0 = $P0
	if pos < $I0 goto walk_down
	
	$P0 = getattribute self, 'stack'
	pos -= $I0
	$P0 = $P0[pos]
	.tailcall '!@deepcopy'($P0)
	
walk_down:
	$P0 = getattribute self, 'parent'
	.tailcall $P0.'getat'(pos)
.end

