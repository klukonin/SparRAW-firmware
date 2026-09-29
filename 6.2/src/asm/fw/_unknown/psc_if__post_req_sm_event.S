/* psc_if__post_req_sm_event @ 0x8e1af8, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global psc_if__post_req_sm_event
psc_if__post_req_sm_event:
	.global L_8e1af8
L_8e1af8:
	push_s blink
L_8e1afa:
	push_s r13
L_8e1afc:
	mov.f r13,r0
L_8e1b00:
	beq_s L_8e1b12
	.global L_8e1b02
L_8e1b02:
	mov_s r0,0x0
L_8e1b04:
	st_s r0,[r13,0xc]
L_8e1b06:
	ldb_s r0,[r13,0x11]
L_8e1b08:
	cmp_s r0,0x3
L_8e1b0a:
	mov_s r0,r13
L_8e1b0c:
	blt_s L_8e1b20
L_8e1b0e:
	mov_s r1,0x4
L_8e1b10:
	b_s L_8e1b22
	.global L_8e1b12
L_8e1b12:
	mov_s r0,blink
L_8e1b14:
	mov_s r1,0x1425
L_8e1b1a:
	bl L_8c9b28
L_8e1b1e:
	b_s L_8e1b02
	.global L_8e1b20
L_8e1b20:
	mov_s r1,0x3
	.global L_8e1b22
L_8e1b22:
	mov_s r2,0x0
L_8e1b24:
	mov_s r3,r2
L_8e1b26:
	bl.d L_8d9b6c
L_8e1b2a:
	mov_s r4,r2
L_8e1b2c:
	b L_8c025c
