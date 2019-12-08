/* Prologue, by <Gaurav, Nathan, and Ruperto>. */

% ========================== stuff from boilerplate ========================= %

:- dynamic i_am_at/1, at/2, holding/1, nickname/1.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)).

path(someplace, n, someplace).

at(thing, someplace).

/* These rules describe how to pick up an object. */

take(X) :-
        holding(X),
        write('You''re already holding it!'),
        !, nl.

take(X) :-
        i_am_at(Place),
        at(X, Place),
        retract(at(X, Place)),
        assert(holding(X)),
        write('OK.'),
        !, nl. 

take(_) :-
        write('I don''t see it here.'),
        nl.


/* These rules describe how to put down an object. */

drop(X) :-
        holding(X),
        i_am_at(Place),
        retract(holding(X)),
        assert(at(X, Place)),
        write('OK.'),
        !, nl.

drop(_) :-
        write('You aren''t holding it!'),
        nl.

/* These rules set up a loop to mention all the objects
   in your vicinity. */

notice_objects_at(Place) :-
        at(X, Place),
        write('There is a '), write(X), write(' here.'), nl,
        fail.

notice_objects_at(_).


/* This rule tells how to die. */

die :-
        finish.


/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */

finish :-
        nl,
        write('The game is over. Please enter the "halt." command.'),
        nl.

/* This rule prints out instructions and tells where you are. */

% ========================== stuff we've actually done ========================= %


