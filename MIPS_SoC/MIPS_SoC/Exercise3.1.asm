lui   $1,0xFFFF            # let $28 = 0xFFFF0000 as the upper 16 bits of the port address
        ori   $gp,$at,0xF000      # $28 port is the upper 20 bits of the system's I/O address
switled:                                # Test led and switch
	lw   $1,0xC70($28)          # read switch
	sw   $1,0xC60($28)          # write led
	lw   $1,0xC72($28)
    	sw   $1,0xC62($28)	
	j switled
