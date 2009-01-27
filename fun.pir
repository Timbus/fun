=head1 Name

fun.pir - A fun compiler.

=head2 Description

This is the base file for the fun compiler.

This file includes the parsing and grammar rules from
the src/ directory, loads the relevant PGE libraries,
and registers the compiler under the name 'fun'.

=head2 Functions

=over 4

=item onload()

Creates the fun compiler using a C<PCT::HLLCompiler>
object.

=cut

.namespace [ 'fun::Compiler' ]

.loadlib 'fun_group'
.loadlib 'fun_ops'

.sub 'onload' :anon :load :init
    load_bytecode 'PCT.pbc'

    $P0 = get_hll_global ['PCT'], 'HLLCompiler'
    $P1 = $P0.'new'()
    $P1.'language'('fun')
    $P1.'parsegrammar'('fun::Grammar')
    $P1.'parseactions'('fun::Grammar::Actions')
.end

=item main(args :slurpy)  :main

Start compilation by passing any command line C<args>
to the fun compiler.

=cut

.sub 'main' :main
    .param pmc args
	
	set_hll_global "args", args
	
	$P0 = compreg 'fun'
	$P1 = $P0.'command_line'(args)
.end

.include 'src/gen_objects.pir'
.include 'src/gen_builtins.pir'
.include 'src/gen_grammar.pir'
.include 'src/gen_actions.pir'

.namespace []

.sub 'initfun' :init :anon
	$P0 = new 'Stack'
	set_hll_global 'funstack', $P0
	
	$P0 = get_hll_global "put"
	$P1 = new 'List'
	$P1.'push'($P0)
	set_hll_global "^dothook", $P1
.end

.sub '@!fndispatch'
	.param string fname
	$P0 = get_hll_global ['fun' ; 'usrfuncs'], fname
	if null $P0 goto error
	
	
.end


=back
=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

