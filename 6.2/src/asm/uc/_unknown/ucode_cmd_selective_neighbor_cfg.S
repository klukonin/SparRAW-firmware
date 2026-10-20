/* ucode_cmd_selective_neighbor_cfg @ 0x93cbf0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Глобалы (через gp): 0x800548
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_selective_neighbor_cfg
ucode_cmd_selective_neighbor_cfg:
	.global L_93cbf0
L_93cbf0:
	ldb_s r1,[r0]
L_93cbf2:
	mov_s r2,0x8014e8
L_93cbf8:
	brne r1,0x1,L_93cc00
L_93cbfc:
	ldb_s r1,[r2,0xf]
L_93cbfe:
	b_s L_93cc02
	.global L_93cc00
L_93cc00:
	mov_s r1,0x0
	.global L_93cc02
L_93cc02:
	stb_s r1,[r2,0x9]
L_93cc04:
	ldb_s r1,[r0,0x2]
L_93cc06:
	stb_s r1,[r2,0xa]
L_93cc08:
	ldb_s r1,[r0,0x1]
L_93cc0a:
	stb_s r1,[r2,0xd]
L_93cc0c:
	ldb_s r1,[r0,0x3]
L_93cc0e:
	stb_s r1,[r2,0xb]
L_93cc10:
	ldb_s r1,[r0,0x4]
L_93cc12:
	st.as r1,[gp,0x8]
L_93cc16:
	ldb_s r1,[r0,0x5]
L_93cc18:
	mov_s r0,0x80148c
L_93cc1e:
	j_s.d [blink]
L_93cc20:
	stb_s r1,[r0,0x8]
L_93cc22:
	nop_s
