%%%Μουταφίδης Δημήτρης ΑΕΜ:3028
%%%Ματσκίδης Ιωάννης ΑΕΜ:3010
%%%Κακαζιάνης Γιώργος ΑΕΜ:3014

%%%Για να γίνει δεκτή η ListOfKeywords θα πρέπει να περικλείεται από ('').
%%% πχ. query(['rules']) ή query(['rules','exceptions-2']).

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



%%% remove_weight/2
%%% remove_weight(W,W1).
%%% W is Weight and W1 is the final word without weight and symbol (-)

% Remove - and weight from keyword
remove_weight(W,W1):-
(sub_string(case_insensitive,'-',W)->weight(W,Weight),number_string(Weight,S),remove_char(W,S,Temp),remove_char(Temp,"-",W1);W1=W),!.


%%% remove_char/3
%%% remove_char(S,C,X).
% Remove char and return final word
remove_char(S,C,X) :- atom_concat(L,R,S), atom_concat(C,W,R), atom_concat(L,W,X).

%%% weight/2
%%% weight(W,Weight).
%Returns the Weight(The weight of an element[word/phrase]).
weight(W,Weight):-
(is_phrase(W)->atom_chars(W,M),(sub_string(case_insensitive,'-',M)->reverse(M,[H|_]),atom_number(H,Num),Weight is Num;Weight is 1);
atom_chars(W,L),
(sub_string(case_insensitive,'-',L)->
reverse(L,[H1|_]),atom_number(H1,Num1),Weight is Num1,!;Weight is 1)).

%%% calculate_score/2
%%% calculate_score(List,FinalScore).

%Calculate the final Score for the ListOfKeywords
calculate_score(List,FinalScore):-
max_list(List,Max),
sum_list(List,Sum),
FinalScore is (1000*Max)+Sum.


%%% is_phrase/1
%%% is_phrase(S).
%Used to see if element is phrase.
is_phrase(S):-
sub_string(case_insensitive,' ',S).

%%% length_phrase/2
%%% length_phrase(W,L).

%Return the L (how many words in the phrase)
length_phrase(W,L):-
(sub_string(case_insensitive,'-',W)->atom_chars(W,K),
tokenize_atom(K,O),
length(O,L1),L is L1-1;
atom_chars(W,K),
tokenize_atom(K,O),
length(O,L)).

%%% list_member/2
%%% list_member(X,[H|T]).
%Create list for score.
list_member(X,[X|_]).
list_member(X,[_|T]):-
    list_member(X,T).

%%% list_append/3
%%% list_append(A,T,T).
% Append an element to list.
list_append(A,T,T):-list_member(A,T),!.
list_append(A,T,[A|T]).

%%% count/3
%%% count(X,[H|T],N).
%Return how many times a word found in Title or topics
count(_,[],0).
count(X,[H|T],N):-
!,(sub_string(case_insensitive,H,X)->count(X,T,N1),
N is N1+1;count(X,T,N)).
count(X,[_|T],N):-
count(X,T,N).

%%% add_tail/3
%%% add_tail(+List,+Element,-List)
add_tail([],X,[X]).
add_tail([H|T],X,[H|L]):-add_tail(T,X,L).

%%% check_word/4
%%% check_word(Keyword,Word,Weight,Score).
%If the element of ListOfKeywords is a word check her score.
check_word(Keyword,Word,Weight,Score):-
sub_string(case_insensitive,Keyword,Word)->Score is Weight;Score is 0.

%%% check_score/3
%%% check_score(Keyword,Word,Score).
% Checks Keyword is word or phrase, calls the right argument if it's
% word, else calculate the score
check_score(Keyword,Word,Score):-
weight(Keyword,Weight),remove_weight(Keyword,Z),length_phrase(Keyword,L),(L>1->(sub_string(case_insensitive,Z,Word)->Temp_Score is Weight;Temp_Score is 0),tokenize_atom(Z,List),count(Word,List,S),Score1 is S*(Weight/L)+Temp_Score,Score is Score1;count(Word,Z,S),Score1 is S*Weight,Score is Score1;check_word(Z,Word,Weight,Score1),Score is Score1).



