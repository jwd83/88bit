/*

a b c d | out
-------------
0 0 0 0 | 1
0 0 0 1 | 1
0 0 1 0 | 1
0 0 1 1 | 0
0 1 0 0 | 1
0 1 0 1 | 0
0 1 1 0 | 1
0 1 1 1 | 1
1 0 0 0 | 1
1 0 0 1 | 1
1 0 1 0 | 0
1 0 1 1 | 1
1 1 0 0 | 0
1 1 0 1 | 0
1 1 1 0 | 0
1 1 1 1 | 1


product of sums
a b c d | out
-------------
0 0 1 1 | 0
0 1 0 1 | 0
1 0 1 0 | 0
1 1 0 0 | 0
1 1 0 1 | 0
1 1 1 0 | 0

out = ( a |  b | ~c | ~d) &
      ( a | ~b |  c | ~d) &
      (~a |  b | ~c |  d) &
      (~a | ~b |  c |  d) &
      (~a | ~b |  c | ~d) &
      (~a | ~b | ~c |  d);

*/
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  );

    assign out =
        ( a |  b | ~c | ~d) &
        ( a | ~b |  c | ~d) &
        (~a |  b | ~c |  d) &
        (~a | ~b |  c |  d) &
        (~a | ~b |  c | ~d) &
        (~a | ~b | ~c |  d);

endmodule
