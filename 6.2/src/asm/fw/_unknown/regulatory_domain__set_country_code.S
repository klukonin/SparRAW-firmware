/* regulatory_domain__set_country_code @ 0x8e63e0, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   regulatory_domain::set_country_code. country code: 0x%x
 * Зовут его: discovery_handle_probe_resp, mid__apply_app_ies
 * Зовёт сам: fw_log_emit1
 * Глобалы (через gp): 0x800214
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global regulatory_domain__set_country_code
regulatory_domain__set_country_code:
	.global L_8e63e0
L_8e63e0:
	mov_s r2,r0
L_8e63e2:
	stw.as r0,[gp,0x48]
L_8e63e6:
	mov_s r1,0x1010dd0
L_8e63ec:
	b.d L_8dcc10
L_8e63f0:
	mov_s r0,0x20
L_8e63f2:
	nop_s
