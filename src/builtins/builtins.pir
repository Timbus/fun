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

=back

