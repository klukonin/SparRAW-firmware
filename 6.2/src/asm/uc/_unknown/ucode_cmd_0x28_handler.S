/* ucode_cmd_0x28_handler @ 0x935d90, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, uc_sysassert, ucode_cmd_28__apply
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x28_handler
ucode_cmd_0x28_handler:
	.global L_935d90
L_935d90:
	push_s blink
L_935d92:
	bl L_920230
L_935d96:
	mov_s r13,r0
L_935d98:
	mov_s r14,r1
L_935d9a:
	mov_s r15,r2
L_935d9c:
	bl.d L_935e30
L_935da0:
	mov_s r1,0x1
L_935da2:
	breq_s r0,0,L_935dda
	.global L_935da4
L_935da4:
	add3 r1,r13,0x10
L_935da8:
	brlo.d r15,0x15,L_935db2
L_935dac:
	st_s r15,[r1,0x7c]
L_935dae:
	mov_s r0,0x14
L_935db0:
	st_s r0,[r1,0x7c]
	.global L_935db2
L_935db2:
	ldb_s r0,[r14,0x2]
L_935db4:
	add r1,r13,0x20
L_935db8:
	stb_s r0,[r1,0x6]
L_935dba:
	ldb_s r0,[r14,0x3]
L_935dbc:
	stb_s r0,[r1,0x7]
L_935dbe:
	ldb_s r0,[r14,0x1]
L_935dc0:
	stb_s r0,[r1,0x5]
L_935dc2:
	ldb_s r0,[r14]
L_935dc4:
	stb_s r0,[r1,0x4]
L_935dc6:
	ldb_s r0,[r14,0x4]
L_935dc8:
	stb_s r0,[r1,0x8]
L_935dca:
	mov_s r0,0x4898
L_935dd0:
	st_s r0,[r13,0x20]
L_935dd2:
	mov_s r0,0x0
L_935dd4:
	b.d L_92029c
L_935dd8:
	st_s r0,[r13,0x58]
	.global L_935dda
L_935dda:
	mov_s r0,blink
L_935ddc:
	bl.d L_926618
L_935de0:
	mov_s r1,0x99
L_935de2:
	b_s L_935da4
