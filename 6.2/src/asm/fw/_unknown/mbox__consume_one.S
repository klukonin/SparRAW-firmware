/* mbox__consume_one @ 0x8e3764, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_mbox__drain_task, mbox__drain_debug, mbox__drain_operational
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mbox__load_obj_word4
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mbox__consume_one
mbox__consume_one:
	.global L_8e3764
L_8e3764:
	push_s blink
L_8e3766:
	bl L_8c01e4
L_8e376a:
	mov_s r13,r0
L_8e376c:
	add r14,r0,0x24
L_8e3770:
	bl.d L_8cca38
L_8e3774:
	mov_s r0,r14
L_8e3776:
	mov_s r1,r0
L_8e3778:
	ld_s r0,[r13,0x44]
L_8e377a:
	ld_s r2,[r0,0x4]
L_8e377c:
	jl_s.d [r2]
L_8e377e:
	mov_s r0,r13
L_8e3780:
	ld_s r1,[r14,0xc]
L_8e3782:
	ld_s r0,[r14]
L_8e3784:
	b.d L_8c0254
L_8e3788:
	st_s r0,[r1,0x8]
L_8e378a:
	nop_s
