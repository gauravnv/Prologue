/* Prologue, by <Gaurav, Nathan, and Ruperto>. */

:- dynamic i_am_at/1, at/2, holding/1.
:- retractall(at(_, _)), retractall(i_am_at(_)), retractall(alive(_)).

i_am_at(someplace).

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


/* These rules define the direction letters as calls to go/1. */

yes :- choice(yes).

no :- choice(no).

/* This rule tells how to move in a given direction. */

choice(Direction) :-
        i_am_at(Here),
        path(Here, Direction, There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        !, look.

choice(_) :-
        write('You can''t choose that.').


/* This rule tells how to look about you. */

look :-
        i_am_at(Place),
        describe(Place),
        nl,
        notice_objects_at(Place),
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


/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.             -- to start the game.'), nl,
        write('n.  s.  e.  w.     -- to go in that direction.'), nl,
        write('take(Object).      -- to pick up an object.'), nl,
        write('drop(Object).      -- to put down an object.'), nl,
        write('look.              -- to look around you again.'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('halt.              -- to end the game and quit.'), nl,
        nl.


/* This rule prints out instructions and tells where you are. */

start :-
        instructions,
        look.


/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(beginning) :- 
        write('The most dangerous moment in any story is the beginning.'), nl,
        write('As the story opens, every ending is equally possible, every path unwalked, every question not only unanswered, but unasked.'), nl,
        write('The unread story is infinite possibility. Yet the ending is already written, and though you be clever, though you be brave, there is no outwitting it.'), nl,
        write('Are you brave enough to begin? If so, type "yes". If not, type "no". Halt this program and run it again. No one will think any less of you.'), nl.

describe(garden) :- 
        write('You find yourself standing in a beautiful garden. It teems with all the birds of the air, and all of the creatures of the Earth, and every good thing that grows. As you explore, you feel an incredible sense of peace and rightness, as if the garden had been created just for you.'), nl.

describe(beginning) :- 
        write(''), nl.

describe(beginning) :- 
        write(''), nl.

describe(beginning) :- 
        write(''), nl.

describe(beginning) :- 
        write(''), nl.

describe(beginning) :- 
        write(''), nl.

describe(beginning) :- 
        write(''), nl.

describe(beginning) :- 
        write(''), nl.

describe(beginning) :- 
        write(''), nl.

describe(beginning) :- 
        write(''), nl.

describe(beginning) :- 
        write(''), nl.
% Story branches you could take

% Pg 0
branch(beginning, yes, garden).
branch(beginning, no, end).

% Pg 1
branch(garden, yes, gates).
branch(garden, no, end).

% Pg 37
branch(gates, yes, sleep).
branch(gates, no, no_sleep).

% Pg 47
branch(story, _, end).

% Pg 25
branch(no_sleep, yes, story).
branch(no_sleep, no, no_story).

% Pg 62
branch(no_story, yes, dance).
branch(no_story, no, no_dance).

% Pg 72
branch(no_dance, yes, look_back).
branch(no_dance, no, no_look_back).

% Pg 89
branch(look_back, _, end).

% Pg 114 
branch(no_look_back, _, end).

% Pg 56
branch(dance, _, end).

% Pg 3
branch(sleep, _, end).
