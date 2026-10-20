/* mid_ctx__init_pools @ 0x8d91f4, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r13_to_r13_ret, llist__init, mem_pool__init, mid_ctx_pool__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid_ctx__init_pools
mid_ctx__init_pools:
	.global L_8d91f4
L_8d91f4:
	push_s blink
L_8d91f6:
	bl.d L_8f56d0
L_8d91fa:
	push_s r13
L_8d91fc:
	mov_s r13,0x804e70
L_8d9202:
	mov_s r1,0x804e90
L_8d9208:
	add r0,r13,0xc
L_8d920c:
	mov r2,0x2b0
L_8d9210:
	bl.d L_8c7cf8
L_8d9214:
	mov_s r3,0x1
L_8d9216:
	bl.d L_8e293c
L_8d921a:
	mov_s r0,r13
L_8d921c:
	mov_s r1,0x0
L_8d921e:
	stb r1,[gp, 0xd5]
L_8d9222:
	mov_s r0,0x857280
L_8d9228:
	b.d L_8c025c
L_8d922c:
	stb_s r1,[r0,0xe]
L_8d922e:
	nop_s
