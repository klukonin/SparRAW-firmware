/* get_g_800140_8c9f8c @ 0x8c9f8c, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: channels_switch_sm__action_pop_ch_and_tune, discovery__tsf_wa, rx_pkt__lookup_handler, sort_scan_ch_list
 */
	.section .text.get_g_800140_8c9f8c,"ax",@progbits
	.global get_g_800140_8c9f8c
get_g_800140_8c9f8c:
	.global L_8c9f8c
L_8c9f8c:
	mov_s r1,r0
L_8c9f8e:
	ld_s r0,[gp,-0x30]
L_8c9f90:
	ld_s r2,[r0]
L_8c9f92:
	ld_s r2,[r2,0x1c]
L_8c9f94:
	j_s [r2]
L_8c9f96:
	nop_s
