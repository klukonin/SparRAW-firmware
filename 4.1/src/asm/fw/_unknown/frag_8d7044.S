/* frag_8d7044 @ 0x8d7044, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sta_psc_sm__psc_resp_rx
 */
	.section .text.frag_8d7044,"ax",@progbits
	.global frag_8d7044
frag_8d7044:
	.global L_8d7044
L_8d7044:
	push_s r13
L_8d7046:
	ldb r3,[r0, 0x35]
L_8d704a:
	mov_s r2,0x0
L_8d704c:
	ldb r0,[r0, 0x34]
L_8d7050:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
L_8d7052:
	sub r13,r0,r3
L_8d7056:
	sub r3,r1,r13
L_8d705a:
	extb_s r3,r3
L_8d705c:
	sub_s r0,r0,r1
L_8d705e:
	extb_s r0,r0
L_8d7060:
	cmp r3,0x80
L_8d7064:
	mov_s r12,0x80
L_8d7066:
	cmp.lt r0,r12
L_8d706a:
	mov.ge r0,r2
L_8d706e:
	mov.lt r0,0x1
L_8d7072:
	j_s.d [blink]
L_8d7074:
	pop_s r13
L_8d7076:
	nop_s
