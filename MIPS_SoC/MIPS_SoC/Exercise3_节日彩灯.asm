prepare:
    #读入高8位拨码,模式选择
    lui   $a1,0xFFFF          
    ori   $gp,$a1,0xF000   
    lw   $a1,0xC72($gp)
    andi $a2,$a1,0x0080
    andi $a3,$a1,0x0040
    andi $t0,$a1,0x0020
    andi $1,$1,0x0
    bne $a2,$zero,mode1   #sw23标志位
    bne $a3,$zero,mode2   #sw22标志位
    bne $t0,$zero,mode3   #sw21标志位 
    j prepare
	
mode1:

LightsAllOff:
    andi $1,$1,0x0
    ori $1,$1,0x1
    andi $v0,$v0,0x0
    ori $v0,$v0,0x0800
    srl $v1,$v0,4
    sw $1, 0xC60($gp)  #亮一次,不检查$1和$v0
    sw $v1, 0xC62($gp) 
    jal DelayTime
	
TurnOn:
    sll $t2,$1,0x1
    or $1,$1,$t2
    srl $t2,$v0,0x1
    or $v0,$v0,$t2
    andi $t3,$t3,0x0
    ori $t3,$t3,0x0FFF
    and $t3,$t3,$1
    andi $t4,$t4,0x0
    ori $t4,$t4,0x000F
    and $t4,$v0,$t4
    sll $t4,$t4,0xC #向左移动12位
    or $1,$t4,$t3
    srl $v1,$v0,4
    sw $v1, 0xC62($gp) 
    sw $1, 0xC60($gp)     
    jal DelayTime
    andi $t3,$t3,0x0800
    and $t3,$1,$t3 #取$1的第11位
    bne $t3,$zero,LightAllOn #判断
    j TurnOn
	
LightAllOn:
    andi $1,$1,0x0
    ori $1,$1,0x07FF
    andi $v0,$v0,0x0
    ori $v0,$v0,0x0FFE
    andi $t3,$t3,0x0
    ori $t3,$t3,0x0FFF
    and $t3,$t3,$1
    andi $t4,$t4,0x0
    ori $t4,$t4,0x000F
    and $t4,$v0,$t4
    sll $t4,$t4,0xC #向左移动12位
    or $1,$t4,$t3
    srl $v1,$v0,4
    sw $v1, 0xC62($gp) 
    sw $1, 0xC60($gp) 
   jal DelayTime
   
TurnOff:
    srl $1,$1,0x1
    sll $v0,$v0,0x1
    andi $t3,$t3,0x0
    ori $t3,$t3,0x0FFF
    and $t3,$t3,$1
    andi $t4,$t4,0x0
    ori $t4,$t4,0x000F
    and $t4,$v0,$t4
    sll $t4,$t4,0xC #向左移动12位
    or $1,$t4,$t3
    srl $v1,$v0,4
    sw $v1, 0xC62($gp) 
    sw $1, 0xC60($gp) 
    jal DelayTime
    andi $t3,$t3,0x0001
    and $t3,$1,$t3 #取$1的第0位
    beq $t3,$zero,prepare
    j TurnOff
	
mode2:

LightsAllOff1:
    andi $1,$1,0x0
    ori $1,$1,0x0
    andi $v0,$v0,0x0
    ori $v0,$v0,0x0800
    srl $v1,$v0,4
    sw $1, 0xC60($gp)  #亮一次,不检查$1和$v0
    sw $v1, 0xC62($gp) 
    jal DelayTime
	
TurnOn1:
    srl $t2,$1,0x1
    or $1,$1,$t2
    srl $t2,$v0,0x1
    or $v0,$v0,$t2
    andi $t3,$t3,0x0
    ori $t3,$t3,0x0FFF
    and $t3,$t3,$1
    andi $t4,$t4,0x0
    ori $t4,$t4,0x000F
    and $t4,$v0,$t4
    sll $t4,$t4,0xC #向左移动12位
    or $1,$t4,$t3
    srl $v1,$v0,4
    sw $v1, 0xC62($gp) 
    sw $1, 0xC60($gp) 
    jal DelayTime
    andi $t3,$t3,0x0001
    and $t3,$1,$t3 #取$1的第0位
    bne $t3,$zero,LightAllOn1 
    j TurnOn1

LightAllOn1:

TurnOff1:
    srl $1,$1,0x1
    srl $v0,$v0,0x1
    andi $t3,$t3,0x0
    ori $t3,$t3,0x0FFF
    and $t3,$t3,$1
    andi $t4,$t4,0x0
    ori $t4,$t4,0x000F
    and $t4,$v0,$t4
    sll $t4,$t4,0xC #向左移动12位
    or $1,$t4,$t3
    srl $v1,$v0,4
    sw $v1, 0xC62($gp) 
    sw $1, 0xC60($gp) 
    jal DelayTime
    andi $t3,$t3,0x0001
    and $t3,$1,$t3 #取$1的第0位
    beq $t3,$zero,prepare
    j TurnOff1

