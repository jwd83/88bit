const Three 3
COPY RIO R1 ; R1 = RIO (input)
LOAD Three      ; R0 = 3
COPY R0 R2  ; R2 = R0 (3)
AND         ; R3 = R1 & R2
COPY R3 RIO ; RIO = R3 (output)