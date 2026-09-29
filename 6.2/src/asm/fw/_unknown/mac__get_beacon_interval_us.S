/* mac__get_beacon_interval_us @ 0x8e456c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__lookup_stream, lmac_if__evt_walk, schedule_scheme__sum_two, schedule_scheme_builder__build_allocations
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac__get_beacon_interval_us
mac__get_beacon_interval_us:
	.global L_8e456c
L_8e456c:
	mov_s r0,0x886d00
L_8e4572:
	ld_s r0,[r0,0x64]
L_8e4574:
	extw_s r0,r0
L_8e4576:
	j_s.d [blink]
L_8e4578:
	asl_s r0,r0,0xa
L_8e457a:
	nop_s