mode3:
    lui   $a1,0xFFFF          
    ori   $gp,$a1,0xF000   #$gp=0xFFFFF___,作为偏移
    lw   $a1,0xC70($gp)
    andi $1,$a1,0x000F
    andi $v0,$v0,0x0
    
    andi $t1,$t1,0x0  #译码
    ori $t1,$t1,0x0
    beq $1,$t1,num0

    andi $t1,$t1,0x0
    ori $t1,$t1,0x1
    beq $1,$t1,num1

    andi $t1,$t1,0x0
    ori $t1,$t1,0x2
    beq $1,$t1,num2

    andi $t1,$t1,0x0
    ori $t1,$t1,0x3
    beq $1,$t1,num3

    andi $t1,$t1,0x0
    ori $t1,$t1,0x4
    beq $1,$t1,num4

    andi $t1,$t1,0x0
    ori $t1,$t1,0x5
    beq $1,$t1,num5

    andi $t1,$t1,0x0
    ori $t1,$t1,0x6
    beq $1,$t1,num6

    andi $t1,$t1,0x0
    ori $t1,$t1,0x7
    beq $1,$t1,num7

    andi $t1,$t1,0x0
    ori $t1,$t1,0x8
    beq $1,$t1,num8

    andi $t1,$t1,0x0
    ori $t1,$t1,0x9
    beq $1,$t1,num9

    andi $t1,$t1,0x0
    ori $t1,$t1,0xA
    beq $1,$t1,num10

    andi $t1,$t1,0x0
    ori $t1,$t1,0xB
    beq $1,$t1,num11

    andi $t1,$t1,0x0
    ori $t1,$t1,0xC
    beq $1,$t1,num12

    andi $t1,$t1,0x0
    ori $t1,$t1,0xD
    beq $1,$t1,num13

    andi $t1,$t1,0x0
    ori $t1,$t1,0xE
    beq $1,$t1,num14

    andi $t1,$t1,0x0
    ori $t1,$t1,0xF
    beq $1,$t1,num15

num0:
    andi $1,$1,0x0
    j assign
num1:
    andi $1,$1,0x0
    ori $1,$1,0x1
    j assign
num2:
    andi $1,$1,0x0
    ori $1,$1,0x3
    j assign
num3:
    andi $1,$1,0x0
    ori $1,$1,0x7
    j assign
num4:
    andi $1,$1,0x0
    ori $1,$1,0xF
    j assign
num5:
    andi $1,$1,0x0
    ori $1,$1,0x1F
    j assign
num6:
    andi $1,$1,0x0
    ori $1,$1,0x3F
    j assign
num7:
    andi $1,$1,0x0
    ori $1,$1,0x7F
    j assign
num8:
    andi $1,$1,0x0
    ori $1,$1,0xFF
    j assign
num9:
    andi $1,$1,0x0
    ori $1,$1,0x1FF
    j assign
num10:
    andi $1,$1,0x0
    ori $1,$1,0x3FF
    j assign
num11:
    andi $1,$1,0x0
    ori $1,$1,0x7FF
    j assign
num12:
    andi $1,$1,0x0
    ori $1,$1,0xFFF
    j assign
num13:
    andi $1,$1,0x0
    ori $1,$1,0x1FFF
    ori $v0,$v0,0x1
    sll $v0,$v0,0x1
    j assign
num14:
    andi $1,$1,0x0
    ori $1,$1,0x3FFF
    ori $v0,$v0,0x3
    sll $v0,$v0,0x1
    j assign
num15:
    andi $1,$1,0x0
    ori $1,$1,0x7FFF
    ori $v0,$v0,0x7
    sll $v0,$v0,0x1
assign:
    sll $1,$1,1
    andi $a0,$a0,0x0
    or $a0,$a0,$1  #备份$1
ShowLed:
    srl $1,$1,0x1
    srl $v0,$v0,0x1
    andi $t3,$t3,0x0  #把$v0低4位给$1高4位
    ori $t3,$t3,0x0FFF
    and $t3,$t3,$1
    andi $t4,$t4,0x0
    ori $t4,$t4,0x000F
    and $t4,$v0,$t4
    sll $t4,$t4,0xC #向左移动12位
    or $1,$t4,$t3
    andi $t3,$t3,0x0  #把$1低4位给$v0高4位
    ori $t3,$t3,0x000F
    and $t3,$t3,$1
    sll $t3,$t3,0xC
    andi $t4,$t4,0x0
    ori $t4,$t4,0x0FFF
    and $t4,$v0,$t4
    or $v0,$t3,$t4
    srl $v1,$v0,4
    sw $v1, 0xC62($gp) 
    sw $1, 0xC60($gp) 
    jal DelayTime
    andi $t1,$t1,0x0
    ori $t1,$t1,0xffff
    and $t1,$1,$t1
    bne $t1,$a0,ShowLed  
    j prepare
	
DelayTime:
    andi $t5,$t5,0x0 #使用128hz主频延时
    ori  $t5,$t5,0x0040
    andi $t6,$t6,0x0
	
Delay:
    addi	$t6,$t6,0x1	
    bne $t5,$t6,Delay
    jr $ra
