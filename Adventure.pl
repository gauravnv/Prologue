/* Prologue, by <Gaurav, Nathan, and Ruperto>. */

% ========================== stuff from boilerplate ========================= %

:- dynamic i_am_at/1, at/2, holding/1.
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

i_am_at(beginning).

/* This rule just writes out game instructions. */

instructions :-
        nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('start.             -- to start the game.'), nl,
        write('look.              -- to look around you again.'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('halt.              -- to end the game and quit.'), nl,
        nl.

start :- instructions, look.

/* This rule tells how to look about you. */

look :-
        i_am_at(Place),
        describe(Place).

/* These rules define the direction letters as calls to go/1. */

yes :- choose(yes).

no :- choose(no).

/* This rule tells how to move in a given direction. */

choose(Choice) :-
        i_am_at(Here),
        branch(Here, Choice, There),
        retract(i_am_at(Here)),
        assert(i_am_at(There)),
        !, look.

choose(_) :-
        write('You can''t choose that.').

/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(beginning) :- 
        write('The most dangerous moment in any story is the beginning.'), nl, nl,
        write('As the story opens, every ending is equally possible, every path'),
        write(' unwalked, every question not only unanswered, but unasked.'), nl, nl,
        write('The unread story is infinite possibility. Yet the ending is already'),
        write(' written, and though you be clever, though you be brave, there is no'),
        write(' outwitting it.'), nl, nl,
        write('Are you brave enough to begin? If so, type "yes.". If not, type "no.".'),
        write(' Halt this program and run it again. No one will think any less of'),
        write(' you.'), nl, nl.

describe(garden) :- 
        write('You find yourself standing in a beautiful garden. It teems with all'),
        write(' the birds of the air, and all of the creatures of the Earth, and'),
        write(' every good thing that grows. As you explore, you feel an incredible'),
        write(' sense of peace and rightness, as if the garden had been created just'),
        write(' for you.'), nl, nl,
        write('This is the place you belong. Still, you are restless and lonely. You'),
        write(' begin to explore your surroundings. At the western edge of the garden,'),
        write(' there is a gate. Do you walk through?'), nl, nl,
        write('Type "yes." or "no.".'), nl, nl.

describe(gates) :- 
        write('Gates, like books, are meant to be opened, and you would never be truly'),
        write(' content if you did not know what lay on the other side. You pass'),
        write(' through the gate and enter into a dark forest. You hesitate for a'),
        write(' moment, look back, but the forest stretches behind you as if the garden'),
        write(' had never been.'), nl, nl,
        write('You continue on.'), nl, nl,
        write('Shadows deepen. An owl calls. Something cries out at a distance and is'),
        write(' silenced. You grow chilled, and your feet develop a talent for finding'),
        write(' uneven spots of ground, tree roots, and rocks. After the third time you'),
        write(' fall, you lean against the very tree whose roots last tangled your feet.'),
        nl, nl,
        write('The bark prickles and rubs against your back, but it is a welcome'),
        write(' distraction from your bruised knees and skinned palms. Your bones are'),
        write(' weary and your muscles ache.'), nl, nl,
        write('You crave sleep. A brief rest to fortify yourself for your journey.'),
        write(' Do you close your eyes?'), nl, nl,
        write('Type "yes." or "no.".'), nl, nl.

describe(sleep) :- 
        write('You close your eyes, and drift into sleep. When you awaken, you are in'),
        write(' your own bed. The previous events were a dream, which has already begun'),
        write(' to fade.'), nl, nl,
        write('You spend the rest of your life trying to return to the winding path in'),
        write(' the dark forest. You never will.'), nl, nl.

describe(no_sleep) :- 
        write('You scrub your hands across your eyes and push yourself back to your feet.'),
        write(' The path takes you on a short, downhill curve, and winds around to the door'),
        write(' of an inn. The Quill and Ink, reads the sign over the door. You smile, and'),
        write(' enter.'), nl, nl,
        write('Inside, there is warmth, the hearty scent of food, and a group of people'),
        write(' singing songs both off-key and bawdy.'), nl, nl,
        write('You slide seamlessly into the small community, and feel refreshed after'),
        write(' you have shared a meal and stood a round of drinks.'), nl, nl,
        write('Eventually, you notice the singing has died down, replaced by a rapt'),
        write(' silence. There is a knot of people wound tight around the fire, telling'),
        write(' stories. At first, you simply listen, but then you are asked to tell a tale'),
        write(' of your own. It is the tale, not the coin, that will pay your shelter for'),
        write(' the night.'), nl, nl,
        write('Do you tell a story?'), nl, nl,
        write('Type "yes." or "no.".'), nl, nl.

describe(story) :- 
        write('You are warm and happy, and just drunk enough to think that telling a story'),
        write(' is something you can do. You invoke the muse, and she speaks through you.'),
        write(' When you finish, only the crackling of the fire breaks the silence. You'),
        write(' watch as, next to you, a single tear trickles down a perfect cheek.'), nl, nl,
        write('It is the last story you will ever tell.'), nl, nl.

describe(no_story) :- 
        write(''), nl.

describe(dance) :- 
        write(''), nl.

describe(no_dance) :- 
        write(''), nl.

describe(look_back) :- 
        write(''), nl.

describe(no_look_back) :- 
        write(''), nl.

describe(play_again) :- 
        write('Do you want to play again? Type "yes." to continue or "halt." to stop'), nl, nl.

% Story branches you could take

% Pg 0
branch(beginning, yes, garden).
branch(beginning, no, play_again).

% Pg 1
branch(garden, yes, gates).
branch(garden, no, play_again).

% Pg 37
branch(gates, yes, sleep).
branch(gates, no, no_sleep).

% Pg 3
branch(sleep, _, play_again).

% Pg 25
branch(no_sleep, yes, story).
branch(no_sleep, no, no_story).

% Pg 47
branch(story, _, play_again).

% Pg 62
branch(no_story, yes, dance).
branch(no_story, no, no_dance).

% Pg 56
branch(dance, _, play_again).

% Pg 72
branch(no_dance, yes, look_back).
branch(no_dance, no, no_look_back).

% Pg 89
branch(look_back, _, play_again).

% Pg 114 
branch(no_look_back, _, play_again).

branch(play_again, yes, beginning).