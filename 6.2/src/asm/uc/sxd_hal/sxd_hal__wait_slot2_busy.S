/* sxd_hal__wait_slot2_busy @ 0x936d64, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_funcs__rx_flow
 * Зовёт сам: uc_sysassert, uc_wait_event_busy
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sxd_hal__wait_slot2_busy
sxd_hal__wait_slot2_busy:
	.global L_936d64
L_936d64:
	st.a r13,[sp,-0x8]
L_936d68:
	mov.f r13,r0
L_936d6c:
	st r14,[sp, 0x4]
L_936d70:
	bne.d L_936d80
L_936d74:
	mov_s r14,blink
L_936d76:
	mov_s r0,blink
L_936d78:
	bl.d L_926618
L_936d7c:
	mov r1,0x52
	.global L_936d80
L_936d80:
	mov_s r2,0x41
L_936d82:
	asl_s r2,r2,0x13
L_936d84:
	mov r32,r2
L_936d88:
	st.ab r2,[r25,0x4]
L_936d8c:
	bclr r25,r25,0xa
L_936d90:
	brhs r13,0x1,L_936d9c
	.global L_936d94
L_936d94:
	b.d L_936dc8
L_936d98:
	mov r0,0x0
	.global L_936d9c
L_936d9c:
	mov_s r0,0x2000100
L_936da2:
	mov_s r32,r0
L_936da4:
	st.ab r0,[r25,0x4]
L_936da8:
	bclr r25,r25,0xa
L_936dac:
	nop_s
L_936dae:
	nop_s
L_936db0:
	nop_s
L_936db2:
	mov_s r0,0x80100
L_936db8:
	bl.d L_9366e8
L_936dbc:
	mov r1,0x0
L_936dc0:
	mov_s r1,r42
L_936dc2:
	bbit0 r1,0x13,L_936dd4
L_936dc6:
	mov_s r0,0x1
	.global L_936dc8
L_936dc8:
	mov_s blink,r14
L_936dca:
	ld_s r14,[sp,0x4]
L_936dcc:
	j.d [blink]
L_936dd0:
	ld.ab r13,[sp,0x8]
	.global L_936dd4
L_936dd4:
	sub r13,r13,0x1
L_936dd8:
	brhs r13,0x1,L_936d9c
L_936ddc:
	b_s L_936d94
L_936dde:
	nop_s
