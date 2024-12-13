% Dynamic predicates for game state
:- dynamic here/1, question_answered/1.

% Starting location
here(start).

% Introduction
start :-
    write('Welcome to Raqeebs Brainrot Adventure!'), nl,
    write('Your brain cells are deteriorating as you navigate this bizarre maze of trivia.'), nl,
    write('To move north, you must answer a multiple-choice question at each step.'), nl,
    write('Only the true kings and queens of brainrot can reach the final destination.'), nl,
    write('Type "help." if you get stuck.'), nl,
    describe(start).

% Room descriptions
describe(start) :-
    write('You are at the starting point of Brainrot Maze.'), nl,
    write('To the north lies your first question.'), nl.

describe(room1) :-
    write('You have arrived at the first question chamber.'), nl,
    write('"Who is the king of the Costco Chicken Bake?"'), nl,
    write('Options:'), nl,
    write('1. CaseOh'), nl,
    write('2. Big Justice'), nl,
    write('3. Sketch'), nl.

describe(room2) :-
    write('You step into the next chamber.'), nl,
    write('"Fill in the blank: He pulls all the girls in with his ______."'), nl,
    write('Options:'), nl,
    write('1. Swagger'), nl,
    write('2. Game'), nl,
    write('3. Rizz'), nl.

describe(room3) :-
    write('Another chamber appears before you.'), nl,
    write('"What is universally known as the worst US state (at least on TikTok)?"'), nl,
    write('Options:'), nl,
    write('1. Missouri'), nl,
    write('2. Idaho'), nl,
    write('3. Ohio'), nl.

describe(final) :-
    write('You made it! You are now the ultimate brainrot champion.'), nl,
    write('Congratulations, your brain is now both empty and full of useless trivia.'), nl,
    write('Well done, king/queen!'), nl.

% Questions and answers
question(room1, 2).  % Correct answer is "Big Justice"
question(room2, 3).  % Correct answer is "Rizz"
question(room3, 3).  % Correct answer is "Ohio"

% Movement
move(n) :-
    here(start),
    describe(room1),
    retract(here(start)),
    assert(here(room1)), !.

move(n) :-
    here(room1),
    question_answered(room1),
    describe(room2),
    retract(here(room1)),
    assert(here(room2)), !.

move(n) :-
    here(room2),
    question_answered(room2),
    describe(room3),
    retract(here(room2)),
    assert(here(room3)), !.

move(n) :-
    here(room3),
    question_answered(room3),
    describe(final),
    retract(here(room3)),
    assert(here(final)), !.

move(n) :-
    write('Answer the question first before moving north!'), nl.

move(_) :-
    write('You cannot go that way.'), nl.

% Shortcuts for movement
n :- move(n).

% Answering questions
answer(Number) :-
    here(Room),
    question(Room, Number),
    \+ question_answered(Room),
    assert(question_answered(Room)),
    write('Correct! You may proceed north.'), nl, !.

answer(_) :-
    write('Wrong answer! Try again, or accept your fate as a trivia failure.'), nl.

% Help command
help :-
    write('Commands:'), nl,
    write('- start: Restart the game.'), nl,
    write('- n: Move north if allowed.'), nl,
    write('- answer(Number): Answer the current room\'s question (e.g., answer(2).)'), nl.