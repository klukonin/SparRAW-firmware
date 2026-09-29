/* lm_sm__action_8e7f9c @ 0x8e7f9c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, lm__inject_conn_evt3, lm_main_sm__config_lmac_bf_sm
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm_sm__action_8e7f9c
lm_sm__action_8e7f9c:
	.global L_8e7f9c
L_8e7f9c:
	push_s blink
L_8e7f9e:
	push_s r13
L_8e7fa0:
	mov_s r13,r0
L_8e7fa2:
	bl.d L_8c6fbc
L_8e7fa6:
	ld.as r1,[gp,-0x3b]
L_8e7faa:
	bl.d L_8e81a4
L_8e7fae:
	ld_s r0,[r13,0x8]
L_8e7fb0:
	b L_8c025c
