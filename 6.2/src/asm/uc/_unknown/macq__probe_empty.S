/* macq__probe_empty @ 0x92dab8, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_q__tx_ppdu, tx_bcast_flow, ucode_cmd_0x08_handler, ucode_cmd_0x0b_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global macq__probe_empty
macq__probe_empty:
	.global L_92dab8
L_92dab8:
	st.a r13,[sp,-0x8]
L_92dabc:
	st_s r14,[sp,0x4]
L_92dabe:
	mov_s r14,blink
L_92dac0:
	asl_s r0,r0,0x10
L_92dac2:
	bset r13,r0,0x0
L_92dac6:
	mov_s r2,0x1b001111
L_92dacc:
	mov r32,r2
L_92dad0:
	st.ab r2,[r25,0x4]
L_92dad4:
	bclr r25,r25,0xa
L_92dad8:
	or r13,r13,0x16000000
L_92dae0:
	mov r32,r13
L_92dae4:
	st.ab r13,[r25,0x4]
L_92dae8:
	bclr r25,r25,0xa
L_92daec:
	mov_s r1,0x17
L_92daee:
	asl_s r1,r1,0x18
L_92daf0:
	mov r32,r1
L_92daf4:
	st.ab r1,[r25,0x4]
L_92daf8:
	bclr r25,r25,0xa
L_92dafc:
	nop_s
L_92dafe:
	nop_s
L_92db00:
	mov 0x0,0x0
	.global L_92db04
L_92db04:
	mov_s r2,r45
L_92db06:
	bbit0 r2,0x1f,L_92db04
L_92db0a:
	lsr r0,r45
L_92db0e:
	bxor r0,r0,0x0
L_92db12:
	bmsk_s r0,r0,0x0
L_92db14:
	mov_s blink,r14
L_92db16:
	ld_s r14,[sp,0x4]
L_92db18:
	j.d [blink]
L_92db1c:
	ld.ab r13,[sp,0x8]
