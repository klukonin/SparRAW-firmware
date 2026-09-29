/* regulatory_domain_set_tx_gain_offset @ 0x8de11c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   regulatory_domain_set_tx_gain_offset set_low_gain = %d
 * Зовут его: hw_sysapi_config_short_vec
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1, regd__is_country_us
 */
	.section .text.regulatory_domain_set_tx_gain_offset,"ax",@progbits
	.global regulatory_domain_set_tx_gain_offset
regulatory_domain_set_tx_gain_offset:
	.global L_8de11c
L_8de11c:
	push_s blink
L_8de11e:
	bl L_8c02c4
L_8de122:
	bl.d L_8d7550
L_8de126:
	mov_s r14,r0
L_8de128:
	mov_s r13,r0
L_8de12a:
	mov_s r2,0x10086e4
L_8de130:
	mov_s r0,0x6
L_8de132:
	mov_s r1,0x2
L_8de134:
	bl.d L_8edfcc
L_8de138:
	mov_s r3,r13
L_8de13a:
	brne_s r13,0,L_8de152
L_8de13c:
	mov_s r1,0x857280
L_8de142:
	cmp_s r14,0x0
L_8de144:
	mov r0,-0x7
L_8de148:
	mov.eq r0,0xfffffffd
L_8de150:
	st_s r0,[r1,0x14]
	.global L_8de152
L_8de152:
	b L_8c0334
L_8de156:
	nop_s
