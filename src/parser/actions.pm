# $Id$

class fun::Grammar::Actions;

method TOP($/) {
	my $past := 
		PAST::Block.new(
			:blocktype('declaration'), 
			:node( $/ ),
			
			PAST::Var.new(
				:name('funstack'),
				:viviself('Stack'),
				:scope('package'),
				:isdecl(1),
				:lvalue(1),
			),
		);
	
	for $<func> {
		my $name := $_<funcname>;
		
		#Generate the function as a pmc array
		my $fnlist := PAST::Op.new( :name('!@mklist'), :pasttype('call'), :node($/) );

		for $_<expr> {
			$fnlist.push( $($_) );
		}
		
		#Then create a method that creates and runs the function list (by inserting it onto the stack)
		$past.push(
			PAST::Block.new(
				:name($name), 
				:blocktype('declaration'),
				:node( $/ ),
				#Test to see if the list exists.
				PAST::Op.new(
					:pasttype('if'),
					:node($/),
					PAST::Op.new(
						:pirop('isnull'),
						:node($/),
						PAST::Var.new(
							:name('!usrfnlist'~$name),
							:scope('package'),
							:node($/),
						),
					),
					#If the list is null, create it.
					PAST::Op.new(
						:pasttype('bind'),
						:node($/),
						
						PAST::Var.new(
							:name('!usrfnlist'~$name),
							:viviself('ResizablePMCArray'),
							:scope('package'),
							:isdecl(1),
							:lvalue(1),
						),
						$fnlist,
					),
				),
				#Check if the 'build' param was called
				PAST::Op.new(
					:pasttype('unless'),
					:node($/),
					PAST::Var.new(
						:name('build'),
						:scope('parameter'),
						:viviself('Integer'),
						:node($/),
					),
					#If not, clone the function list then push the func on the stack to be ran.
					PAST::Op.new(
						:name('push'), :pasttype('callmethod'), :node($/),
						PAST::Var.new(
							:name('funstack'),
							:scope('package'),
						),
						PAST::Op.new(
							:flat(1),
							:name('!@deepcopy'),
							PAST::Var.new(
								:name('!usrfnlist'~$name),
								:scope('package'),
							),
						),
					),
				)
			)
		);
	}
	
	#A stack is a list. The list ends when you hit a dot.
	#We can just build a large list and then push it all in one go when we hit a dot
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
					PAST::Var.new( :name('funstack'), :scope('package') ),
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
method string($/) {
	make PAST::Val.new( :value( $($<string_literal>) ), :returns('String'), :node($/) );
}

method builtins($/) {
	make PAST::Var.new(
		:name( ~$/ ),
		:scope('package'),
	);
}

#Change this, probably make it use inline pir for the ifnull bit
method userfunccall($/) {
	make PAST::Op.new(
		:pasttype('if'),
		:node($/),
		PAST::Op.new(
			:pirop('isnull'),
			:node($/),
			PAST::Var.new(
				:name($<funcname>),
				:scope('package'),
				:node($/),
			),
		),
		#If it's null make a function that will throw an error. If the correct function is loaded later, it will override this.
		PAST::Block.new(
			:blocktype('declaration'),
			:name($<funcname>),
			PAST::Op.new(
				:pirop('throw'),
				PAST::Val.new(
					:value( "\"Error: The function '"~$<funcname>~"' is not defined. Perhaps you misspelled it?\"" ),
					:returns('Exception'),
					:node($/),
				),
			)
		),
		PAST::Var.new(
			:name($<funcname>),
			:scope('package'),
			:node($/),
		),
	)
}