/* rx_chain__configure_b @ 0x8c3b94, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_indirect__write_entry, rx_queue__config_by_kind_b
 */
	.section .text.rx_chain__configure_b,"ax",@progbits
	.global rx_chain__configure_b
rx_chain__configure_b:
	.global L_8c3b94
L_8c3b94:
	push_s blink
L_8c3b96:
	bl.d L_8c02c4
L_8c3b9a:
	mov_s r2,r1
L_8c3b9c:
	mov_s r14,r0
L_8c3b9e:
	mov_s r13,0x84863c
L_8c3ba4:
	mov_s r0,r13
L_8c3ba6:
	bl.d L_8df5fc
L_8c3baa:
	ldb_s r1,[r14,0x1]
L_8c3bac:
	mov_s r0,r13
L_8c3bae:
	ldb_s r1,[r14]
L_8c3bb0:
	mov_s r2,0x1
L_8c3bb2:
	mov_s r3,0x3
L_8c3bb4:
	mov r4,0x0
L_8c3bb8:
	mov r5,r4
L_8c3bbc:
	mov r6,r4
L_8c3bc0:
	bl.d L_8c46a4
L_8c3bc4:
	mov_s r7,r3
L_8c3bc6:
	b L_8c0334
L_8c3bca:
	nop_s
