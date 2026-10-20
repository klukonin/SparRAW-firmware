/* traffic_deferral__clear_node @ 0x930bec, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: traffic_deferral_cfg_cmd_handler
 */
	.section .text.traffic_deferral__clear_node,"ax",@progbits
	.global traffic_deferral__clear_node
traffic_deferral__clear_node:
	.global L_930bec
L_930bec:
	mov_s r1,0x0
L_930bee:
	st.as r1,[r0,0x51]
L_930bf2:
	add r0,r0,0x148
L_930bf6:
	j_s.d [blink]
L_930bf8:
	stb_s r1,[r0]
L_930bfa:
	nop_s