%%% score_by_title/4
%%% score_by_title(H,[Head|Tail],L,Sc).
% Check score for title.
score_by_title(_,[],_,_).
score_by_title(H,[Head|Tail],L,Sc):-
check_score(Head,H,Sc1),
Sc2 is 2*Sc1,
Sc4 is L+Sc2,
(not(length(Tail,0))->score_by_title(H,Tail,Sc4,Sc);Sc is Sc4).

%%% check_topics/4
%%% check_topics([YHead|YTail],ListOfKeywords,L,Score).
% Check score for topics.
check_topics([],_,_,_).
check_topics([YHead|YTail],ListOfKeywords,L,Score):-
score_by_topics(YHead,ListOfKeywords,[],Final1),
sum_list(Final1,Sum),
add_tail(L,Sum,Final),
(not(length(YTail,0))->check_topics(YTail,ListOfKeywords,Final,Score);Score=Final).

%%% score_by_topics/4
%%% score_by_topics(H1,[Head|Tail],L,Final).
%Check the topics' score and returns a score list of the topics.
score_by_topics(_,[],_,_).
score_by_topics(H1,[Head|Tail],L,Final):-
check_score(Head,H1,Sc),
add_tail(L,Sc,List),
(not(length(Tail,0))->score_by_topics(H1,Tail,List,Final);
Final=List).

%%% checking/4
%%% checking([H|T],Y,ListOfKeywords,Score).
% Checks the score for ListOfKeywords (first by title then by topics)
checking([],_,_,_).
checking([H|T],Y,ListOfKeywords,Score):-
score_by_title(H,ListOfKeywords,0,Score_title),
check_topics(Y,ListOfKeywords,[],Score_topics),
list_append(Score_title,Score_topics,Score_List),
calculate_score(Score_List,Score),
checking(T,Y,ListOfKeywords,Score).

%%% check_title_topics/2
%%% check_title_topics(ListOfKeywords,Score).
% For every title and topics checking and calculate score.
check_title_topics(ListOfKeywords,Score):-
    session(X,Y),
    checking([X],Y,ListOfKeywords,Score).

%%% create_list/2
%%% create_list(ListOfKeywords,List1).
% Create list with score.
create_list(ListOfKeywords,List1):-
findall(Score,check_title_topics(ListOfKeywords,Score),List1).

%%% remove/3
%%% remove([G|H],N,[G|L]).
% Remove nth element of list and return a new list without this element.
remove([],_,_):-!.
remove([_|H],0,H):-!.
remove([G|H],N,[G|L]):- N >=1 ,Nn is N-1,!,remove(H,Nn,L).

%%% find/3
%%% find([H|T],X1,P).
%   For all score print title and score.
find([],_,_):-!.
find([H|T],X1,P):-
nth0(Z,X1,H),
nth0(Z,P,A),
remove(X1,Z,L),
remove(P,Z,P1),
printing(A,H),
find(T,L,P1).

%%% func/2
%%% func(Sorted,Unsorted).
% Set all title in list and call find predicate to printing final results.
func(Sorted,Unsorted):-
findall(X,session(X,_),P),find(Sorted,Unsorted,P),!.

%%% printing/2
%%% printing(X,P).
%Print the sessions and their relevance
printing(X,P):-
write('Session: '),write(X),nl,write('Relevance = '),write(P),nl.

%%% sorting/2
%%% sorting(List,Sorted).
%Sort the sessions by score relevance.
sorting(List, Sorted):-
sort(0,@>=,List,Sorted).

%%% query/1
%%% query(ListOfKeywords).
% Create list with score, sorting and printing results.
query(ListOfKeywords):-
create_list(ListOfKeywords,List),sorting(List,S),func(S,List).
