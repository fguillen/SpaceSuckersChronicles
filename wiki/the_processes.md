# The Processes

One of the most important things in this project are the **processes** I think is the most addictive ingredient: _waiting for a process to finish_ so you can move to the next _process_, or maybe see the results (is the process is an _attack_).

Nothing happens immediately, every thing needs time to complete:

* upgrading levels
* traveling to another planet
* build new construction 

## How to resolve the processes

I can think in two ways to resolve the process:

* One independent entity manage the process, track the time needed, and the event that happens when process finishes.
* Each _element_ in the game (buildings, ships) keep track of its own status, and the _process_ it is involved on.

For now I'm going to implement the second approach. Because I think there is not a _process_ that is not refereed to a _construction_. And because I think the _status_ and the _possibilities_ of every _construction_ is very related to the _process_ it is involved on.