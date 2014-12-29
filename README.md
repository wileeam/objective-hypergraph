objective-hypergraph :: An objective-C implementation of a data structure for hyper-graphs
==========================================================================================

Objective-C lacks some basic data structure representations that other languages do have, among them graphs (and its derivatives).

For this reason, this project aims at creating an abstract representation of not just graphs but their foremost abstraction, that is, hyper-graphs, based on the great implementation in Java achieved in this other project http://code.google.com/p/jbpt/

The goal is to provide a simple API for everyone to use in their Cocoa/CocoaTouch projects when creating/managing (labelled) undirected and directed trees, graphs... and hyper-graphs!
In the long term, heaps, stacks, lists,... can be included because in the end they are just derivatives of a hyper-graph with specific imposed contraints.

Update (16-Sep-2011): Project will be using from now on the latest Apple's feature for memory management (ARC) which is available for Mac OS X Lion (10.7), and Mac OS X Snow Leopard (10.6) if compiled in Mac OS X Lion, as well as iOS 5 and 4.
The general rule of thumb... use the latest XCode 4.2 available for developers (hopefully, in few weeks, it will be available for everyone and not just for those of us who are also subscribed developers).

Feel free to join and/or e-mail as well as request features and test the code :)
