/* obj__set_field4_one @ 0x8c458c, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr_mac_start_step, mid_list__remove_entry, pcp_stop__flow
 */
	.section .text.obj__set_field4_one,"ax",@progbits
	.global obj__set_field4_one
obj__set_field4_one:
	.global L_8c458c
L_8c458c:
	mov_s r1,0x1
L_8c458e:
	j_s.d [blink]
L_8c4590:
	st_s r1,[r0,0x4]
L_8c4592:
	nop_s
