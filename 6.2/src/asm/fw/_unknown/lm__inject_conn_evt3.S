/* lm__inject_conn_evt3 @ 0x8e81a4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_main_sm__linkup_failed, lm_sm__action_8dad54, lm_sm__action_8e7f9c
 * Зовёт сам: conn__inject_evt3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm__inject_conn_evt3
lm__inject_conn_evt3:
	.global L_8e81a4
L_8e81a4:
	b.d L_8dc4cc
L_8e81a8:
	ld_s r0,[r0,0x4]
L_8e81aa:
	nop_s
