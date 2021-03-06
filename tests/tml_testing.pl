:- module(tml_testing,[tml_examples/1,test_tml_r/1,show_tml_read/1]).


% :- set_prolog_flag(back_quotes,string).

tml_examples([
	intro:
`# Enter your TML logic program here and
# press RUN to execute.
#
# Any text following the '#' character is
# a comment and is ignored by TML.
#
# Logic programs consist of logic clauses.
# This program has no logic clause.
#
# Clauses can be either FACTS or RULES and
# they are terminated by the '.' character
# like sentences in English.`,

	eFACTS:
`# Facts define RELATIONS between entities.
# Fact clauses are considered to be true.

father Tom Amy.   # Tom is a father of Amy.
canFly bird.      # Bird can fly.
edge 6 3.         # Exists an edge from 6 to 3.
night.            # It's night.
1 2.              # Exists a pair 1-2.
direct London NY. # London has a direct to NY.
3 9 12.           # Exists a triple 3-9-12.
beginsWithJ Joe.  # Joe begins with J.

# Output is padded by '*' character when
# different ARITIES are used.`,

	eRELATIONS:
`# Every FACT begins with a predicate,
# which is also the name of a relation.
#
# We can think of:
#     relations as tables,
#     facts as rows and
#     entities as columns.
#
# Set of relations is called a model, or
# relational structure.
#                    _____________
                  # |_beginsWithJ_|
beginsWithJ Jane. # |    Jane     |
beginsWithJ John. # |    John     |
beginsWithJ Jack. # |____Jack_____|
                  #  _____________
                  # |___uncle_____|
uncle Jim Joe.    # |  Jim | Joe  |
uncle Joe Jill.   # |  Joe | Jill |
uncle Joe Jack.   # |__Joe_|_Jack_|

employee John Doe sales.
employee Jane Doe support.
#  ______________________
# |______employee________|
# | John | Doe | sales   |
# |_Jane_|_Doe_|_support_|

# FACTS (rows) in a relation (table) are
# unordered. It means it doesn't matter which
# fact comes first.
# Entities (columns) are unnamed and ordered.
# It's a difference from common relational
# databases where columns are named.
#
# Number of columns is also called ARITY.`,

	eARITY:
`# Every clause has its arity. It's a dimension
# of the domain in the corresponding Cartesian
# product.
# Basically it's a number of RELATION's entities
# (columns). It can be written as 'n-ary' or
# latin/greek name is used.

# Arity (latin/greek):

# 0-ary (nullary/niladic)
rain.
night.

# 1-ary (unary/monadic)
happy Sue.
barks Max.

# 2-ary (binary/dyadic)
mother Jane Jack.
employee John Doe.

# 3-ary (ternary/triadic)
married Tom Jane 2004.
employee Jane Doe support.

# ...
# 6-ary (senary)
a 1 2 3 4 5 6.

# 2-ary or more are also
# called multiary/polyadic

# Output of TML is padded by '*' character
# up to the highest known arity.`,

	eRULES:
`# Rules allow creation/inferring of new facts.
# Every rule has a head and a body separated by
# ':-' symbol. Head is on the left side and body
# is on the right side.
# Rules are also called Horn Clauses.
# They work the way that head is true if body is
# true.
# You can imagine rules like facts (in head)
# with conditions (in body).

# TML takes all the known facts and tries to
# match them into bodies of all the known rules.
# When a fact matches a body of a rule it infers
# new fact from the head of the rule.

rain.                   # rain.
wet :- rain.            # wet if rain.
freezing :- bellowZero. # freezing if bellow 0.

# Here TML infers it's wet because it knows it
# rains.
# See there is 'rain' and 'wet' in the output.
# There is no 'freezing' because there is no
# 'bellowZero'.
`,

	e1234:
`
1 2.        # 1-2 exists.
1 4.        # 1-4 exists.
3 1 :- 1 3. # 3-1 exists if 1-3 exists.
2 1 :- 1 2. # 2-1 exists if 1-2 exists.

# Here TML infers 2 1 because there exist 1 2.
# You should see 1 2, 1 4 and 2 1 in the output.
# There is no 3 1 because there is no 1 3.

`,

	eMadam:
`employee Suzi female.
salutation Suzi Madam :- employee Suzi female.

# If employee Suzi is female, Suzi's salutation
# is Madam.
# TML correctly infers that Suzi's salutation is
# Madam because employee Suzi is female.

# Rules become more powerful when used with
# VARIABLES.`,

	eVARIABLES:
`# Variables are used for substitution of
# multiple possible entities in rules.
# If a variable is substituted by an entity
# in a body it is substituted by the same entity
# in body's head.
# Variables begin with '?' character.

bird Charlie.
bird Coco.
cat Bella.

canFly ?something :- bird ?something.
# If something is a bird, it can fly.
# TML infers that Charlie and Coco can fly.

beeps ?some :- bird ?some.
# If there is some bird, it beeps.
# TML infers that Charlie and Coco beeps.

meows ?some :- cat ?some.
# If there is some cat, it meows.
# TML infers that Bella meows.


employee Suzi female.
employee John male.
employee Jane female.

salutation ?Person Madam :-
    employee ?Person female.
# salutation for any employee female is Madam.
# TML infers that Suzi's and Jane's salutation
# is Madam.

salutation ?Person Sir :-
    employee ?Person male.
# salutation for any employee male is Sir
# TML infers that John's salutation is Sir.


parent ?x ?y :- father ?x ?y.
parent ?x ?y :- mother ?x ?y.
father Coco Charlie.
mother Suzi John.

# TML infers that Coco is Charlie's parent.
# and that Suzi is John's parent.

# Just for fun, let's say, John is a bird:
bird John.

# TML infers that John beeps and he can fly.`,

	'AND/OR':
`# When you need multiple conditions in a body
# separate them by a comma. You can read comma
# as 'and':

boy ?x :- child ?x, male ?x.
# ?x is a boy if ?x is both child and male.

girl ?x :- child ?x, female ?x.
# ?x is a girl if ?x is both child and female.

# When you need multiple bodies for the same
# head, you can have multiple rules with the
# same head:

human ?x :- child ?x.
human ?x :- adult ?x.
# ?x is a human if ?x is child or adult.

adult Amy.
child John.
child Jack.
child Jane.
child Suzi.
male John.
male Jack.
female Amy.
female Jane.
female Suzi.

# TML infers: Jack and John are boys.
# Jane and Suzi are girls.
# And Amy, Jack, Jane, John and Suzi are
# humans.`,

	eRECURSION:
`# Recursion is used to traverse through
# all the entities in a relation.
# It's a logic programs' alternative to loops.

# We can have a relation of parents.
parent Fred Sue.
parent Jack Fred.
parent Amy Fred.
parent Grace Amy.
parent Tom Amy.

# Let's say we want to know all the ancestor
# relations of all the known entities.

# We need to create 2 rules so TML knows,
# what ancestor means. Ancestor is a parent
# or a parent of an ancestor.

# 'parent of a child is an ancestor of the
# child':
ancestor ?anc ?child :-
    parent ?anc ?child.

# 'parent of a child, who is an ancestor of
# its descendant, is an ancestor of the
# descendant':
ancestor ?anc ?desc :-
    parent ?anc ?child, ancestor ?child ?desc.

# Notice how ancestor relation is used in both
# head and body. This is causing the recursion.`,

	'TRANSITIVE CLOSURE':
`# Transitive closure (TC)
#
# TC of a directed graph is simply another
# directed graph representing paths
# in the original graph.
#
# This is a classical example of recursion.
#
# Let's have a directed graph represented by
# following 'e' relation:

e 1 2.
e 2 3.
e 3 4.
e 4 5.
e 5 1.
e 8 9.

tc ?x ?y :- e ?x ?y.
# Edge from ?x to ?y is a path from ?x to ?y.

tc ?x ?y :- tc ?x ?z, e ?z ?y.
# If there is a path from ?x to ?z and there
# is an edge from ?z to ?y there is path from
# ?x to ?y

# TML infers all the possible paths in the
# 'e' graph into 'tc' graph.`,

	eNEGATION:
`# Negation
#
# For negation is used a '~' character.
# You can read it as 'not'.

bird Coco.
bird Charlie.
wounded Charlie.

# You can use negation in bodies
canFly ?X :- bird ?X, ~wounded ?X.
# ?X can fly if ?X is bird and is not wounded.
# or simply: Not wounded bird can fly.

# Coco and Charlie are birds but Charlie is
# wounded. The only fact TML can infer here
# is that Coco can fly.`,

	eDELETION:
`# Negation in heads deletes the fact from
# the database of facts.

happy.          # happy.
~happy :- sad.  # not happy if sad.
sad.            # sad.
# will result into 'sad'. No 'happy'.
`,

   directedGraph:
`
# e relation represents directed graph:
# 1->2, 2->3, 3->4, 4->5, 5->1
e 1 2.
e 2 3.
e 3 4.
e 4 5.
e 5 1.

# Following program should get the first
# non-direct (transitive) path from each
# node of the graph 'e'

# state of the program: not done
notdone.

# TRANSITIVE CLOSURE to get all
# possible paths through the graph
# while notdone
t ?x ?y :- e ?x ?y, notdone.
t ?x ?z :- t ?x ?y, e ?y ?z, notdone.

# and we are done (yes, in the 1st step)
done :- notdone.

# if done, remove original graph
# from the resulting graph
~t ?x ?y :- e ?x ?y, done.

# if done, then remove notdone fact to
# stop the TC
~notdone :- done.`,

	family:
`father Tom Amy.
father Jack Fred.
father Tony CarolII.
father Fred CarolIII.

mother Grace Amy.
mother Amy Fred.
mother CarolI CarolII.
mother CarolII CarolIII.

parent ?X ?Y :- father ?X ?Y.
parent ?X ?Y :- mother ?X ?Y.
ancestor ?X ?Y :- parent ?X ?Y.
ancestor ?X ?Y :- parent ?X ?Z, ancestor ?Z ?Y.

# This example is taken
# from Datalog Educational System
# http://des.sourceforge.net/`,

	armageddon:
`# There are birds Charlie and Coco
bird Charlie.
bird Coco.

# and there are humans John and Jane,
human John.
human Jane.

# Uncomment the following line to end the world
# armageddon.

# bird is a being
being ?x :- bird ?x.

# human is a being
being ?x :- human ?x.

# beings are mortal
mortal ?x :- being ?x.

# if armageddon, then all mortals die
dead ?x :- mortal ?x, armageddon.

# what dies isn't bird/human/
# mortal/being anymore
~bird ?x :- dead ?x.
~human ?x :- dead ?x.
~mortal ?x :- dead ?x.
~being ?x :- dead ?x.`,

	eUNSAT:
`# Following program does 6 steps and returns
# to the state where it initially started.
#
# TML has to stop and outputs: unsat
#
# Not stopping would cause an infinite loop

start.
running :- start.
~start :- running.
stop :- running.
~running :- stop.
start :- stop.
~stop :- start.
`,
	unsat2:
`# Following program does 6 steps and returns
# to the state where it initially started.
#
# TML has to stop and outputs: unsat
#
# Not stopping would cause an infinite loop

start.
running :- start.
~start :- running. `
]).


