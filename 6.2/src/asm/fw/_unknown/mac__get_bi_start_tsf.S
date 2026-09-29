/* mac__get_bi_start_tsf @ 0x8e457c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_scheme__sum_two, schedule_scheme_builder__build_allocations, schedule_scheme_builder__build_allocations_from_beacon
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__get_bi_start_tsf
mac__get_bi_start_tsf:
	.global L_8e457c
L_8e457c:
	mov_s r0,0x886f80
L_8e4582:
	ld_s r0,[r0,0x44]
L_8e4584:
	j_s [blink]
L_8e4586:
	nop_s
