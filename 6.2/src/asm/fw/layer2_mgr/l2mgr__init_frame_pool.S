/* l2mgr__init_frame_pool @ 0x8f5a00, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_main__init_frame_pool_thunk
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mem_pool__init, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__init_frame_pool
l2mgr__init_frame_pool:
	.global L_8f5a00
L_8f5a00:
	push_s blink
L_8f5a02:
	bl.d L_8c01e4
L_8f5a06:
	mov_s r1,0x69
L_8f5a08:
	mov_s r14,0x844914
L_8f5a0e:
	mov_s r0,r14
L_8f5a10:
	/* bl.d 0x008c1cd8 */
	.byte 0xca,0x0a,0x2f,0xe6
L_8f5a14:
	/* _asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8f5a16:
	mov_s r13,0x803c54
L_8f5a1c:
	add r0,r13,0x2c
L_8f5a20:
	mov_s r1,r14
L_8f5a22:
	mov_s r2,0x1c
L_8f5a24:
	bl.d L_8c7cf8
L_8f5a28:
	mov_s r3,0x78
L_8f5a2a:
	add3 r0,r13,0x8
L_8f5a2e:
	st_s r0,[r13,0x4]
L_8f5a30:
	add2 r0,r13,0x15
L_8f5a34:
	st_s r0,[r13]
L_8f5a36:
	mov_s r0,0x2
L_8f5a38:
	b.d L_8c0254
L_8f5a3c:
	stb r0,[gp, 0xd8]
