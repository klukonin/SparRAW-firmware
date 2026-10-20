/* ucode_cmd_0x3c_handler @ 0x924dcc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, uc_sysassert, ucode_cmd_28__apply
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x3c_handler
ucode_cmd_0x3c_handler:
	.global L_924dcc
L_924dcc:
	push_s blink
L_924dce:
	bl L_920234
L_924dd2:
	mov_s r14,r0
L_924dd4:
	mov_s r13,r1
L_924dd6:
	bl.d L_935e30
L_924dda:
	mov_s r1,0x5
L_924ddc:
	breq_s r0,0,L_924e02
	.global L_924dde
L_924dde:
	ldb_s r0,[r13]
L_924de0:
	add r1,r14,0x20
L_924de4:
	stb_s r0,[r1,0x4]
L_924de6:
	ldb_s r0,[r13,0x1]
L_924de8:
	stb_s r0,[r1,0x5]
L_924dea:
	ldb_s r0,[r13,0x2]
L_924dec:
	stb_s r0,[r1,0x6]
L_924dee:
	ldb_s r0,[r13,0x3]
L_924df0:
	stb_s r0,[r1,0x7]
L_924df2:
	ldb_s r0,[r13,0x4]
L_924df4:
	stb_s r0,[r1,0x8]
L_924df6:
	mov_s r0,L_924e9c-0x920000
L_924dfc:
	b.d L_9202a4
L_924e00:
	st_s r0,[r14,0x20]
	.global L_924e02
L_924e02:
	mov_s r0,blink
L_924e04:
	bl.d L_926618
L_924e08:
	mov_s r1,0xf4
L_924e0a:
	b_s L_924dde
