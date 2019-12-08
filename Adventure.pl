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
        %get0(_),
        sleep(3),
        write('===================================================='), nl, nl, nl.

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
        describe(newScene),
        write('You end up not getting enough money for rent and get evicted.'),
        write('Also, your girlfriend dumps you. Not signing up was a mistake.'), nl, nl,
        goto(play_again).

describe(firstBattle) :-
        describe(newScene),
        nickname(Nickname),
        assert(nickname(Nickname)),

        % Ask user for rhymes or fill in the blanks Store the inputs
        write('You feel yourself choke a little but you NEED to get that money'), nl, nl,
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

% describe(jump) :- .

% describe(no_jump) :- .

% TODO: remove/change these.
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
        describe(yesOrNo).

describe(no_gates):-
        write('You wish to see more of the garden before you leave its bounds. Soon, you'),
        write(' are glad you have chosen as you did, for you find the perfect companion'),
        write(' for all your days and nights. You come to believe you have found a new'),
        write(' Eden, as well. It seems impossible for a place so perfect to be other than'),
        write(' Paradise. When they are born, you name your children Kane and Abelle.'),
        nl, nl,
        write('This will prove to be a mistake.'), nl, nl,
        goto(play_again).

describe(sleep) :- 
        write('You close your eyes, and drift into sleep. When you awaken, you are in'),
        write(' your own bed. The previous events were a dream, which has already begun'),
        write(' to fade.'), nl, nl,
        write('You spend the rest of your life trying to return to the winding path in'),
        write(' the dark forest. You never will.'), nl, nl,
        goto(play_again).

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
        describe(yesOrNo).

describe(story) :- 
        write('You are warm and happy, and just drunk enough to think that telling a story'),
        write(' is something you can do. You invoke the muse, and she speaks through you.'),
        write(' When you finish, only the crackling of the fire breaks the silence. You'),
        write(' watch as, next to you, a single tear trickles down a perfect cheek.'), nl, nl,
        write('It is the last story you will ever tell.'), nl, nl,
        goto(play_again).

describe(no_story) :- 
        write('The only story you know is your own, you say, and you must continue on to'),
        write(' know how it ends. You make your excuses, and stand one more round before'),
        write(' you leave to ensure there will be no hurt feelings, and, more importantly,'),
        write(' no knives in the back as you walk through the door.'), nl, nl,
        write('The air is crisp, and you are refreshed. The moon limns the trees in silver,'),
        write(' and makes clear your path. You hear music, so beautiful that at first you'),
        write(' wonder if you are dreaming. The pound of the drums speeds the pulse of your'),
        write(' heart and the skirl of the strings pulls you through the night.'), nl, nl,
        write('By the time you reach the standing stones, you are very nearly dancing down'),
        write(' the path. Inside the ring of stones, the dancers spin and leap, a bright'),
        write(' chaos of form and shape, carried along by an exultation of song.'), nl, nl,
        write('You want, as you cannot remember wanting anything, to cross into the stone'),
        write(' circle and join the dance. Do you?'), nl, nl,
        describe(yesOrNo).

describe(dance) :- 
        write('As you step through the ring, every hair on your body stands as if'),
        write(' electrified. Your feet begin to move in a complex pattern you were never'),
        write(' taught, but now know in your blood.'), nl, nl,
        write('You do not wish to ever stop dancing. It is unlikely you ever will.'), nl, nl,
        goto(play_again).

describe(no_dance) :- 
        write('TODO'), nl, nl.

describe(look_back) :- 
        write('You’ve been reading the alternate endings, haven’t you? Of course I know.'),
        write(' I know everything that happens in all of the stories I hold.'), nl, nl,
        write('Did you think I wouldn’t notice that you’re cheating?'), nl, nl,
        write('Do you not understand that stories have rules?'), nl, nl,
        write('You feel a pulling, and then are buffeted by a whirlwind. You hear'),
        write(' something tear, feel a page come loose from your bindings.'), nl, nl,
        write('You find yourself back at the beginning, holding a book.'), nl, nl,
        write('You open the cover. Once upon a time.'), nl, nl,
        goto(play_again).

describe(no_look_back) :- 
        write('You continue walking, three steps more. Then a hand slips into yours, and'),
        write(' the story ends as all stories must: with the snip of a thread and the'),
        write(' crossing of a river. You pay the ferryman with coins plucked from your'),
        write(' own eyelids.'), nl, nl,
        write('You pass beyond the realm of the page.'), nl, nl,
        goto(play_again).

% Story branches you could take

% Pg 0
branch(beginning, yes, tournamentSignup).
branch(beginning, no, noTournamentSignup).

% Pg 1
branch(tournamentSignup, yes, firstBattle).
branch(tournamentSignup, no, no_gates).

branch(firstBattle, yes, jump).
branch(firstBattle, no, no_jump).

% TODO: remove/change these

%pg 19
branch(no_gates, _, play_again).

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