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

	$P0 = new 'List'
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
	$P0 = 'Cannot pop from empty stack'
	throw $P0
.end

.sub 'run' :method
	.local pmc stack
	.local pmc value
	.local int stacksz
	stack = getattribute self, 'stack'
	
run_down:
	#Test to see if we can just pop.
	stacksz = stack
	if stacksz goto just_run

	#If we need to walk down the continuation list, need to test a couple things
	.local pmc mypos, parent
	mypos = getattribute self, 'position'
	if mypos < 1 goto stack_empty
	parent = getattribute self, 'parent'
	if null parent goto stack_empty

	#Tests cleared, we grab the value copy:
	dec mypos
	value = parent.'getat'(mypos)
	$S0 = typeof value
	if $S0 == 'EOSMarker' goto stack_empty
	if $S0 == 'Sub' goto runval
	if $S0 == 'Closure' goto runval
	if $S0 == 'DelayedSub' goto usrfnc_runval
	stack.'push'(value)
	.return(0)
	
just_run:
	value = stack[-1]
	$S0 = typeof value
	if $S0 == 'EOSMarker' goto stack_empty_pop
	if $S0 == 'Sub' goto pre_runval
	if $S0 == 'Closure' goto pre_runval
	if $S0 == 'DelayedSub' goto pre_usrfnc_runval
	.return(0)

pre_runval:
	#This is popping from the continuation pmcarray, not the stack.
	#Don't confuse yourself
	#stack.'pop'()
	
	#Optimized? Test it out later.
	$I0 = stacksz - 1
	stack = $I0 
runval:
	push_eh run_error
	value()
	pop_eh
	goto run_down

#Okay, I know theres a more elegant solution to all this code re-use.
#Maybe maually setting up the function calls would help in some way.. Something to ponder.
pre_usrfnc_runval:
	#stack.'pop'()
	$I0 = stacksz - 1
	stack = $I0 
usrfnc_runval:
	'!@userdispatch'(value, stack)
	goto run_down


stack_empty_pop:
	stack.'pop'()
stack_empty:
	.return(1)
	
#undefined_func:
#	$P0 = new 'Exception'
#	$P0 = "Undefined symbol hit.\nPerhaps you misspelled a function name?"
#	throw $P0
#	.return()
	
run_error:
	.local pmc exception
	.get_results (exception) 
	$I0 = exception['type']
	if $I0 == -1 goto error_exit
	
	.local string errstr
	$S0 = value
	errstr = "Error in function '"
	errstr .= $S0
	errstr .= "': "
	printerr errstr
	exception['type'] = -1
	
error_exit:
	rethrow exception
	#die errstr
.end

#A frankenfunction, copy pasted from run and pop. 
#Pops (or copies) the top element without runnning it.
.sub 'pop_raw' :method
	.local pmc stack, parent, mypos
	
	stack = getattribute self, 'stack'
	$I0 = stack
	if $I0 goto just_pop

	mypos = getattribute self, 'position'
	if mypos < 1 goto stack_empty
	parent = getattribute self, 'parent'
	if null parent goto stack_empty
	
	$P0 = self.'getat'(mypos)
	.return()
	
just_pop:
	$P0 = stack.'pop'()
	.return($P0)
	
stack_empty:
	$P0 = new 'Exception'
	$P0 = 'Cannot pop from empty stack'
	throw $P0
	.return()
.end

.sub 'getat' :method
	.param int pos
	$P0 = getattribute self, 'position'
	$I0 = $P0
	if pos < $I0 goto walk_down
	
	$P0 = getattribute self, 'stack'
	pos -= $I0
	$P0 = $P0[pos]
	$P0 = '!@deepcopy'($P0)
	.return ($P0)
	
walk_down:
	$P0 = getattribute self, 'parent'
	.tailcall $P0.'getat'(pos)
.end

.namespace []
#I do not like this being here at all, but I cant figure out how to make an invokable DelayedSub.
.sub '!@userdispatch'
	.param string fname
	.param pmc stack
	.local pmc fnlist

	fnlist = get_global ['userfuncs'], fname
	if null fnlist goto null_sub

	fnlist = '!@deepcopy'(fnlist)
	stack.'append'(fnlist)
	.return()

null_sub:
	.local pmc errorflag
	errorflag = get_hll_global ['private'], 'undeferror'
	unless errorflag goto ignore_error

	errorflag = get_global ['usrfuncs'], fname
	$S0 = "Error: '"
	$S0 .= fname
	$S0 .= "' is not defined. Perhaps you misspelled a symbol?"
	die $S0

ignore_error:
.end