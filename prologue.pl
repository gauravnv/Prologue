/* Prologue, by <Gaurav, Nathan, and Ruperto>. */

% Inspired by boilerplate code from:  https://www.cis.upenn.edu/~matuszek/cis554-2015/Assignments/prolog-02-adventure-game.html
% Inspiration drawn from "8 Mile - The Movie", Mad Verse City (Jackbox)

:- dynamic i_am_at/1,  nickname/1.
:- retractall(i_am_at(_)).

/* Instructions ---- TODO: dont think we really need this? */
instructions :-
        nl,
        write('***************** INSTRUCTIONS *****************'), nl,
        write('Enter commands using standard Prolog syntax.'), nl,
        write('Available commands are:'), nl,
        write('instructions.      -- to see this message again.'), nl,
        write('halt.              -- to end the game and quit.'), nl,
        nl.

i_am_at(beginning).

start :- instructions, describe(newScene), look.

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
        % sleep(2),
        write('** Enter any key (followed by a dot) to continue.'), nl, nl,
        read(_),
        get_single_char(_), nl,
        write('||'), nl, write('||'), nl, write('||'), nl, nl.

describe(beginning) :- 
        nl,
        write('You wake up and remember that you are late on your rent and need money to pay for it ASAP.'),
        write('Your phone rings. It\'s your friend Mad Matt.'), nl, nl,
        write('>> MAD MATT: Yooo dude, check this out! There\'s this bomb ass rap battle tournament with a $1k prize!'),
        write('I\'ve heard what you got. You should totally sign up for it. What do you say bruh?'), nl, nl,
        write('What do you say to Matt?'), nl, nl,
        describe(yesOrNo).

describe(tournamentSignup) :- 
        nl,
        write('>> YOU: Yeah I\'m down!'), nl, nl, 
        describe(newScene),
        write('You arrive at the tournament signup.'), nl, nl,
        write('>> BIG MIKE: Hey punk. So you think you got what it takes to beat Vancouver\'s best lyricists'),
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
        write('>> MAD MATT: Ahhh, I feel you dude.'), nl, nl,
        describe(newScene),
        write('You end up not getting enough money for rent and get evicted.'),
        write(' Also, your girlfriend dumps you. Not signing up was a mistake.'), nl, nl,
        goto(play_again).

describe(firstBattle) :-
        describe(newScene),
        nickname(Nickname),
        assert(nickname(Nickname)),

        % Ask user for rhymes or fill in the blanks Store the inputs
        write('You feel yourself choke a little but you NEED to get that money...start thinking about your rhymes!'), nl, nl,
        write('** Enter a singular noun for a valuable object'), nl, nl,
        describe(input),
        read(SingularValuableNoun),
        assert(singularValuableNoun(SingularValuableNoun)), nl,
        write('I ain\'t got a shiny new grill but got a heart of a '), write(SingularValuableNoun), nl,
        write('** Enter a new line that rhymes with previous one!'), nl, nl,
        read(NewDope1),
        assert(newDope1(NewDope1)), nl,
        write('** Enter a positive adjective'), nl, nl,
        describe(input),
        read(PositiveAdjective),
        assert(positiveAdjective(PositiveAdjective)), nl,
        write('Fudge the struggle, I been '), write(PositiveAdjective), nl,
        write('** Enter a new line that rhymes with previous one!'), nl, nl,
        read(NewDope2),
        assert(newDope2(NewDope2)), nl, nl,

        write('>> BIG MIKE: Aahhhhh daaaang, here we go!!!'), nl, nl,
        
        
        % Too-pak's rhymes
        write('>> Too-pak: You\'s a pop tart sweetheart, you soft in the middle'), nl,
        write('I eat you for breakfast, the watch was exchanged for your necklace'), nl, 
        write('What\'s funny '), 
        write(Nickname), 
        write(' really think you grimy too'), nl,
        write('Now everybody liked you better in that shiny suit.'), nl, nl,

        write('Everybody is going crazy and chanting "Too-pak!", "Too-pak!"'), nl, nl,

        describe(newScene),

        write('You grab the mic and you begin...'), nl, nl,

        % Character raps here
        write('>> YOU: I ain\'t got a shiny new grill but got a heart full of '), write(SingularValuableNoun), nl,
        write(NewDope1), nl,
        write('Fudge the struggle, I been '), write(PositiveAdjective), nl,
        write(NewDope2), nl, nl,

        write('You killed it! The audience is chanting "'), write(Nickname), write('! '),
        write(Nickname), write('! '), write(Nickname), write('!"'), nl, nl,
        write('Do you jump onto the audience?'), nl, nl,
        describe(yesOrNo).

