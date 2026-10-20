/* sxd_hal__wait_slot2_busy2 @ 0x936cc8, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_rx__start_rx_window, rx__handle_status_flags, tx_sta__flow_loop, tx_sta__wait_slot_and_tx, txss_resp__wait_fdbk
 * Зовёт сам: uc_sysassert, uc_wait_event_busy
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global sxd_hal__wait_slot2_busy2
sxd_hal__wait_slot2_busy2:
	.global L_936cc8
L_936cc8:
	st.a r13,[sp,-0x8]
L_936ccc:
	mov.f r13,r0
L_936cd0:
	st r14,[sp, 0x4]
L_936cd4:
	beq.d L_936d10
L_936cd8:
	mov r14,blink
	.global L_936cdc
L_936cdc:
	ld.as r3,[gp,-0x12]
L_936ce0:
	or r3,r3,0x27000c00
L_936ce8:
	mov r32,r3
L_936cec:
	st.ab r3,[r25,0x4]
L_936cf0:
	bclr r25,r25,0xa
L_936cf4:
	mov_s r2,0x2004000
L_936cfa:
	mov_s r32,r2
L_936cfc:
	st.ab r2,[r25,0x4]
L_936d00:
	bclr r25,r25,0xa
L_936d04:
	brhs r13,0x1,L_936d20
	.global L_936d08
L_936d08:
	b.d L_936d4c
L_936d0c:
	mov r0,0x0
	.global L_936d10
L_936d10:
	mov_s r0,blink
L_936d12:
	mov_s r1,0x157f
L_936d18:
	bl L_926618
L_936d1c:
	b L_936cdc
	.global L_936d20
L_936d20:
	mov_s r0,0x2000100
L_936d26:
	mov_s r32,r0
L_936d28:
	st.ab r0,[r25,0x4]
L_936d2c:
	bclr r25,r25,0xa
L_936d30:
	nop_s
L_936d32:
	nop_s
L_936d34:
	nop_s
L_936d36:
	mov_s r0,0x41
L_936d38:
	asl r0,r0,0x8
L_936d3c:
	bl.d L_9366e8
L_936d40:
	mov r1,0x0
L_936d44:
	mov_s r1,r42
L_936d46:
	bbit0 r1,0xe,L_936d58
L_936d4a:
	mov_s r0,0x1
	.global L_936d4c
L_936d4c:
	mov_s blink,r14
L_936d4e:
	ld_s r14,[sp,0x4]
L_936d50:
	j.d [blink]
L_936d54:
	ld.ab r13,[sp,0x8]
	.global L_936d58
L_936d58:
	sub r13,r13,0x1
L_936d5c:
	brhs r13,0x1,L_936d20
L_936d60:
	b_s L_936d08
L_936d62:
	nop_s
