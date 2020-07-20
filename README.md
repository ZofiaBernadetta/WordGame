## Around 8,5 h was invested

0,5 h design + game rules
1,5 h implementing basic view + trying with falling views
5 h implementing MVVM + Combine
1h fixing issue with Combine
0,5 h tests

##  Decisions made to solve certain aspects of the game 

On the top bar user can see word in one language, their number of points and number of lives. From the top there are falling words in a second language. Player’s task is to tap on a translation of the word from the top bar. If player taps on the proper word they gets 1 point. If they taps on the wrong one they loses one point and one live. If translation reaches bottom of the screen it’t counted as a wrong answer (-1 point, -1 live). At the beginning player has 3 lives and 0 points. If player loses all of the lives this is game over.

##  Decisions made because of restricted time

I decided to not spend more time on getting the animations perfect.
The feedback to the user about their gameplay (+1, -1 etc) is left kinda raw. I would have liked to improve the UI.

The game end screen was just a label instead of a new/nicer view controller just for displaying the game end status.
 Finally the app architecture could have been improved if I had more time to work on it.


## What would be the first thing to improve or add if there had been more time 

I would consider providing a better visual feedback to the user. (The scores, and game over)

And if I still had some time left over, I would consider improving the architecture a little bit.

