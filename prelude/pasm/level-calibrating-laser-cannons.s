; # load input to register 1
; in_to_reg1
COPY RIO R1

; # copy reg1 to reg2
; reg1_to_reg2
COPY R1 R2

; # add (reg3 = reg1 + reg2) 2x
; add
ADD

; # copy result back to reg1
; reg3_to_reg1
COPY R3 R1

; # add (reg3 = reg1 + reg2) 3x
; add
ADD

; # copy result back to reg1
; reg3_to_reg1
COPY R3 R1

; # add (reg3 = reg1 + reg2) 4x
; add
ADD

; # copy result back to reg1
; reg3_to_reg1
COPY R3 R1

; # add (reg3 = reg1 + reg2) 5x
; add
ADD

; # copy result back to reg1
; reg3_to_reg1
COPY R3 R1

; # add (reg3 = reg1 + reg2) 6x
; add
ADD

; # send out reseult
; reg3_to_out
COPY R3 RIO