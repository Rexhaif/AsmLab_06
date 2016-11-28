SECTION .bss
buf: RESB 1
outbuf: RESB 1
SECTION .text
  GLOBAL _start
  
  Convert:
    xor ecx,ecx
    xor ebx,ebx
    mov bl,10
    
    .divide:
      xor edx, edx
      div ebx
      add dl, '0'
      push dx
      inc ecx
      cmp eax, 0
    jnz .divide
    
    .reverse:
      pop ax
      stosb
    loop .reverse
  ret 

  ReadSymbol:
    mov ecx, buf
    mov edx, 1
    mov eax, 3
    mov ebx, 0
    int 80h
  ret
  
  
  _start:
    call ReadSymbol
    
    mov eax, [buf]
    mov edi, outbuf
    call Convert
    
    mov eax, 4
    mov ebx, 0
    mov ecx, buf
    mov edx, 1
    int 80h
    
    mov eax, 4
    mov ebx, 0
    mov ecx, outbuf
    mov edx, 2
    int 80h
    
    mov eax, 1
    mov ebx, 0
    int 80h
    
    
    
    
    