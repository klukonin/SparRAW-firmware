/* mid_ctx_pool__init @ 0x8f56d0, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid_ctx__init_pools
 * Зовёт сам: mem_pool__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_ctx_pool__init
mid_ctx_pool__init:
	.global L_8f56d0
L_8f56d0:
	push_s blink
L_8f56d2:
	mov_s r1,0x842c88
L_8f56d8:
	sub r0,r1,0x14
L_8f56dc:
	mov_s r2,0xc
L_8f56de:
	bl.d L_8c7cf8
L_8f56e2:
	mov_s r3,0xa
L_8f56e4:
	mov_s r1,0x805514
L_8f56ea:
	mov_s r0,0x0
L_8f56ec:
	stw_s r0,[r1]
L_8f56ee:
	stw_s r0,[r1,0x2]
L_8f56f0:
	stw_s r0,[r1,0x4]
L_8f56f2:
	stw_s r0,[r1,0x6]
L_8f56f4:
	stw_s r0,[r1,0x8]
L_8f56f6:
	stw_s r0,[r1,0xa]
L_8f56f8:
	stw_s r0,[r1,0xc]
L_8f56fa:
	pop_s blink
L_8f56fc:
	j_s [blink]
L_8f56fe:
	nop_s