:- current_prolog_flag(os_argv,_).

:- ensure_loaded(library(tauchain/tml_interp)).

:- writeln('# READER TESTS').
:- writeln('````').

%:- if((current_prolog_flag(os_argv,X),member('tml_reader.pl',X))).


:- test_tml_r("  
e(1 2).
e(2 1).
e(?x ?y) :- e(?x ?z), e(?z ?y).
").

:- test_tml_r("  
	~S(?x ?x):-S(?x ?x).
	~prog(?x?x):-prog(?x ?x).
	~alt(?x ?x):-alt(?x ?x).
	~alts(?x ?x):-alts(?x ?x).
").



:- test_tml_r("  
a(b c).
a(b(c)).
").

:- test_tml_r("  
a(1 2 3).
rel('t' 1 2).
").

:- test_tml_r("  
b(?x).
@trace foo
").

:- test_tml_r("  
@trace bar.
r.
?hi.
!!rel('t' 1 2)
!rel('t' 1 2).
").

:- test_tml_r("  
a(b c).
a(b(c)).
{a(1 2 3).
rel('t' ?1 2).
b(?x).
r.}
!!rel('t' 1 2)
!rel('t' 1 2).
").

:- test_tml_r(" !! e ?x v1. ").
:- test_tml_r(" ! e ?x v1. ").

:- test_tml_r(`father Tom Amy.
father Jack Fred.
father Tony CarolII.
father Fred CarolIII.

mother Grace Amy.
mother Amy Fred.
mother CarolI CarolII.
mother CarolII CarolIII.

parent ?X ?Y :- father ?X ?Y.
parent ?X ?Y :- mother ?X ?Y.
ancestor ?X ?Y :- parent ?X ?Y.
ancestor ?X ?Y :- parent ?X ?Z, ancestor ?Z ?Y. `).



:- test_tml_r(" 
#{
        e v1 v2.
#}
").

:- test_tml_r(" e ?x ?y :- e ?x ?z, e ?z ?y. ").


:- test_tml_r("
        e v2 v3.
        e v3 v4.
        e v4 v5.
        e v5 v1.
        e ?x ?y :- e ?x ?z, e ?z ?y.
       !! e ?x v1.
").

:- test_tml_r("
       !! e ?x v1.
{
       a b c d.
       ~e ?x ?x :- e ?x ?x.
}
").
:- writeln('````').

%:- break.
%:- cls.

%:- pfcWatch, mpred_trace.

:- tml_examples([_|List]), 
   % reverse(List,[_,R|_RList]),
   maplist(ain_test,List).
/*

:- mpred_trace.

:-
  ain_test([
	(j(X), k(Y) ==> bothJK(X,Y)),
	(bothJK(X,Y), go ==> jkGo(X,Y)),
	j(1),
	go,
	k(2),
        {pfcShowWhy(bothJK(1,2))}        
       ]).


:- mpred_trace.
:- 
    ain_test([(faz(X), ~baz(Y)/{X=:=Y} ==> fazbaz(X)),
         (fazbaz(X), go ==> found(X)),
	 (found(X), {X>=100} ==> big(X)),
	 (found(X), {X>=10,X<100} ==> medium(X)),
	 (found(X), {X<10} ==> little(X)),
	 faz(1),
	 goAhead,
	 baz(2),
	 baz(1)
	]).

:- mpred_trace.
*/

% :- endif.

end_of_file.

end_of_file.


#{
@string str <tml.g>.

identifier => sym | var.
args => identifier ws args | null.
var => '?' chars.
sym => chars.
relname => sym.
chars => alpha chars1 | '_' chars1.
chars1=> alnum chars1 | '_' chars1 | null.
ws =>	space ws | ws '#' printable_chars eol ws | null.
terminal => quoted_char | string.
quoted_char => 	'\'' printable '\'' | "'\\r'" | "'\\n'"
		| "'\\t'" | "'\\''" | "''".
eol => '\r' | '\n' | ''.
nonterminal => relname.
fname => '<' printable_chars '>' ws.
string => '"' printable_chars '"' ws.
printable_chars => printable printable_chars | null.
cmdline => '$' digits ws.
query => '!' ws term | "!!" ws term.

term => relname args.
pred => term | '~' ws term ws.
args => ws '(' ws args1 ws ')' ws | null.
args1 => identifier ws args1 ws | args | null.

directive =>	ws "@string" space ws strdir ws '.' ws |
		ws "@stdout" space ws term ws '.' ws |
		ws "@trace" space ws relname ws '.' ws |
		ws "@bwd" ws '.' ws.
strdir => relname ws fname | relname ws string | relname ws cmdline | relname ws term.

production => relname ws "=>" ws alt ws alts ws '.' ws.
alt =>	terminal ws alt ws | nonterminal ws alt ws | null.
alts => null | '|' ws alt ws alts ws.

fact => pred '.' ws.
preds => ws pred preds_rest.
preds_rest => ws ',' ws pred ws preds_rest | null.
rule => ws preds ws ":-" ws preds ws '.' ws.

fof => term ws ':' '=' ws form ws '.' ws.
form => term |
	ws prefix ws var ws '(' ws form ws ')' ws |
	ws '(' ws form ws ')' ws "and" ws '(' ws form ws ')' ws |
	ws '(' ws form ws ')' ws "or" ws '(' ws form ws ')' ws |
	ws "not" '(' ws form ws ')' ws |
	ws term ws "and" ws '(' ws form ws ')' ws |
	ws term ws "or" ws '(' ws form ws ')' ws |
	ws "not" '(' ws form ws ')' ws |
	ws term ws "and" ws term ws |
	ws term ws "or" ws term ws |
	ws "not" term ws |
	ws '(' ws form ws ')' ws "and" ws term ws |
	ws '(' ws form ws ')' ws "or" ws term ws.
prefix => "forall" | "exists" | "unique".

prog => directive S | rule S | production S | fof S | query S | null.
S => ws '{' ws prog ws '}' ws S ws | ws prog ws | null.
#}
#{
#	~S(?x?x):-S(?x?x).
#	~prog(?x?x):-prog(?x?x).
#	~alt(?x?x):-alt(?x?x).
#	~alts(?x?x):-alts(?x?x).
#}


