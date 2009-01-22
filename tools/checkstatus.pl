#!/usr/bin/perl -W
use strict;
use v5.10;
use YAML::Tiny;

my $yaml = YAML::Tiny->read('changes.yml') or die "Could not open funcs.yaml: $!";

my %joybuiltins;
open my $fh, "<", "plain-manual.html"
	or die "Could not open the joy manual: $!";

for my $line (<$fh>){
	++$joybuiltins{$1} if $line =~ /^([^\sA-Z]+)\s+:\s/;
}

my %funbuiltins;
for my $pirfile (<src/builtins/*.pir>){
	open my $fh, "<", $pirfile
		or die "Could not open '$pirfile': $!";

	for my $line (<$fh>){
		++$funbuiltins{$1} if $line =~ /.sub ['"]([^\.\@'"]*)['"]/;
	}
}

say "The following joy builtins are yet to be implemented by fun:";

my @todo = grep { $a = $_; !(grep { $_->{$a} } @{$yaml->[0]{'Alts'}}) && !$funbuiltins{$a} && !$yaml->[0]{'Ignore'}{$a} } keys %joybuiltins;

say for @todo;

say "\n##########\n\nThe following are functions in joy that are not part of the spec:";

my @extras = grep { !$joybuiltins{$_} } keys %funbuiltins;

say for @extras;