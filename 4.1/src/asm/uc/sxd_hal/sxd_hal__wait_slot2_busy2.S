/* sxd_hal__wait_slot2_busy2 @ 0x931dcc, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sxd_hal.c
 * Зовут его: bi_manager_rx_step, tx_flow_size_step, tx_initiator_rx_step, tx_initiator_substep, txss__init_sweep_b
 * Зовёт сам: uc_sysassert, uc_wait_event_busy
 */
	.section .text.sxd_hal__wait_slot2_busy2,"ax",@progbits
	.global sxd_hal__wait_slot2_busy2
sxd_hal__wait_slot2_busy2:
	.global L_931dcc
L_931dcc:
	st.a r13,[sp,-0x8]
L_931dd0:
	mov.f r13,r0
L_931dd4:
	st r14,[sp, 0x4]
L_931dd8:
	beq.d L_931e14
L_931ddc:
	mov r14,blink
	.global L_931de0
L_931de0:
	ld.as r3,[gp,-0x12]
L_931de4:
	or r3,r3,0x27000c00
L_931dec:
	mov r32,r3
L_931df0:
	st.ab r3,[r25,0x4]
L_931df4:
	bclr r25,r25,0xa
L_931df8:
	mov_s r2,0x2004000
L_931dfe:
	mov_s r32,r2
L_931e00:
	st.ab r2,[r25,0x4]
L_931e04:
	bclr r25,r25,0xa
L_931e08:
	brhs r13,0x1,L_931e30
	.global L_931e0c
L_931e0c:
	b.d L_931e5c
L_931e10:
	mov r0,0x0
	.global L_931e14
L_931e14:
	mov_s r0,blink
L_931e16:
	mov_s r2,0x1000d80
L_931e1c:
	mov r1,0x157f
L_931e24:
	bl.d L_925548
L_931e28:
	mov r3,0x151
L_931e2c:
	b L_931de0
	.global L_931e30
L_931e30:
	mov_s r0,0x2000100
L_931e36:
	mov_s r32,r0
L_931e38:
	st.ab r0,[r25,0x4]
L_931e3c:
	bclr r25,r25,0xa
L_931e40:
	nop_s
L_931e42:
	nop_s
L_931e44:
	nop_s
L_931e46:
	mov_s r0,0x41
L_931e48:
	asl r0,r0,0x8
L_931e4c:
	bl.d L_931808
L_931e50:
	mov r1,0x0
L_931e54:
	mov_s r1,r42
L_931e56:
	bbit0 r1,0xe,L_931e68
L_931e5a:
	mov_s r0,0x1
	.global L_931e5c
L_931e5c:
	mov_s blink,r14
L_931e5e:
	ld_s r14,[sp,0x4]
L_931e60:
	j.d [blink]
L_931e64:
	ld.ab r13,[sp,0x8]
	.global L_931e68
L_931e68:
	sub r13,r13,0x1
L_931e6c:
	brhs r13,0x1,L_931e30
L_931e70:
	b_s L_931e0c
L_931e72:
	nop_s
