/* rfc__write_field_484 @ 0x8d0e40, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: get_g_8000fc, rfc__select_chain_and_write
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, rfc_field_write
 */
	.section .text.rfc__write_field_484,"ax",@progbits
	.global rfc__write_field_484
rfc__write_field_484:
	.global L_8d0e40
L_8d0e40:
	push_s blink
L_8d0e42:
	bl L_8c02c4
L_8d0e46:
	mov_s r14,r1
L_8d0e48:
	extb_s r13,r0
L_8d0e4a:
	mov_s r0,r13
L_8d0e4c:
	mov r1,0x1e4
L_8d0e50:
	bl.d L_8d113c
L_8d0e54:
	ld_s r2,[r14]
L_8d0e56:
	mov_s r0,r13
L_8d0e58:
	mov r1,0x1e8
L_8d0e5c:
	bl.d L_8d113c
L_8d0e60:
	ld_s r2,[r14,0x4]
L_8d0e62:
	mov_s r0,r13
L_8d0e64:
	mov r1,0x1ec
L_8d0e68:
	bl.d L_8d113c
L_8d0e6c:
	ld_s r2,[r14,0x8]
L_8d0e6e:
	b L_8c0334
L_8d0e72:
	nop_s
