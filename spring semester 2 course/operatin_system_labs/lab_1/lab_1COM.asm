; for compile tasm.exe asm_file obj_name.obj
; tlink obj_name.obj /t
CSEG segment 'code'
assume cs:CSEG, ds:CSEG, es:CSEG, ss:CSEG ; CSEG - ??????????? ???????

org 100h ; ????? ???????? ?????. ????????

start:
    mov ah, 9
    mov dx, offset message
    int 21h
    int 20h
    message db 'Hello world, ASM!$'
    
    ends 
end start 
