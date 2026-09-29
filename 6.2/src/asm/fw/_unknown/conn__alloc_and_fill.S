/* conn__alloc_and_fill @ 0x8dc43c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: qh__write_or_conn_alloc
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd, memcpy_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn__alloc_and_fill
conn__alloc_and_fill:
	.global L_8dc43c
L_8dc43c:
	push_s blink
L_8dc43e:
	bl L_8c01d8
L_8dc442:
	mov_s r14,r0
L_8dc444:
	mov_s r15,r1
L_8dc446:
	mov_s r17,r2
L_8dc448:
	bl.d L_8c3284
L_8dc44c:
	mov_s r16,r3
L_8dc44e:
	mov_s r13,r0
L_8dc450:
	stb_s r14,[r0]
L_8dc452:
	stb_s r15,[r0,0x1]
L_8dc454:
	stw r16,[r0, 0x2]
L_8dc458:
	/* add_s r0,0x4 */
	.byte 0x04,0xe0
L_8dc45a:
	mov_s r1,r17
L_8dc45c:
	bl.d L_8c0380
L_8dc460:
	mov_s r2,0x70
L_8dc462:
	mov_s r0,r13
L_8dc464:
	mov_s r1,0x45
L_8dc466:
	mov_s r2,0x74
L_8dc468:
	bl.d L_8e5204
L_8dc46c:
	mov_s r3,0x0
L_8dc46e:
	b L_8c023c
L_8dc472:
	nop_s
