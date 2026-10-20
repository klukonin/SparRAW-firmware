/* mac__build_qset_mask @ 0x92bacc, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac__program_886e0c_20b
 * Глобалы (через gp): 0x800558
 */
	.section .text.mac__build_qset_mask,"ax",@progbits
	.global mac__build_qset_mask
mac__build_qset_mask:
	.global L_92bacc
L_92bacc:
	push_s r13
L_92bace:
	ld_s r2,[r0,0x2c]
L_92bad0:
	bmsk r0,r2,0x0
L_92bad4:
	btst_s r2,0x3
L_92bad6:
	mov.eq r1,r0
L_92bada:
	mov.ne r1,0x1
L_92bade:
	lsr_s r2,r2,0x2
L_92bae0:
	bmsk_s r2,r2,0x0
L_92bae2:
	asl_s r13,r1
L_92bae4:
	or_s r13,r13,r2
L_92bae6:
	asl_s r3,r1,0x2
L_92bae8:
	or_s r3,r3,r13
L_92baea:
	/* asl_s r2,r2,0x4 */
	.byte 0x04,0xba
L_92baec:
	or_s r3,r3,r2
L_92baee:
	asl_s r2,r1,0x5
L_92baf0:
	or_s r2,r2,r3
L_92baf2:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_92baf4:
	or_s r2,r2,r1
L_92baf6:
	asl r1,r0,0x9
L_92bafa:
	or_s r1,r1,r2
L_92bafc:
	asl r2,r0,0xa
L_92bb00:
	or_s r2,r2,r1
L_92bb02:
	asl r1,r0,0xd
L_92bb06:
	or_s r1,r1,r2
L_92bb08:
	asl r2,r0,0xe
L_92bb0c:
	or_s r2,r2,r1
L_92bb0e:
	asl r1,r0,0x11
L_92bb12:
	or_s r1,r1,r2
L_92bb14:
	asl r2,r0,0x12
L_92bb18:
	or_s r2,r2,r1
L_92bb1a:
	asl r1,r0,0x15
L_92bb1e:
	or_s r1,r1,r2
L_92bb20:
	asl_s r0,r0,0x16
L_92bb22:
	or_s r0,r0,r1
L_92bb24:
	st.as r0,[gp,0xc]
L_92bb28:
	j_s.d [blink]
L_92bb2a:
	pop_s r13
