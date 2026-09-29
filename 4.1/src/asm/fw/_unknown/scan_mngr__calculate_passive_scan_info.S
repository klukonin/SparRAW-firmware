/* scan_mngr__calculate_passive_scan_info @ 0x8ea0d4, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::calculate_passive_scan_info
 * Зовут его: channels_switch_sm__action_dwelling_stopped
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_div_unsigned, fw_log__emit0
 */
	.section .text.scan_mngr__calculate_passive_scan_info,"ax",@progbits
	.global scan_mngr__calculate_passive_scan_info
scan_mngr__calculate_passive_scan_info:
	.global L_8ea0d4
L_8ea0d4:
	push_s blink
L_8ea0d6:
	bl L_8c02c0
L_8ea0da:
	mov_s r13,r0
L_8ea0dc:
	mov_s r15,r1
L_8ea0de:
	mov_s r2,0x1013b94
L_8ea0e4:
	mov_s r0,0x9
L_8ea0e6:
	bl.d L_8edfb0
L_8ea0ea:
	mov_s r1,0x2
L_8ea0ec:
	asl_s r14,r15,0x2
L_8ea0ee:
	mov_s r0,0x854880
L_8ea0f4:
	add1_s r14,r14,r14
L_8ea0f6:
	ld_s r0,[r0,0x74]
L_8ea0f8:
	add_s r13,r13,r14
L_8ea0fa:
	ld_s r14,[r13,0x2c]
L_8ea0fc:
	bl.d L_8c03b4
L_8ea100:
	mov r1,0x3e8
L_8ea104:
	sub_s r0,r0,r14
L_8ea106:
	st_s r0,[r13,0x2c]
L_8ea108:
	mov_s r0,0x805d88
L_8ea10e:
	ldw_s r0,[r0,0x14]
L_8ea110:
	ld_s r1,[r13,0x30]
L_8ea112:
	cmp_s r1,r0
L_8ea114:
	mov_s r0,0x1
L_8ea116:
	sub.ge r0,r0,r0
L_8ea11a:
	st_s r0,[r13,0x30]
L_8ea11c:
	mov_s r0,0x1
L_8ea11e:
	b.d L_8c032c
L_8ea122:
	st_s r0,[r13,0x28]
