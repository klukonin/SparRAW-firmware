/* rx__check_g8005f8_bit24 @ 0x932de8, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow
 * Зовёт сам: uc_sysassert
 * Глобалы (через gp): 0x8005f8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rx__check_g8005f8_bit24
rx__check_g8005f8_bit24:
	.global L_932de8
L_932de8:
	st.a r13,[sp,-0x8]
L_932dec:
	st_s r14,[sp,0x4]
L_932dee:
	ld_s r0,[gp,0xd0]
L_932df0:
	mov r14,blink
L_932df4:
	bbit0.d r0,0x18,L_932e08
L_932df8:
	mov_s r13,0x3
L_932dfa:
	mov_s r0,0x0
L_932dfc:
	mov_s blink,r14
L_932dfe:
	ld_s r14,[sp,0x4]
L_932e00:
	j.d [blink]
L_932e04:
	ld.ab r13,[sp,0x8]
	.global L_932e08
L_932e08:
	bbit0 r0,0x19,L_932e18
L_932e0c:
	mov_s r0,0x1
L_932e0e:
	mov_s blink,r14
L_932e10:
	ld_s r14,[sp,0x4]
L_932e12:
	j_s.d [blink]
L_932e14:
	ld.ab r13,[sp,0x8]
	.global L_932e18
L_932e18:
	bbit0 r0,0xc,L_932e28
L_932e1c:
	mov_s r0,0x2
L_932e1e:
	mov_s blink,r14
L_932e20:
	ld_s r14,[sp,0x4]
L_932e22:
	j_s.d [blink]
L_932e24:
	ld.ab r13,[sp,0x8]
	.global L_932e28
L_932e28:
	mov r0,blink
L_932e2c:
	bl.d L_926618
L_932e30:
	mov r1,0x3e
L_932e34:
	mov_s r0,r13
L_932e36:
	mov_s blink,r14
L_932e38:
	ld_s r14,[sp,0x4]
L_932e3a:
	j_s.d [blink]
L_932e3c:
	ld.ab r13,[sp,0x8]
