/* stream_mgr__pring_by_index @ 0x8da0dc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__bind_vring
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global stream_mgr__pring_by_index
stream_mgr__pring_by_index:
	.global L_8da0dc
L_8da0dc:
	push_s blink
L_8da0de:
	push_s r13
L_8da0e0:
	mov_s r1,0x847f34
L_8da0e6:
	sub r1,r1,0x400
L_8da0ea:
	add2_s r1,r1,r0
L_8da0ec:
	ld r13,[r1,0x44c]
L_8da0f4:
	breq_s r13,0,L_8da0fc
	.global L_8da0f6
L_8da0f6:
	b.d L_8c025c
L_8da0fa:
	ld_s r0,[r13,0xc]
	.global L_8da0fc
L_8da0fc:
	mov_s r0,blink
L_8da0fe:
	mov_s r1,0x6030
L_8da104:
	bl L_8c9b28
L_8da108:
	b_s L_8da0f6
L_8da10a:
	nop_s
