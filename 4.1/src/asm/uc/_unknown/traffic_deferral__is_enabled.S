/* traffic_deferral__is_enabled @ 0x930bfc, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: traffic_deferral_cfg_cmd_handler
 */
	.section .text.traffic_deferral__is_enabled,"ax",@progbits
	.global traffic_deferral__is_enabled
traffic_deferral__is_enabled:
	.global L_930bfc
L_930bfc:
	ldb r2,[0x801034]
L_930c04:
	mov r4,r0
L_930c08:
	breq.d r2,0x0,L_930c18
L_930c0c:
	mov_s r0,0x0
L_930c0e:
	ld.as r3,[r4,0x4d]
L_930c12:
	cmp_s r3,0x0
L_930c14:
	jne [blink]
	.global L_930c18
L_930c18:
	mov_s r0,0x1
L_930c1a:
	st.as r0,[r4,0x51]
L_930c1e:
	add r4,r4,0x148
L_930c22:
	j_s.d [blink]
L_930c24:
	stb r1,[r4]
