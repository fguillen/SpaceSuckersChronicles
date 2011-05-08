# Attack

When to fleets from different users coincide in the same planet an attack is started.

## Turns

The attack is composed for small ship attacks.

Each ship has an attack action, in this action it resolve this sequence:

* choose a random enemy ship
* shoot it
* see if the shoot achieves the enemy ship: random(100) - enemy_ship.mobility > 0
* update life points of enemy ship: enemy_ship.life - my_ship.attack

First the arriving fleet consume the attacks of all each ships, then the defending fleet use its ships attacks. 

The cycle is repeated until one fleet is out of ships.