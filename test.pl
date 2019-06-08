%%% session/2
%%% session(Title,Topics).

% Facts about sessions, and respective topics

session('Rules; Semantic Technology; and Cross-Industry Standards',
['XBRL - Extensible Business Reporting Language',
'MISMO - Mortgage Industry Standards Maintenance Org',
'FIXatdl - FIX Algorithmic Trading Definition Language',
'FpML - Financial products Markup Language',
'HL7 - Health Level 7',
'Acord - Association for Cooperative Operations Research and Development (Insurance Industry)',
'Rules for Governance; Risk; and Compliance (GRC); eg; rules for internal audit; SOX compliance; enterprise risk management (ERM); operational risk; etc',
'Rules and Corporate Actions']).
session('Rule Transformation and Extraction',
['Transformation and extraction with rule standards; such as SBVR; RIF and OCL',
'Extraction of rules from code',
'Transformation and extraction in the context of frameworks such as KDM (Knowledge Discovery meta-model)',
'Extraction of rules from natural language',
'Transformation or rules from one dialect into another']).
session('Rules and Uncertainty',
['Languages for the formalization of uncertainty rules',
'Probabilistic; fuzzy and other rule frameworks for reasoning with uncertain or incomplete information',
'Handling inconsistent or disparate rules using uncertainty',
'Uncertainty extensions of event processing rules; business rules; reactive rules; causal rules; derivation rules; association rules; or transformation rules']).
session('Rules and Norms',
['Methodologies for modeling regulations using both ontologies and rules',
'Defeasibility and norms - modeling rule exceptions and priority relations among rules',
'The relationship between rules and legal argumentation schemes',
'Rule language requirements for the isomorphic modeling of legislation',
'Rule based inference mechanism for legal reasoning',
'E-contracting and automated negotiations with rule-based declarative strategies']).
session('Rules and Inferencing',
['From rules to FOL to modal logics',
'Rule-based non-monotonic reasoning',
'Rule-based reasoning with modalities',
'Deontic rule-based reasoning',
'Temporal rule-based reasoning',
'Priorities handling in rule-based systems',
'Defeasible reasoning',
'Rule-based reasoning about context and its use in smart environments',
'Combination of rules and ontologies',
'Modularity']).
session('Rule-based Event Processing and Reaction Rules',
['Reaction rule languages and engines (production rules; ECA rules; logic event action formalisms; vocabularies/ontologies)',
'State management approaches and frameworks',
'Concurrency control and scalability',
'Event and action definition; detection; consumption; termination; lifecycle management',
'Dynamic rule-based workflows and intelligent event processing (rule-based CEP)',
'Non-functional requirements; use of annotations; metadata to capture those',
'Design time and execution time aspects of rule-based (Semantic) Business Processes Modeling and Management',
'Practical and business aspects of rule-based (Semantic) Business Process Management (business scenarios; case studies; use cases etc)']).
session('Rule-Based Distributed/Multi-Agent Systems',
['rule-based specification and verification of Distributed/Multi-Agent Systems',
'rule-based distributed reasoning and problem solving',
'rule-based agent architectures',
'rules and ontologies for semantic agents',
'rule-based interaction protocols for multi-agent systems',
'rules for service-oriented computing (discovery; composition; etc)',
'rule-based cooperation; coordination and argumentation in multi-agent systems',
'rule-based e-contracting and negotiation strategies in multi-agent systems',
'rule interchange and reasoning interoperation in heterogeneous Distributed/Multi-Agent Systems']).
session('General Introduction to Rules',
['Rules and ontologies',
'Execution models; rule engines; and environments',
'Graphical processing; modeling and rendering of rules']).
session('RuleML-2010 Challenge',
['benchmarks/evaluations; demos; case studies; use cases; experience reports; best practice solutions (design patterns; reference architectures; models)',
'rule-based implementations; tools; applications; demonstrations engineering methods',
'implementations of rule standards (RuleML; RIF; SBVR; PRR; rule-based Event Processing languages; BPMN and rules; BPEL and rules); rules and industrial standards (XBRL; MISMO; Accord) and industrial problem statements',
'Modelling Rules in the Temporal and Geospatial Applications',
'temporal modelling and reasoning; geospatial modelling and reasoning',
'cross-linking between temporal and geospatial knowledge',
'visualization of rules with graphic models in order to support end-user interaction',
'Demos related to various Rules topics',
'Extensions and implementations of W3C RIF',
'Editing environments and IDEs for Web rules',
'Benchmarks and comparison results for rule engines',
'Distributed rule bases and rule services',
'Reports on industrial experience about rule systems']).


