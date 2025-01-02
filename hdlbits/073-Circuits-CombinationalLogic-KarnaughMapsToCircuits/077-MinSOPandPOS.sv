/*

A single-output digital system with four inputs (a,b,c,d) generates a logic-1
when 2, 7, or 15 appears on the inputs, and a logic-0 when 0, 1, 4, 5, 6, 9, 10,
13, or 14 appears. The input conditions for the numbers 3, 8, 11, and 12 never
occur in this system. For example, 7 corresponds to a,b,c,d being set to
0,1,1,1, respectively.

Determine the output out_sop in minimum SOP form, and the output out_pos in
minimum POS form.

a b c d | dec.| out
-------------------
0 0 0 0 | 0   | 0
0 0 0 1 | 1   | 0
0 0 1 0 | 2   | 1
0 0 1 1 | 3   | ?
0 1 0 0 | 4   | 0
0 1 0 1 | 5   | 0
0 1 1 0 | 6   | 0
0 1 1 1 | 7   | 1
1 0 0 0 | 8   | ?
1 0 0 1 | 9   | 0
1 0 1 0 | 10  | 0
1 0 1 1 | 11  | ?
1 1 0 0 | 12  | ?
1 1 0 1 | 13  | 0
1 1 1 0 | 14  | 0
1 1 1 1 | 15  | 1
-------------------
1s = 3, 0s = 9, ?s = 3

sum of products =
-------------------
0 0 1 0 | 2   | 1
0 1 1 1 | 7   | 1
1 1 1 1 | 15  | 1
-------------------


out_sop =
    ( ~a & ~b &  c & ~d) |
    ( ~a &  b &  c &  d) |
    (  a &  b &  c &  d);

product of sums =
-------------------
0 0 0 0 | 0   | 0
0 0 0 1 | 1   | 0
0 1 0 0 | 4   | 0
0 1 0 1 | 5   | 0
0 1 1 0 | 6   | 0
1 0 0 1 | 9   | 0
1 0 1 0 | 10  | 0
1 1 0 1 | 13  | 0
1 1 1 0 | 14  | 0
-------------------
yikes

out_pos =
    (  a |  b |  c |  d) &
    (  a |  b |  c | ~d) &
    (  a | ~b |  c |  d) &
    (  a | ~b |  c | ~d) &
    (  a | ~b | ~c |  d) &
    ( ~a |  b |  c | ~d) &
    ( ~a |  b | ~c |  d) &
    ( ~a | ~b |  c | ~d) &
    ( ~a | ~b | ~c |  d);



*/


module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    assign out_sop =
        ( ~a & ~b &  c & ~d) |
        ( ~a &  b &  c &  d) |
        (  a &  b &  c &  d);

    assign out_pos =
        (  a |  b |  c |  d) &
        (  a |  b |  c | ~d) &
        (  a | ~b |  c |  d) &
        (  a | ~b |  c | ~d) &
        (  a | ~b | ~c |  d) &
        ( ~a |  b |  c | ~d) &
        ( ~a |  b | ~c |  d) &
        ( ~a | ~b |  c | ~d) &
        ( ~a | ~b | ~c |  d);


endmodule
