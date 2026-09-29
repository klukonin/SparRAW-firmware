/* scan_mngr__save_initial_passive_scan_info @ 0x8f81c0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::save_initial_passive_scan_info()
 * Зовут его: channels_switch_sm__action_start_dwelling
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_divmod_unsigned, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__save_initial_passive_scan_info
scan_mngr__save_initial_passive_scan_info:
	.global L_8f81c0
L_8f81c0:
	push_s blink
L_8f81c2:
	bl L_8c01e4
L_8f81c6:
	mov_s r13,r0
L_8f81c8:
	mov_s r14,r1
L_8f81ca:
	mov_s r1,0x1016448
L_8f81d0:
	bl.d L_8dcba8
L_8f81d4:
	mov_s r0,0x29
L_8f81d6:
	mov_s r0,0x853900
L_8f81dc:
	ld_s r0,[r0,0x14]
L_8f81de:
	bl.d L_8c02d4
L_8f81e2:
	mov r1,0x3e8
L_8f81e6:
	asl_s r1,r14,0x2
L_8f81e8:
	add1_s r1,r1,r1
L_8f81ea:
	add_s r1,r1,r13
L_8f81ec:
	st_s r0,[r1,0x2c]
L_8f81ee:
	mov_s r0,0x8054ec
L_8f81f4:
	ldw_s r0,[r0,0x2c]
L_8f81f6:
	b.d L_8c0254
L_8f81fa:
	st_s r0,[r1,0x30]
