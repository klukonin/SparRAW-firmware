/* ucode_cmd_0x1b_handler @ 0x92e748, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x1b_handler
ucode_cmd_0x1b_handler:
	.global L_92e748
L_92e748:
	lr r1,[0xa]
L_92e74c:
	bclr r2,r1,0x1
L_92e750:
	flag r2
L_92e754:
	ldb_s r2,[r0,0x1]
L_92e756:
	st.as r2,[gp,-0x13]
L_92e75a:
	ldb_s r3,[r0]
L_92e75c:
	mov_s r2,0x0
L_92e75e:
	cmp_s r3,0x3
L_92e760:
	cmp.ne r3,0x2
L_92e764:
	mov.eq r2,0x1
L_92e768:
	extb_s r2,r2
L_92e76a:
	mov_s r3,0x8014a4
L_92e770:
	st_s r2,[r3,0x1c]
L_92e772:
	ldb_s r0,[r0]
L_92e774:
	bic r1,r1,-0x3
L_92e778:
	st_s r0,[r3,0x20]
L_92e77a:
	lr r0,[0xa]
L_92e77e:
	or_s r0,r0,r1
L_92e780:
	flag r0
L_92e784:
	j_s [blink]
L_92e786:
	nop_s
