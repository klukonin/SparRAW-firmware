/* regulatory_domain__set_country_code @ 0x8e1670, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   regulatory_domain::set_country_code. country code: 0x%0x
 * Зовут его: discovery_handle_probe_resp, mid__apply_app_ies
 * Зовёт сам: fw_log__emit1
 * Глобалы (через gp): 0x8001fc
 */
	.section .text.regulatory_domain__set_country_code,"ax",@progbits
	.global regulatory_domain__set_country_code
regulatory_domain__set_country_code:
	.global L_8e1670
L_8e1670:
	mov_s r3,r0
L_8e1672:
	stw.as r0,[gp,0x46]
L_8e1676:
	mov_s r2,0x100eadc
L_8e167c:
	mov_s r0,0x0
L_8e167e:
	b.d L_8edfcc
L_8e1682:
	mov_s r1,0x2