/* Instructions ---- TODO: dont think we really need this? */
instructions :-
        nl,
        write('***************** INSTRUCTIONS *****************'),
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.             -- to start the game.'), nl,
        write('look.              -- to look around you again.'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('halt.              -- to end the game and quit.'), nl,
        nl.

i_am_at(beginning).

start :- look.

/* describe where you're currently at */

look :-
        i_am_at(Place),
        describe(Place).

/* choice options */

yes :- choose(yes).

no :- choose(no).

/* moving from branch to branch */

choose(Choice) :-
        i_am_at(Here),
        branch(Here, Choice, There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        !, look.

choose(_) :-
        write('You can\'t choose that.').

% directly go to somewhere
goto(Place) :-
        retract(i_am_at(_)),
        assert(i_am_at(Place)),
        !, look.

% Story
describe(play_again) :- 
        write('Do you want to play again? Type "yes." to continue or "halt." to quit'), nl, nl.

describe(yesOrNo) :-
        write('** Type "yes." or "no.".'), nl, nl.

describe(input) :-
        write('** Type your response surrounded by quotes and add a dot after the ending quote.'), nl, nl.

describe(newScene) :-
        sleep(2),
        nl, nl, write('||'), nl, write('||'), nl, write('||'), nl, nl.

describe(beginning) :- 
        nl,
        write('You are late for your rent and need money to pay for it.'),
        write(' Your friend Matt tells you there will be a rap battle tournament with a big prize soon.'), nl, nl,
        write('>> MATT: Yooo dude, check this out! There is a rap battle tournament with a $1k prize!'),
        write(' You should sign up for it. What do you say?'), nl, nl,
        write('What do you say to Matt?'), nl, nl,
        describe(yesOrNo).

describe(tournamentSignup) :- 
        nl,
        write('>> YOU: Yeah I\'m down!'), nl, nl, 
        describe(newScene),
        write('You arrive at the tournament signup.'), nl, nl,
        write('>> BIG MIKE: Hey punk. So you think you got what it takes to beat Vancouver\'s best rappers'),
        write(' in a battle to the death?'), nl, nl,
        write('>> YOU: Uhhhhhh... well I mean...'), nl, nl,
        write('>> BIG MIKE: It\'s your funeral. Just hurry up and give me your nickname so I can sign you up.'), nl, nl,
        describe(input),
        read(Nickname),
        assert(nickname(Nickname)), nl,
        write('>> BIG MIKE: Alright, '), write(Nickname), write(', you\'re all set. Your next battle is ... right now! '),
        write('You will go against Too-pak!'), nl, nl,
        goto(firstBattle).

describe(noTournamentSignup) :- 
        nl,
        write('What is your excuse?'), nl, nl,
        describe(input),
        read(Excuse), nl,
        write('>> YOU: Nah, man. '), write(Excuse), nl, nl,
        write('>> MATT: Ahhh, I feel you dude.'), nl, nl,
        describe(newScene),
        write('You end up not getting enough money for rent and get evicted.'),
        write('Also, your girlfriend dumps you. Not signing up was a mistake.'), nl, nl,
        goto(play_again).

describe(firstBattle) :-
        describe(newScene),
        nickname(Nickname),
        assert(nickname(Nickname)),

        % Ask user for rhymes or fill in the blanks Store the inputs
        write('You feel yourself choke a little but you NEED to get that money...start thinking about your rhymes!'), nl, nl,
        write('Enter a singular noun for a valuable object'), nl,
        describe(input),
        read(SingularValuableNoun),
        assert(singularValuableNoun(SingularValuableNoun)), nl,
        write('I ain\'t got a shiny new grill but got a heart of a '), write(SingularValuableNoun), nl,
        write('Enter a new line that rhymes with previous one!'), nl,
        read(NewDope1),
        assert(newDope1(NewDope1)), nl,
        write('Enter a positive adjective'), nl,
        describe(input),
        read(PositiveAdjective),
        assert(positiveAdjective(PositiveAdjective)), nl,
        write('Fudge the struggle, I been '), write(PositiveAdjective), nl,
        write('Enter a new line that rhymes with previous one!'), nl,
        read(NewDope2),
        assert(newDope2(NewDope2)), nl, nl,
        
        % TODO: Too-pak's rhymes
        write('>> Too-pak: You\'s a pop tart sweetheart, you soft in the middle'), nl,
        write('I eat you for breakfast, the watch was exchanged for your necklace'), nl, 
        write('What\'s funny '), 
        write(Nickname), 
        write(' really think you grimy too'), nl,
        write('Now everybody liked you better in that shiny suit.'), nl, nl,

        describe(newScene),

        write('Everybody is going crazy and chanting "Too-pak!", "Too-pak!"'), nl,
        write('You grab the mic and you begin...'), nl, nl,

        % Character raps here
        write('I ain\'t got a shiny new grill but got a heart full of '), write(SingularValuableNoun), nl,
        write(NewDope1), nl,
        write('Fudge the struggle, I been '), write(PositiveAdjective), nl,
        write(NewDope2), nl, nl,

        write('You killed it! The audience is chanting "'), write(Nickname), write('! '),
        write(Nickname), write('! '), write(Nickname), write('!"'), nl, nl,
        write('Do you jump onto the audience?'), nl, nl,
        describe(yesOrNo).

describe(jump) :- 
        write('The crowd roars and carries you back to the entrance of the club.'), nl,
        write('There, you meet a girl and you two hit it off'), nl,
        write('she invites you back to her place and you leave the club with her.'), nl, nl,

        write('...............Night one of the tournament is done...............'), nl, nl,
        goto(nightTwo).


describe(no_jump) :- 
        write('The crowd thinks you\'re a tough guy and you earn their respect.'), nl,
        write('You leave the club with Matt and you\'re really determined for the next night.'), nl, nl,

        write('...............Night one of the tournament is done...............'), nl, nl,
        goto(nightTwo).
                        


describe(nightTwo) :-
        describe(newScene),
        write('You\'re back at the club.'), nl, nl,

        
        describe(yesOrNo).

% Story branches you could take

% Pg 0
branch(beginning, yes, tournamentSignup).
branch(beginning, no, noTournamentSignup).

% Pg 1
branch(tournamentSignup, yes, firstBattle).
branch(tournamentSignup, no, ).

branch(firstBattle, yes, jump).
branch(firstBattle, no, no_jump).

% TODO: remove/change these
branch(play_again, yes, beginning).