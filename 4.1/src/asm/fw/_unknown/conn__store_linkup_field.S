/* conn__store_linkup_field @ 0x8e55cc, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_main_sm__linkup_ntf, linkup__check_pcp_assoc_ready
 * Зовёт сам: frag_8e55c0
 */
	.section .text.conn__store_linkup_field,"ax",@progbits
	.global conn__store_linkup_field
conn__store_linkup_field:
	.global L_8e55cc
L_8e55cc:
	b.d L_8e55c4
L_8e55d0:
	ld_s r0,[r0]
L_8e55d2:
	nop_s
