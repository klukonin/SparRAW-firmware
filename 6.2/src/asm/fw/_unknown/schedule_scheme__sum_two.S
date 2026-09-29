/* schedule_scheme__sum_two @ 0x8e0d48, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: schedule_scheme_builder__build_allocations, schedule_scheme_builder__build_allocations_from_beacon
 * Зовёт сам: __ld_r13_to_r13_ret, lmac_if__evt_walk, mac__get_beacon_interval_us, mac__get_bi_start_tsf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global schedule_scheme__sum_two
schedule_scheme__sum_two:
	.global L_8e0d48
L_8e0d48:
	push_s blink
L_8e0d4a:
	push_s r13
L_8e0d4c:
	bl.d L_8e457c
L_8e0d50:
	mov_s r13,r0
L_8e0d52:
	bl.d L_8e456c
L_8e0d56:
	mov_s r1,r0
L_8e0d58:
	add_s r0,r0,r1
L_8e0d5a:
	st_s r0,[r13,0x8]
L_8e0d5c:
	bl.d L_8e1cd8
L_8e0d60:
	mov_s r0,r13
L_8e0d62:
	bl.d L_8e1cd8
L_8e0d66:
	mov_s r0,r13
L_8e0d68:
	b L_8c025c
