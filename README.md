# BoolCtrlNetwork
Running Boolean Control Network simulations, mainly for cellular signal transduction networks.\
Originally created for modeling macrophage polarization, find the article [here](https://pmc.ncbi.nlm.nih.gov/articles/PMC10045914/).

+ _ppiStep_ progresses the model by one step
+ _cycleDetBrent_ takes steps defined by ppiStep until an attractor is reached. It is an implementation of the cycle detection algorithm published by Richard P. Brent.
+ _getAttractor_ wraps cycleDetBrent, and provides an ID for the attractor reached, so that cycles get the same ID regardless of where they are entered.
+ _networkTrial_ runs the simulation with a given state for input nodes and randomized starting states for other nodes. It returns all attractors reached, the frequency with wich they were reached, and the size of the cycle.
