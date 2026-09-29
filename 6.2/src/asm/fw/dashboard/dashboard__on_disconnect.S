/* dashboard__on_disconnect @ 0x8eab88, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_sm__disconnect_ev_handle
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set32_s29_w3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dashboard__on_disconnect
dashboard__on_disconnect:
	.global L_8eab88
L_8eab88:
	push_s blink
L_8eab8a:
	push_s r13
L_8eab8c:
	brge.d r0,0x8,L_8eabba
L_8eab90:
	mov_s r13,r0
	.global L_8eab92
L_8eab92:
	mov_s r2,0x853900
L_8eab98:
	ld_s r1,[r2,0x18]
L_8eab9a:
	add r0,r2,0x18
L_8eab9e:
	lsr_s r1,r1,0x1d
L_8eaba0:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8eaba2:
	bmsk_s r1,r1,0x2
L_8eaba4:
	bl L_8ed4c0
L_8eaba8:
	mov_s r1,0x853920
L_8eabae:
	ldb_s r0,[r1]
L_8eabb0:
	bclr r0,r0,r13
L_8eabb4:
	b.d L_8c025c
L_8eabb8:
	stb_s r0,[r1]
	.global L_8eabba
L_8eabba:
	mov_s r0,blink
L_8eabbc:
	mov_s r1,0x111b
L_8eabc2:
	bl L_8c9b28
L_8eabc6:
	b_s L_8eab92
