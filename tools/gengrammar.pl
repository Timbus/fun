#!/usr/bin/perl -W
use strict;
use v5.10;

my @funbuiltins;
open my $fh, "<", 'src/gen_builtins.pir'
	or die "Could not open gen_builtins.pir: $!";
for my $line (<$fh>){
	push @funbuiltins, $1 if $line =~ /.sub ['"]([^\.\@'"]*)['"]/;
}


@funbuiltins = sort {length $b <=> length $a} @funbuiltins;
chomp @funbuiltins;
my $gengrammar = join "\t| ", map {"'" . $_ . "' {*}\n"} @funbuiltins;

open my $ifh, "<", "src/parser/grammartt.pg"
	or die "Could not open grammartt.pg: $!";
open my $ofh, ">", "src/parser/grammar.pg"
	or die "Could not create grammar.pg: $!";
for (<$ifh>){
	s/===BUILTINS===/$gengrammar/ if $_ eq "\t| ===BUILTINS===\n";
	print $ofh $_;
}