query(ListOfKeywords):-
    prepare(L),prepare1(Y),
    check(L,Y,ListOfKeywords,Score_List),printing(Score_List).


prepare(S):-
    setof(X,session(X,_),S).

prepare1(X):-
    setof(Y,session(_,Y),X).

%%% warning
check_if_string(W,W1):-
(string(W)->W1 is W,!;number_string(W,W2),atom_string(W2,W1)).


%%%Remove - and weight from keyword
remove_weight(W,W1):-
(sub_string(case_insensitive,'-',W)->weight(W,Weight),number_string(Weight,S),remove_char(W,S,Temp),remove_char(Temp,"-",W1);!),!.


remove_char(S,C,X) :- atom_concat(L,R,S), atom_concat(C,W,R), atom_concat(L,W,X).

weight(W,Weight):-
    (is_phrase(W)->atom_chars(W,M),(sub_string(case_insensitive,'-',M)->reverse(M,[H|_]),atom_number(H,Num),Weight is Num;Weight is 1);
    atom_chars(W,L),
    (sub_string(case_insensitive,'-',L)->
    reverse(L,[H1|_]),atom_number(H1,Num1),Weight is Num1,!;Weight is 1)).


calculate_score(List,FinalScore):-
    max_list(List,Max),
    sum_list(List,Sum),
    FinalScore is (1000*Max)+Sum,printing(FinalScore).


printing(Score):-
    session(X,_),
    write("Session:"),tab(1),write(X),nl,
    write("Relevance = "),write(Score).


is_phrase(S):-
    sub_string(case_insensitive,' ',S).



length_phrase(W,L):-
(sub_string(case_insensitive,'-',W)->atom_chars(W,K),
tokenize_atom(K,O),
length(O,L1),L is L1-1;
    atom_chars(W,K),
    tokenize_atom(K,O),
    length(O,L)).


%%%Create list for score.
list_member(X,[X|_]).
list_member(X,[_|T]):-
    list_member(X,T).
list_append(A,T,T):-list_member(A,T),!.
list_append(A,T,[A|T]).

score_by_one_word(H2,H,Score):-
weight(H2,Weight),(sub_string(case_insensitive,'-',H2)->remove_weight(H2,L),(sub_string(case_insensitive,L,H)->Score is Weight);(sub_string(case_insensitive,H2,H)->Score is Weight)).


count(_,[],0):-!.
count(X,[H|T],N):-
!,(sub_string(case_insensitive,H,X)->count(X,T,N1),
N is N1+1;count(X,T,N)).
count(X,[_|T],N):-
count(X,T,N).

%%%add_tail(+List,+Element,-List)
add_tail([],X,[X]).
add_tail([H|T],X,[H|L]):-add_tail(T,X,L).


%%%--------------------------------------------------------------------------------------------------
%%% H kai T einai to X
%%% H1 kai T1 einai to Y
%%% H2 kai T2 einai LoK
%%% Score_List einai i teliki lista me ta score
check([],[],[],_).
check([H|T],[H1,T1],[H2,T2],Score_List):-
    score_by_title(H,H2,Sc),
    %%%score_by_topics(H1,H2,[],L,_Title_score),
    Sc1 is 2*Sc,write(Sc1),
    check(T,T1,T2,Score_List).


score_by_phrase(H2,H,Score):-
weight(H2,Weight),length_phrase(H2,L),(sub_string(case_insensitive,'-',H2)->remove_weight(H2,Z),tokenize_atom(Z,List),count(H,List,S),Score is S*(Weight/L)
;tokenize_atom(H2,List),count(H,List,S),Score is S*(Weight/L)).


%%% H einai to X.
%%% H2 einai to ListOfKeywords.
score_by_title(H,H2,Sc):-
    score_by_phrase(H2,H,Sc1),
    Sc is 2*Sc1.

score_by_topics([],_,_,_):-!.
score_by_topics([H1|T1],Word,L,Final):-
    %%%write(H1),
    score_by_phrase(Word,H1,Sc),
%%%write("Score is "),write(Sc),nl,
    add_tail(L,Sc,List),
(not(length(T1,0))->score_by_topics(T1,Word,List,Final);
sum_list(List,Sum),max_list(List,Max),score(Sum,Max,Final)).
%%%write(Final),nl.





score(Sum,Max,Final):-
    Final is (1000*Max)+Sum.

test(S,Score):-
    session(X,Y),score_by_title(X,'rules and norms',Sc),score_by_topics(Y,'rules and norms',[],S1),Score=Sc,S=S1.
