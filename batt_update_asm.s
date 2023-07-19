.text
.global  set_batt_from_ports
        
## ENTRY POINT FOR REQUIRED FUNCTION
set_batt_from_ports:

        movw BATT_VOLTAGE_PORT(%rip), %dx                                    # BATT_VOLTAGE_PORT to           dx
        cmpw $0,%dx                                                  # if (BATT_VOLTAGE_PORT < 0)    dx < 0 
        js .error                                                     # {return 1;} if negaitve 
        shrw $1, %dx                                                        # batt->mlvolts = BATT_VOLTAGE_PORT/2;
        movw %dx,0(%rdi)                                                   # set mlvolts to  mlvolts 
        cmpw $3000, %dx                                                   # if (batt->mlvolts < 3000){ 
        jg .Perc100
        movb $0, 2(%rdi)                                                  # set mode  to 2 
        jmp .ret0

        .Perc100:
        cmpw  $3800, %dx                                        # if(batt->mlvolts > 3800){
        jle .PercFormula                                           # else 
        movb $100, 2(%rdi)                                      # batt->percent = 100;
        jmp .mode1
        ret 

        .PercFormula: 
        subw $3000, %dx                                 # subtract 3000             
        shrw $3, %dx                                    # divide by 8 
        movw %dx, 2(%rdi)                               # set dx to percent 
        jmp .ret0                                       # check mode again 
        

        .mode2:                                         # return mode 2 and return 0 
		movb	$2, 3(%rdi)     
		movl	$0, %eax                                # return 0 
		ret

        .ret0: 
        testb	$16, BATT_STATUS_PORT(%rip)             # if (BATT_STATUS_PORT & 16 ){
		je	.mode2                                 # else 
		movb	$1, 3(%rdi)
        movl	$0,%eax
		ret
        
        .mode1:
        movb	$1, 3(%rdi)                             # return mode 1 and return 0 
        movl	$0,%eax
		ret 

        .error:
        movl	$1,%eax                                 # return 1 for error 
		ret

### Change to definint semi-global variables used with the next function 
### via the '.data' directive
.data
	
my_int:                         # declare location an single integer named 'my_int'
        .int 1234               # value 1234

other_int:                      # declare another int accessible via name 'other_int'
        .int 0b0101             # binary value as per C

my_array:                     
        .int 0b0111111          # 0 
        .int 0b0000110          # 1           
        .int 0b1011011          # 2 
        .int 0b1001111          # 3 
        .int 0b1100110          # 4 
        .int 0b1101101          # 5 
        .int 0b1111101          # 6 
        .int 0b0000111          # 7 
        .int 0b1111111          # 8 
        .int 0b1101111          # 9 
        .int 0b0000000          # blank 
        .int 0b1000000          # - 

## WARNING: Don't forget to switch back to .text as below
## Otherwise you may get weird permission errors when executing 
.text
.global  set_display_from_batt

## ENTRY POINT FOR REQUIRED FUNCTION
set_display_from_batt:  

	movl $0,(%rsi)                                           # *display = 0
   # movl (%rsi),%r11d                                 # *display set to %r11d 
	movq %rdi, %r11                                         # display to r11 
    sarq $16, %r11                                          # arithmetic shift to get perc 
    andq $0xFF, %r11                                        
    cmpq $90, %r11                                              # compare with 90 
    jge .all_bars
    cmpq $70, %r11 
    jge .all_4_bars
    cmpq $50, %r11 
    jge .all_3_bars
    cmpq $30, %r11 
    jge .all_2_bars
    cmpq $5, %r11 
    jge .all_1_bars
    cmpq $5, %r11 
    jl .zero_bars

    # batt.mode == 1//perc 
   # movq rdi, %r10
   # cmpq $1, %r10 
    
   # use different register 
   # do idiv for left and right 
   # and find middle 
   # move reg after idiv 
   # je .hop  # jne 



#.hop:
   # cmpq $100, %r10 
   # je .full_batt                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      


#.full_batt: 
  #  movl $0b111111111111111111111, %r8d
 #   shll $24, %r8d
  #  orl %r8d, (%rsi) 
    
# all from ln 62 - 74 

.all_bars:
    movl $0b11111, %r8d
    shll $24, %r8d
    orl %r8d, (%rsi) 
	movl	$0,%eax
    ret 
.all_4_bars:
    movl $0b1111, %r8d
    shll $24, %r8d
    orl %r8d, (%rsi) 
	movl	$0,%eax
    ret
.all_3_bars:
    movl $0b111, %r8d
    shll $24, %r8d
    orl %r8d, (%rsi) 
	movl	$0,%eax
    ret
.all_2_bars:
    movl $0b11, %r8d
    shll $24, %r8d
    orl %r8d, (%rsi) 
	movl	$0,%eax
    ret
.all_1_bars:
    movl $0b1, %r8d
    shll $24, %r8d
    orl %r8d, (%rsi) 
	movl	$0,%eax
    ret
.zero_bars:
    movl $0b00000, %r8d
    shll $24, %r8d
    orl %r8d, (%rsi) 
	movl	$0,%eax
    ret



.text
.global batt_update
        
## ENTRY POINT FOR REQUIRED FUNCTION
batt_update:

	## assembly instructions here
   ret