/* traffic_deferral__clear_node @ 0x935644, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: traffic_deferral_cfg_cmd_handler
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global traffic_deferral__clear_node
traffic_deferral__clear_node:
	.global L_935644
L_935644:
	mov_s r1,0x0
L_935646:
	st.as r1,[r0,0x51]
L_93564a:
	add r0,r0,0x148
L_93564e:
	j_s.d [blink]
L_935650:
	stb_s r1,[r0]
L_935652:
	nop_s
