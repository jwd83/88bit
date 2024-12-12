; # robot constants
const left 0
const move 1
const right 2
const idle 3
const action 4
const shoot 5

    ; for subtracting 1 later, taking this out of the loop for speed
    LOAD 1                              ; r0 = 1
    COPY R0 R2                          ; r2 = r1
START:                                  ; label start

    ; turn left
    LOAD left
    COPY R0 RIO                         ; reg0_to_out

STEP:                                   ; label step
    ; try to open door
    LOAD action
    COPY R0 RIO                         ; reg0_to_out

    ; look for wall by subtracting
    ; 1 from input and seeing if we
    ; get 0 then jumping to turn if
    ; we need to

    COPY RIO R1                         ; r1 = input
    SUB                                 ; r3 = r1-r2
    LOAD TURN
    JZ                                  ; jump to turn if r3 == 0


    ; move forward if no wall was found
    ; and start this process over
    LOAD move
    COPY R0 RIO                         ; reg0_to_out
    LOAD START
    JMP                                 ; jump to start


    ; turn right, jump back to start
TURN:                                   ; label turn
    LOAD right
    COPY R0 RIO                         ; reg0_to_out
    LOAD STEP
    JMP                                 ; jump to step


; -----------------------------------------------------------------------------
; ORIGINAL SOURCE CODE BELOW:
; -----------------------------------------------------------------------------
; # robot constants
; const left 0
; const move 1
; const right 2
; const idle 3
; const action 4
; const shoot 5

; label start

; # turn left
; left
; reg0_to_out

; label step
; # try to open door
; action
; reg0_to_out

; # look for wall by subtracting
; # 1 from input and seeing if we
; # get 0 then jumping to turn if
; # we need to

; in_to_reg1          # r1 = input
; 1                   # r0 = 1
; reg0_to_reg2        # r2 = r1
; sub                 # r3 = r1-r2
; turn jz

; # move forward if no wall was found
; # and start this process over
; move
; reg0_to_out
; start jmp

; # turn right, jump back to start
; label turn
; right
; reg0_to_out
; step jmp