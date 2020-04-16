data segment para public 'data' ;сегмент данных
    message db 'Введите две шестнадцатеричные цифры,$'
data ends
stk segment stack
    db 256 dup ('?') ;сегмент стека
stk ends
code segment para public 'code' ;начало сегмента кода
    main proc ;начало процедуры main
        assume cs:code,ds:data,ss:stk
        mov ax,data ;адрес сегмента данных в регистр ax
        mov ds,ax ;ax в ds
        mov ah,9
        mov dx,offset message
        int 21h
        xor ax,ax ;очистить регистр ax
        mov ah,1h ;1h в регистр ah
        int 21h ;генерация прерывания с номером 21h
        mov dl,al ;содержимое регистра al в регистр dl
        sub dl,30h ;вычитание: (dl)=(dl)-30h
        cmp dl,9h ;сравнить (dl) с 9h
        jle M1 ;перейти на метку M1 если dl<9h или dl=9h
        sub dl,7h ;вычитание: (dl)=(dl)-7h
        
        M1: 
            mov cl,4h ;пересылка 4h в регистр cl
            shl dl,cl ;сдвиг содержимого dl на 4 разряда влево
            int 21h ;вызов прерывания с номером 21h
            sub al,30h ;вычитание: (dl)=(dl)-30h
            cmp al,9h ;сравнить (al) с 9h 28
            jle M2 ;перейти на метку M2 если al<9h или al=9h
            sub al,7h ;вычитание: (al)=(al)-7h
        
        M2: 
            add dl,al ;сложение: (dl)=(dl)+(al)
            mov ax,4c00h ;пересылка 4c00h в регистр ax
            int 21h ;вызов прерывания с номером 21h
    main endp ;конец процедуры main
code ends ;конец сегмента кода

end main ;конец программы с точкой входа
main