#!/usr/bin/env parrot
# $Id$

=head1 NAME

setup.pir - Python distutils style

=head1 DESCRIPTION

No Configure step, no Makefile generated.

=head1 USAGE

    $ parrot setup.pir build
    $ parrot setup.pir test
    $ sudo parrot setup.pir install

=cut

.sub 'main' :main
    .param pmc args
    $S0 = shift args
    load_bytecode 'distutils.pbc'

    .const 'Sub' prebuild = 'prebuild'
    register_step_before('build', prebuild)

    .const 'Sub' clean = 'clean'
    register_step_before('clean', clean)

    $P0 = new 'Hash'
    $P0['name'] = 'fun'
    $P0['abstract'] = 'An even happier Joy'
    $P0['authority'] = 'http://github.com/TiMBuS'
    $P0['description'] = 'An even happier Joy'
    $P0['license_type'] = 'GPL 3.0'
    $P0['license_uri'] = 'http://www.opensource.org/licenses/gpl-3.0.html'
    $P0['copyright_holder'] = 'Jarrod Miller'
    $P0['checkout_uri'] = 'git://github.com/TiMBuS/fun.git'
    $P0['browser_uri'] = 'http://github.com/TiMBuS/fun'
    $P0['project_uri'] = 'http://github.com/TiMBuS/fun'

    # build
    $P1 = new 'Hash'
    $P1['fun_ops'] = 'src/ops/fun.ops'
    $P0['dynops'] = $P1

    $P2 = new 'Hash'
    $P3 = split "\n", <<'PMCS'
src/pmc/char.pmc
src/pmc/delayedsub.pmc
src/pmc/eosmarker.pmc
src/pmc/list.pmc
PMCS
    $S0 = pop $P3
    $P2['fun_group'] = $P3
    $P0['dynpmc'] = $P2

    $P4 = new 'Hash'
    $P4['src/gen_grammar.pir'] = 'src/parser/grammar.pg'
    $P0['pir_pge'] = $P4

    $P6 = new 'Hash'
    $P6['src/gen_actions.pir'] = 'src/parser/actions.pm'
    $P0['pir_nqp'] = $P6

    $P7 = new 'Hash'
    $P8 = split "\n", <<'SOURCES'
fun.pir
src/gen_grammar.pir
src/gen_actions.pir
src/gen_builtins.pir
src/gen_objects.pir
SOURCES
    $S0 = pop $P8
    $P7['fun.pbc'] = $P8
    $P0['pbc_pir'] = $P7

    $P9 = new 'Hash'
    $P9['parrot-fun'] = 'fun.pbc'
    $P0['installable_pbc'] = $P9

    # test
    $S0 = get_parrot()
    $S0 .= ' fun.pbc'
    $P0['prove_exec'] = $S0

    # dist
    $P10 = glob('src/parser/grammartt.pg src/builtins/*.pir src/classes/*.pir tools/*.pl examples/*.fun changes.yml plain-manual.html')
    $P0['manifest_includes'] = $P10
    $P11 = split ' ', 'src/gen_objects.pir src/gen_builtins.pir src/parser/grammar.pg'
    $P0['manifest_excludes'] = $P11

    .tailcall setup(args :flat, $P0 :flat :named)
.end

.sub 'prebuild' :anon
    .param pmc kv :slurpy :named
    .local string cmd

    $P1 = split "\n", <<'CLASSES_PIR'
src/classes/Stack.pir
src/classes/Continuation.pir
CLASSES_PIR
    $S0 = pop $P1
    $I0 = newer('src/gen_objects.pir', $P1)
    if $I0 goto L1
    cmd = 'perl -MExtUtils::Command -e cat '
    $S0 = join ' ', $P1
    cmd .= $S0
    cmd .= ' > src/gen_objects.pir'
    system(cmd, 1 :named('verbose'))
  L1:

    $P2 = split "\n", <<'BUILTINS_PIR'
src/builtins/builtins.pir
src/builtins/privfunctions.pir
src/builtins/combinators.pir
src/builtins/composition.pir
src/builtins/operands.pir
src/builtins/io.pir
src/builtins/codeflow.pir
src/builtins/sequences.pir
src/builtins/math.pir
src/builtins/predicates.pir
BUILTINS_PIR
    $S0 = pop $P2
    $I0 = newer('src/gen_builtins.pir', $P2)
    if $I0 goto L2
    cmd = 'perl -MExtUtils::Command -e cat '
    $S0 = join ' ', $P2
    cmd .= $S0
    cmd .= ' > src/gen_builtins.pir'
    system(cmd, 1 :named('verbose'))
  L2:

    $P3 = split ' ', 'src/gen_builtins.pir src/parser/grammartt.pg'
    $I0 = newer('src/parser/grammar.pg', $P3)
    if $I0 goto L3
    cmd = 'perl tools/gengrammar.pl'
    system(cmd, 1 :named('verbose'))
  L3:
.end

.sub 'clean' :anon
    .param pmc kv :slurpy :named
    unlink('src/gen_objects.pir')
    unlink('src/gen_builtins.pir')
    unlink('src/parser/grammar.pg')
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

