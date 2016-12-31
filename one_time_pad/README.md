# OneTimePad

Advent of Code 2016 Day 14 solution in Elixir

```
$ iex -S mix
> OneTimePad.solve
```

Sample output:

```
...
In Decider, handle_events, received: 1383 888 and 1000
In Decider, handle_events, received: 1394 ccc and 1000
Found a key at 1394
In Gatherer, I have 5 keys now.
In Decider, handle_events, received: 1401 444 and 1000
In Decider, handle_events, received: 1415 666 and 1000
In Decider, handle_events, received: 1432 555 and 1000
In Decider, handle_events, received: 1436 222 and 1000
In Decider, handle_events, received: 1439 000 and 1000
In Decider, handle_events, received: 1442 999 and 1000
In Decider, handle_events, received: 1449 bbb and 1000
In Decider, handle_events, received: 1480 ddd and 1000
...
There aren't enough things in the queue right now.
There aren't enough things in the queue right now.
In Worker, asking for more items
******In Part2HashProducer, producing 2500 keys
There aren't enough things in the queue right now.
There aren't enough things in the queue right now.
There aren't enough things in the queue right now.
...
In Worker, the first event is: {"7877f45749c0f591291ccf782612375e", 2500}
In Worker, I have 3501 things in the queue now.
In Decider, handle_events, received: 1499 444 and 1000
In Decider, handle_events, received: 1503 333 and 1000
In Decider, handle_events, received: 1523 999 and 1000
...
```

It should eventually tell you that it "found 64th key at index 22045".
