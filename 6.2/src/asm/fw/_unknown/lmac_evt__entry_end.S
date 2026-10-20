/* lmac_evt__entry_end @ 0x8c7ef0, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__evt_walk
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_evt__entry_end
lmac_evt__entry_end:
	.global L_8c7ef0
L_8c7ef0:
	ldb_s r1,[r0]
L_8c7ef2:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_8c7ef4:
	ld_s r0,[r0,0x4]
L_8c7ef6:
	add1_s r1,r1,r1
L_8c7ef8:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8c7efa:
	j_s.d [blink]
L_8c7efc:
	add_s r0,r0,r1
L_8c7efe:
	nop_s
