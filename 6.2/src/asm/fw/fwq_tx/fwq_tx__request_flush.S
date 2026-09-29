/* fwq_tx__request_flush @ 0x8cac1c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_CTRL_API__flush_connection
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fwq_tx__request_flush
fwq_tx__request_flush:
	.global L_8cac1c
L_8cac1c:
	push_s blink
L_8cac1e:
	bl L_8c01e4
L_8cac22:
	mov_s r13,r0
L_8cac24:
	mov_s r14,0x0
L_8cac26:
	ld_s r0,[r0,0x14]
L_8cac28:
	bset r14,r14,r1
L_8cac2c:
	tst_s r0,r14
L_8cac2e:
	bne_s L_8cac5c
	.global L_8cac30
L_8cac30:
	ld_s r0,[r13,0x14]
L_8cac32:
	or_s r0,r0,r14
L_8cac34:
	st_s r0,[r13,0x14]
L_8cac36:
	ld_s r0,[r13,0x10]
L_8cac38:
	brne_s r0,0,L_8cac58
L_8cac3a:
	mov_s r0,0xadc4
L_8cac40:
	mov_s r1,r13
L_8cac42:
	mov_s r2,0x0
L_8cac44:
	mov_s r3,r2
L_8cac46:
	mov r4,0x493e0
L_8cac4e:
	mov_s r5,r2
L_8cac50:
	bl.d L_8e0c0c
L_8cac54:
	mov_s r6,r2
L_8cac56:
	st_s r0,[r13,0x10]
	.global L_8cac58
L_8cac58:
	b L_8c0254
	.global L_8cac5c
L_8cac5c:
	mov_s r0,blink
L_8cac5e:
	mov_s r1,0x1210
L_8cac64:
	bl L_8c9b28
L_8cac68:
	b_s L_8cac30
L_8cac6a:
	nop_s
