/* lm_main_sm__init @ 0x8d58c8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_if__set_cid
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, basic_sm__setup, maintain_sm__init
 */
	.section .text.lm_main_sm__init,"ax",@progbits
	.global lm_main_sm__init
lm_main_sm__init:
	.global L_8d58c8
L_8d58c8:
	push_s blink
L_8d58ca:
	bl.d L_8c02c0
L_8d58ce:
	mov r6,0xc
L_8d58d2:
	mov_s r14,r0
L_8d58d4:
	mov_s r15,r1
L_8d58d6:
	mov r4,0x8012c0
L_8d58de:
	mov r5,0x8012f0
L_8d58e6:
	ld.as r1,[gp,-0x7]
L_8d58ea:
	mov_s r13,0x0
L_8d58ec:
	mov_s r2,r13
L_8d58ee:
	mov_s r3,0x802690
L_8d58f4:
	bl.d L_8d6478
L_8d58f8:
	mov r7,0x7
L_8d58fc:
	st_s r15,[r14,0x2c]
L_8d58fe:
	add r0,r14,0x34
L_8d5902:
	bl.d L_8ed114
L_8d5906:
	mov_s r1,r14
L_8d5908:
	st_s r13,[r14,0x30]
L_8d590a:
	add3 r1,r14,0x20
L_8d590e:
	st_s r13,[r1,0x8]
L_8d5910:
	mov r0,-0x2
L_8d5914:
	stb_s r0,[r1,0xc]
L_8d5916:
	mov r0,-0x5
L_8d591a:
	stb_s r0,[r1,0xd]
L_8d591c:
	b.d L_8c032c
L_8d5920:
	st_s r13,[r14,0x28]
L_8d5922:
	nop_s
