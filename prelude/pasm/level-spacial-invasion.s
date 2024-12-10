; # robot constants
; const left 0
; const move 1
; const right 2
; const idle 3
; const action 4
; const shoot 5
;
;
; # POSITION OURSELVES IN A PLACE
; # TO SHOOT
;
; # turn right
; right
; reg0_to_out
;
; # move 2 steps forward
; move
; reg0_to_out
; reg0_to_out
;
; # turn left
; left
; reg0_to_out
;
; # move up 5 steps
; move
; reg0_to_out
; reg0_to_out
; reg0_to_out
; reg0_to_out
; reg0_to_out
;
; # SEARCH FOR THINGS TO SHOOT AND FIRE!
;
; label search
;
; # look for enemy. if no enemy found
; # (reg3 == 0) then jump to hold (jz)
; in_to_reg3
; hold jz
;
; # we found an enemy so shoot!
; shoot
; reg0_to_out
; search jmp
;
;
; # idle then back to search
; label hold
; idle
; reg0_to_out
; search jmp