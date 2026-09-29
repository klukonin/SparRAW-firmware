/* ucode_cmd_selective_neighbor_cfg @ 0x937054, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Глобалы (через gp): 0x80054c
 */
	.section .text.ucode_cmd_selective_neighbor_cfg,"ax",@progbits
	.global ucode_cmd_selective_neighbor_cfg
ucode_cmd_selective_neighbor_cfg:
	.global L_937054
L_937054:
	ldb_s r1,[r0]
L_937056:
	mov_s r2,0x800a0c
L_93705c:
	brne r1,0x1,L_937064
L_937060:
	ldb_s r1,[r2,0xf]
L_937062:
	b_s L_937066
	.global L_937064
L_937064:
	mov_s r1,0x0
	.global L_937066
L_937066:
	stb_s r1,[r2,0x9]
L_937068:
	ldb_s r1,[r0,0x2]
L_93706a:
	stb_s r1,[r2,0xa]
L_93706c:
	ldb_s r1,[r0,0x1]
L_93706e:
	stb_s r1,[r2,0xd]
L_937070:
	ldb_s r1,[r0,0x3]
L_937072:
	stb_s r1,[r2,0xb]
L_937074:
	ldb_s r1,[r0,0x4]
L_937076:
	st.as r1,[gp,0x9]
L_93707a:
	ldb_s r1,[r0,0x5]
L_93707c:
	mov_s r0,0x8009b4
L_937082:
	j_s.d [blink]
L_937084:
	stb_s r1,[r0,0x8]
L_937086:
	nop_s
