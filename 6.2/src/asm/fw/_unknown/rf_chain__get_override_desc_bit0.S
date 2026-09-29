/* rf_chain__get_override_desc_bit0 @ 0x8cc35c, 4 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rf_chain__program_sector_desc
 * Глобалы (через gp): 0x8003a4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf_chain__get_override_desc_bit0
rf_chain__get_override_desc_bit0:
	.global L_8cc35c
L_8cc35c:
	j_s.d [blink]
L_8cc35e:
	ld_s r0,[gp,0x220]
