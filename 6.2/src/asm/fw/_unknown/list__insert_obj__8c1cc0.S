/* list__insert_obj__8c1cc0 @ 0x8c1cc0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_vring_cfg
 * Зовёт сам: list__insert_sorted_801b1c__8e1174
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global list__insert_obj__8c1cc0
list__insert_obj__8c1cc0:
	.global L_8c1cc0
L_8c1cc0:
	push_s blink
L_8c1cc2:
	ldb_s r1,[r0,0x8]
L_8c1cc4:
	bl.d L_8e1174
L_8c1cc8:
	mov_s r2,0x0
L_8c1cca:
	mov_s r0,0x0
L_8c1ccc:
	pop_s blink
L_8c1cce:
	j_s [blink]
