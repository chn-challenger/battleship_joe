[![Stories in Ready](https://badge.waffle.io/chn-challenger/battleship_joe.png?label=ready&title=Ready)](https://waffle.io/chn-challenger/battleship_joe)
# Battleships - Mayhem
=======
The aim of this project is to build an extended version of the classic board game of battleships.  Allowing for, but not limited to:  
* Ships with width of more than 1 square.
* large game boards where both player's ships can be placed on either side.
* Firing more than one shot per turn.
* Both players pends moves, and then simultaneous firing (the game could but not very likely end in a draw).
* Weapons stored on ships, so that as ships sink, less shots are available per turn.
* One time available missile type weapons, limited number optional firing per turn, e.g. cruise missiles, nuclear missiles - which can cause detonation of stored nuclear missile on enemy ships.
* Graphical user interface - able to place ship with mouse drag, able to fire with mouse click.


# Team
=======
* Joe
* Harry
* Moe
* Lucy

# Progress
=======
* Basic ship and board classes made, ships have body-parts which is an array of body-part hashes that store information about state of that body-part of the ship, including location on grid, whether it has been hit, value of weapon stored on it, missiles stored on it.
* Placing ship onto a board simply means appending a ship object into a ships container instance variable (an array) in the board.  
* The board has containers to store misses.
* The state of the game at any one moment can be _queried_ by gathering information from ships which are on the board as well as shots which has missed.

# Immediate To do
=======
* Complete testing suite for the board and ship class
* Add utility gems: hound, Travis CI, Coveralls to the project.
* Add Human player and Computer player classes and associated tests.
