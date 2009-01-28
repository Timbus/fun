# $Id$

class fun::Grammar::Actions;

method TOP($/) {
	my $past := 
		PAST::Block.new(
			:blocktype('declaration'), 
			:node( $/ ),
			:pirflags( ':load' ),
		);
	
	for $<func> {
		my $name := $_<funcname>;
		
		#Turn the user function into a pmc array
		my $fnlist := PAST::Op.new( :name('!@mklist'), :pasttype('call'), :node($/) );
		for $_<expr> {
			$fnlist.push( $($_) );
		}

		#Now put the list in the user function namespace.
		$past.push(
			PAST::Op.new(
				:pasttype('bind'),
				:node($/),

				PAST::Var.new(
					:name(~$name),
					:viviself('List'),
					:scope('package'),
					:namespace('userfuncs'),
					:isdecl(1),
					:lvalue(1),
				),
				$fnlist,
			),
		);
	}
	
	#A stack is a list. The list ends when you hit a dot.
	#We can just build a large list and then push it all in one go when we hit a dot.
	my $stacklist := 0;
	
	for $<expr> {
		if $_<print> {
			#Dot hit, push the stacklist into the ast.
			if $stacklist {$past.push($stacklist);}
			#Push the dot method
			$past.push( $( $_ ) );
			
			#Now make a new list.
			$stacklist := 0;	
		} 
		else {
			#No stacklist? Make one.
			if !$stacklist {
				$stacklist := PAST::Op.new( 
					:name('push'), :pasttype('callmethod'), :node($/),
					PAST::Var.new( :name('funstack'), :scope('package'), :namespace('private') ),
				);
			}
			#Add the expr to the stacklist.
			$stacklist.push( $( $_ ) );
		}
	}
	#Finally, if there are values left in the stack list, push them.					
	$past.push($stacklist);
	
	make $past;
}

method print($/){
	make PAST::Op.new(
		:pasttype('call'),
		:name( '.' ),
	);
}

##Just a dispatch.
method expr($/, $key) {
	make $( $/{$key} );
}

method list($/) {
	my $past := PAST::Op.new( :name('!@mklist'), :pasttype('call'), :node($/) );
	for $<expr> {
		$past.push( $($_) );
	}
	make $past;
}

method value($/, $key) {
	make $( $/{$key} );
}
method integer($/) {
	make PAST::Val.new( :value( ~$/ ), :returns('Integer'), :node($/) );
}
method float($/) {
	make PAST::Val.new( :value( ~$/ ), :returns('Float'), :node($/) );
}
method bool($/) {
	make PAST::Val.new( :value( ($/ eq 'true') ?? 1 !! 0 ), :returns('Boolean'), :node($/) );
}
method char($/) {
	make PAST::Val.new( :value( '"'~$<chr>~'"' ) , :returns('Char'), :node($/) );
}
method string($/) {
	make PAST::Val.new( :value( $($<string_literal>) ), :returns('String'), :node($/) );
}

method builtins($/) {
	make PAST::Var.new(
		:name( ~$/ ),
		:scope('package'),
	);
}

method userfunccall($/) {
	make PAST::Val.new(
		:value( "\""~$<funcname>~"\"" ),
		:returns('DelayedSub'),
		:node($/),
	);
}