describe(jump) :- 
        nl,
        write('The crowd roars and carries you back to the entrance of the club.'), nl,
        write(' There, you meet a girl and you two hit it off.'), nl,
        write(' She invites you back to her place and you leave the club with her.'), nl, nl,

        write('...............Night one of the tournament is done...............'), nl, nl,
        goto(nightTwo).

describe(no_jump) :- 
        nl,
        write('The crowd thinks you\'re a tough guy and you earn their respect.'), nl,
        write('You leave the club with your friend Matt and you\'re really determined for the next night.'), nl, nl,

        write('...............Night one of the tournament is done...............'), nl, nl,
        goto(nightTwo).

describe(nightTwo) :-
        describe(newScene),
        nickname(Nickname),
        
        write('You\'re back at the club.'), nl, nl,
        write('>> BIG MIKE: Tonight is the night when the dopest cats rap to win the finals'), nl, nl,
        write('>> YOU: Hmm already the finals? I\'ve only had one rap battle.'), nl, nl,
        write('>> BIG MIKE: We got '), write(Nickname), write(' and Lay-Z on the stage.'), nl,
        write('Let\'s pass the mic on to these cats.'), nl, nl, 
        write('What\'s it gonna be folks?'), nl, nl,

        % Ask user for rhymes or fill in the blanks Store the inputs
        write('You\'re anxious but also confident from the events of last night...think of the rhymes!'), nl, nl,
        write('** Enter a verb'), nl, nl,
        describe(input),
        read(SingularVerb),
        assert(singularVerb(SingularVerb)), nl,
        write('Fudge your role models, I '), write(SingularVerb), write(' in these streets'), nl,
        write('** Enter a new line that rhymes with previous one!'), nl, nl,
        read(NewDope3),
        assert(newDope3(NewDope3)), nl,
        write('** Enter a negative adjective'), nl, nl,
        describe(input),
        read(NegativeAdjective),
        assert(negativeAdjective(NegativeAdjective)), nl,
        write('Why you so '), write(NegativeAdjective), write('?'), nl,
        write('** Enter a new line that rhymes with previous one!'), nl, nl,
        read(NewDope4),
        assert(newDope4(NewDope4)), nl, nl,

        write('>> BIG MIKE: Aahhhhh daaaang, here we go!!!'), nl, nl,
        
        
        % Lay-Z's rhymes
        write('>> Lay-Z: Hear me imploring, let me tell you this man is boring'), nl,
        write('He lives with his mom and eats refrigerated porridge'), nl, 
        write('Watch me rip out '), 
        write(Nickname), 
        write('\'s brain and call it auxillary storage'), nl, nl,

        write('Everybody is going crazy and chanting "Lay-Z!", "Lay-Z!"'), nl, nl,
        
        describe(newScene),

        write('You grab the mic and you begin...'), nl, nl,

        % Character raps here
        write('>> YOU: Fudge your role models, I '), write(SingularVerb), write(' in these streets'), nl,
        write(NewDope3), nl,
        write('Why you so '), write(NegativeAdjective), write('?'), nl,
        write(NewDope4), nl, nl,

        write('The crowd waits for a decision...'), write(Nickname), write(' may win!'), nl, nl,
        write('Do you think '), write(Nickname), write(' won?'), nl, nl,
        describe(yesOrNo).

describe(win) :- 
        nl,
        write('The crowd declares you the winner!'), nl,
        write('You take the money and for a split second, you are tempted to spend it in the club.'), nl,
        write('Do you spend it in the club?'), nl, nl,
        describe(yesOrNo).

describe(no_win) :-
        nl,
        write('This was all a dream.'), nl,
        write('You realize your palms are heavy, arms weak, knees are sweaty.'), nl, nl,
        goto(beginning).

describe(spend) :-
        nl,
        write('It\'s the morning after you spent all your money in the club.'), nl,
        write('You go home, sleep, and recover.'), nl,
        write('You dream about rapping to earn more'), nl,
        write('Do you want to rap more?'), nl, nl,
        describe(yesOrNo).

describe(no_spend) :- 
        nl,
        write('You go home and pay your bills.'), nl,
        write('You become passionate about rapping and release an album.'), nl,
        write('The album is a huge hit and you\'re happy forever.'), nl,
        write('...you think this is all a dream and pinch yourself...'), nl, nl,
        write('Is it a dream?'), nl, nl,
        describe(yesOrNo).


% Story branches you could take
branch(beginning, yes, tournamentSignup).
branch(beginning, no, noTournamentSignup).

branch(firstBattle, yes, jump).
branch(firstBattle, no, no_jump).

branch(nightTwo, yes, win).
branch(nightTwo, no, no_win).

branch(win, yes, spend).
branch(win, no, no_spend).

branch(spend, yes, beginning).
branch(spend, no, play_again).

branch(no_spend, _, beginning).

branch(play_again, yes, beginning).
