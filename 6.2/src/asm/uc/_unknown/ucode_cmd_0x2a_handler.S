/* ucode_cmd_0x2a_handler @ 0x935de4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memset0_words_uc, uc_sysassert, ucode_cmd_28__apply
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x2a_handler
ucode_cmd_0x2a_handler:
	.global L_935de4
L_935de4:
	push_s blink
L_935de6:
	bl L_920234
L_935dea:
	mov_s r14,r0
L_935dec:
	mov_s r13,r1
L_935dee:
	bl.d L_935e30
L_935df2:
	mov_s r1,0x2
L_935df4:
	breq_s r0,0,L_935e24
	.global L_935df6
L_935df6:
	ldb_s r0,[r13,0x2]
L_935df8:
	add r1,r14,0x20
L_935dfc:
	stb_s r0,[r1,0x6]
L_935dfe:
	ldb_s r0,[r13,0x3]
L_935e00:
	stb_s r0,[r1,0x7]
L_935e02:
	ldb_s r0,[r13,0x1]
L_935e04:
	stb_s r0,[r1,0x5]
L_935e06:
	ldb_s r0,[r13]
L_935e08:
	stb_s r0,[r1,0x4]
L_935e0a:
	ldb_s r0,[r13,0x4]
L_935e0c:
	stb_s r0,[r1,0x8]
L_935e0e:
	mov_s r0,0x490c
L_935e14:
	st_s r0,[r14,0x20]
L_935e16:
	add2 r0,r14,0x15
L_935e1a:
	bl.d L_920a84
L_935e1e:
	mov_s r1,0x4
L_935e20:
	b L_9202a4
	.global L_935e24
L_935e24:
	mov_s r0,blink
L_935e26:
	bl.d L_926618
L_935e2a:
	mov_s r1,0xa8
L_935e2c:
	b_s L_935df6
L_935e2e:
	nop_s
