/* ucode_cmd_0x2e_handler @ 0x92811c, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memset0_words_uc, uc_sysassert, ucode_cmd_28__apply
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x2e_handler
ucode_cmd_0x2e_handler:
	.global L_92811c
L_92811c:
	push_s blink
L_92811e:
	bl L_920234
L_928122:
	mov_s r14,r0
L_928124:
	mov_s r13,r1
L_928126:
	bl.d L_935e30
L_92812a:
	mov_s r1,0x3
L_92812c:
	breq_s r0,0,L_92815c
	.global L_92812e
L_92812e:
	ldb_s r0,[r13]
L_928130:
	add r1,r14,0x20
L_928134:
	stb_s r0,[r1,0x4]
L_928136:
	ldb_s r0,[r13,0x1]
L_928138:
	stb_s r0,[r1,0x5]
L_92813a:
	ldb_s r0,[r13,0x2]
L_92813c:
	stb_s r0,[r1,0x6]
L_92813e:
	ldb_s r0,[r13,0x3]
L_928140:
	stb_s r0,[r1,0x7]
L_928142:
	ldb_s r0,[r13,0x4]
L_928144:
	stb_s r0,[r1,0x8]
L_928146:
	mov_s r0,L_9281f8-0x920000
L_92814c:
	st_s r0,[r14,0x20]
L_92814e:
	add r0,r14,0x30
L_928152:
	bl.d L_920a84
L_928156:
	mov_s r1,0x24
L_928158:
	b L_9202a4
	.global L_92815c
L_92815c:
	mov_s r0,blink
L_92815e:
	bl.d L_926618
L_928162:
	mov_s r1,0xa1
L_928164:
	b_s L_92812e
L_928166:
	nop_s
