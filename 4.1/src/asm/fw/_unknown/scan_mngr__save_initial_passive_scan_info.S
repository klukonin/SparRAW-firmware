/* scan_mngr__save_initial_passive_scan_info @ 0x8efe98, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::save_initial_passive_scan_info()
 * Зовут его: channels_switch_sm__action_start_dwelling
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_div_unsigned, fw_log__emit0
 */
	.section .text.scan_mngr__save_initial_passive_scan_info,"ax",@progbits
	.global scan_mngr__save_initial_passive_scan_info
scan_mngr__save_initial_passive_scan_info:
	.global L_8efe98
L_8efe98:
	push_s blink
L_8efe9a:
	bl L_8c02c4
L_8efe9e:
	mov_s r13,r0
L_8efea0:
	mov_s r14,r1
L_8efea2:
	mov_s r2,0x1013b68
L_8efea8:
	mov_s r0,0x9
L_8efeaa:
	bl.d L_8edfb0
L_8efeae:
	mov_s r1,0x2
L_8efeb0:
	mov_s r0,0x854880
L_8efeb6:
	ld_s r0,[r0,0x74]
L_8efeb8:
	bl.d L_8c03b4
L_8efebc:
	mov r1,0x3e8
L_8efec0:
	asl_s r1,r14,0x2
L_8efec2:
	add1_s r1,r1,r1
L_8efec4:
	add_s r1,r1,r13
L_8efec6:
	st_s r0,[r1,0x2c]
L_8efec8:
	mov_s r0,0x805d88
L_8efece:
	ldw_s r0,[r0,0x14]
L_8efed0:
	b.d L_8c0334
L_8efed4:
	st_s r0,[r1,0x30]
L_8efed6:
	nop_s
