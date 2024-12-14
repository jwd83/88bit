; simple program to add 5 and 3 and store the result in RIO
; full line comment
; put some weird spacing on operands to make sure we parse it correctly
const five 5
const THREE 3

start:
    LOAD five       ; load 5 into R0
    COPY     R0 R1  ; R1 = R0 (5)
    LOAD tHrEe      ; load THREE into R0
    COPY    R0  R2  ; R2 = R0 (3)

add_more:
    ADD             ; R3 = R1 + R2
    COPY R3 RIO     ; RIO = R3
    COPY R3 R1      ; R1 = R3
    LOAD add_more   ; load add_more into R0
    BRA             ; branch always to address in R0