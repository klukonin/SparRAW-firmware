/* ucode_cmd_0x21_handler @ 0x93502c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: mac__program_886f70_from_tbl
 */
	.section .text.ucode_cmd_0x21_handler,"ax",@progbits
	.global ucode_cmd_0x21_handler
ucode_cmd_0x21_handler:
	.global L_93502c
L_93502c:
	mov lp_count,0x4
L_935030:
	mov_s r2,0x0
L_935032:
	lp L_935046
L_935036:
	ldw.as r3,[r0,r2]
L_93503a:
	mov_s r1,0x8019e8
L_935040:
	add2_s r1,r1,r2
L_935042:
	st_s r3,[r1,0x4]
L_935044:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
	.global L_935046
L_935046:
	b.d L_931cac
L_93504a:
	mov_s r0,0x0
