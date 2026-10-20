/* dmg_bcon__build_allocations @ 0x8df698, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dmg_bcon__rx_handler
 * Зовёт сам: schedule_scheme_builder__build_allocations_from_beacon
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dmg_bcon__build_allocations
dmg_bcon__build_allocations:
	.global L_8df698
L_8df698:
	ld_s r1,[r1,0xc]
L_8df69a:
	add_s r1,r1,0x68
L_8df69c:
	b.d L_8c5248
L_8df6a0:
	ld.as r0,[r0,0xa4]
