
=head1 TITLE

xyz.pir - A fun compiler.

=head2 Description

This is the entry point for the fun compiler.

=head2 Functions

=over 4

=item main(args :slurpy)  :main

Start compilation by passing any command line C<args>
to the fun compiler.

=cut

.sub 'main' :main
    .param pmc args

    #Put the arguments into the private namespace for argc/argv to use.
    set_hll_global ['private'], 'args', args

    load_language 'fun'

    $P0 = compreg 'fun'
    $P1 = $P0.'command_line'(args)
.end

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

