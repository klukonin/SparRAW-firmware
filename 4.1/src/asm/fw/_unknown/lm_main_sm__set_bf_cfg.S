/* lm_main_sm__set_bf_cfg @ 0x8e2eac, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, lm_main_sm__config_lmac_bf_sm, lm_main_sm__inject_conn_evt3
 */
	.section .text.lm_main_sm__set_bf_cfg,"ax",@progbits
	.global lm_main_sm__set_bf_cfg
lm_main_sm__set_bf_cfg:
L_8e2eac:
	st_s r1,[r0,0x30]
	.global sub_8e2eae
sub_8e2eae:
L_8e2eae:
	nop_s
L_8e2eb0:
	push_s blink
L_8e2eb2:
	push_s r13
L_8e2eb4:
	mov_s r13,r0
L_8e2eb6:
	bl.d L_8c625c
L_8e2eba:
	ld.as r1,[gp,-0x38]
L_8e2ebe:
	bl.d L_8e30c4
L_8e2ec2:
	ld_s r0,[r13,0x2c]
L_8e2ec4:
	b L_8c033c
