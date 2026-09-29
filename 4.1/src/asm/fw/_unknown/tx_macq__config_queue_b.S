/* tx_macq__config_queue_b @ 0x8c3bcc, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__setup_macq, tx_macq__setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_indirect__write_entry, tx_queue__config_by_mode_b
 */
	.section .text.tx_macq__config_queue_b,"ax",@progbits
	.global tx_macq__config_queue_b
tx_macq__config_queue_b:
	.global L_8c3bcc
L_8c3bcc:
	push_s blink
L_8c3bce:
	bl.d L_8c02c4
L_8c3bd2:
	mov_s r8,r1
L_8c3bd4:
	sub_s sp,sp,0x30
L_8c3bd6:
	mov_s r13,r0
L_8c3bd8:
	mov_s r7,r2
L_8c3bda:
	mov_s r6,r3
L_8c3bdc:
	mov r5,r4
L_8c3be0:
	mov_s r14,sp
L_8c3be2:
	mov_s r0,r14
L_8c3be4:
	ldb_s r1,[r13,0x1]
L_8c3be6:
	mov_s r2,r8
L_8c3be8:
	mov_s r3,r7
L_8c3bea:
	bl.d L_8f22fc
L_8c3bee:
	mov r4,r6
L_8c3bf2:
	mov_s r0,r14
L_8c3bf4:
	ldb_s r1,[r13]
L_8c3bf6:
	mov_s r2,0x2
L_8c3bf8:
	mov_s r3,0x3
L_8c3bfa:
	mov r4,0x0
L_8c3bfe:
	mov r5,r4
L_8c3c02:
	mov r6,r4
L_8c3c06:
	bl.d L_8c46a4
L_8c3c0a:
	mov_s r7,r3
L_8c3c0c:
	b.d L_8c0334
L_8c3c10:
	add_s sp,sp,0x30
L_8c3c12:
	nop_s
