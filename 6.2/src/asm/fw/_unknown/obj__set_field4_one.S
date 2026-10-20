/* obj__set_field4_one @ 0x8c4ee4, 8 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__reset_bss_defaults, mid_list__remove_entry, pcp_stop__flow
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global obj__set_field4_one
obj__set_field4_one:
	.global L_8c4ee4
L_8c4ee4:
	mov_s r1,0x1
L_8c4ee6:
	j_s.d [blink]
L_8c4ee8:
	st_s r1,[r0,0x4]
L_8c4eea:
	nop_s
