start:
	lui   $a0,0xFFFF        # let $28 = 0xFFFF0000 as the upper 16 bits of the port address
    ori   $gp,$a0,0xF000      # $28 port is the upper 20 bits of the system's I/O address
	lw $a0,0xc72($gp)
	andi $t1,$a0,0x0020
	bne $t1,$zero,start         #清零，重新读取
	andi $a1,$a0,0x0080			#立方检测标志位
	andi $a0,$a0,0x0040
	bne $a0,$zero,square		#标志位检测跳转（平方）
	bne $a1,$zero,square		#标志位检测跳转（立方）
	j finish
	
square:
	lui   $1,0xFFFF         # let $28 = 0xFFFF0000 as the upper 16 bits of the port address
    ori   $gp,$1,0xF000      # $28 port is the upper 20 bits of the system's I/O address
	lw $1,0xc70($gp)			#读取乘数
	andi $1,0xF				#清空无用位
	andi $v0,0x0				#清空v0，保存乘数
	add $v0,$1,$v0				#乘数初始化
	andi $t0,0x0
	add $t0,$1,$t0
	sll $1,$1,4				#逻辑左移
	andi $v1,0x0				#清空v1，保存每次做加法的乘数
	add $v1,$1,$v1				#做加法，v1=at+v1
	andi $a2,0x0
	ori $a2,0x000f				#初始化计数器
	andi $1,0x0
	
select:
	andi $a0,0x0
	andi $a0,$v0,0x1            #判断v0的最低位是不是0
	beq $a0,$zero,zero          #0则跳转
	add $1,$1,$v1               #不为0，做相加运算
	j judge

zero:
	add $1,$1,0
	
judge:
	srl $1,$1,0x1            	#逻辑右移
	srl $v0,$v0,0x1             
	srl $a2,$a2,0x1             
	beq $a2,$zero,cube         	#等于0则结束
	j select
	
cube:
	beq $a1,$zero,finish   #立方标志位为0，结束
	bne $a3,$zero,finish   #如果计算过立方,结束,否则重新计算
	andi $v0,0x0
	or $v0,$v0,$t0
	sll $1,$1,4  			#逻辑左移
	andi $v1,0x0
	or $v1,$v1,$1			#将$1清空,作为部分积
	andi $1,0x0				#将$a3置非0,作为标志位
	ori $a3,0xFFFF			#再次运行乘法
	ori $a2,0x000F
	j select
	
finish:
	sw $1,0xc60($gp)
	sw $1,0x0($0)
	
reset:
	lui   $a0,0xFFFF        # let $28 = 0xFFFF0000 as the upper 16 bits of the port address
    ori   $gp,$a0,0xF000    # $28 port is the upper 20 bits of the system's I/O address	
	lw $a0,0xc72($gp)
	andi $a0,$a0,0x0020
	beq $a0,$zero,reset  	
	andi $a3,$a3,0x0
	andi $1,$1,0x0
	sw $1,0xc60($gp)
	sw $0,0x0($0)
	j start

