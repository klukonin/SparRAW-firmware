/* lmac_if_send_cmd_0x22 @ 0x8dc474, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: PS_CONNECTION__psc_complete_8e1794
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x22
lmac_if_send_cmd_0x22:
	.global L_8dc474
L_8dc474:
	push_s blink
L_8dc476:
	bl L_8c01e0
L_8dc47a:
	mov_s r14,r0
L_8dc47c:
	mov_s r15,r1
L_8dc47e:
	bl.d L_8c3284
L_8dc482:
	mov_s r13,r2
L_8dc484:
	stb_s r14,[r0]
L_8dc486:
	stb_s r15,[r0,0x1]
L_8dc488:
	ld_s r1,[r13]
L_8dc48a:
	mov_s r2,0xc
L_8dc48c:
	st_s r1,[r0,0x4]
L_8dc48e:
	ldw_s r1,[r13,0x6]
L_8dc490:
	stw_s r1,[r0,0xa]
L_8dc492:
	ldw_s r1,[r13,0x4]
L_8dc494:
	stw_s r1,[r0,0x8]
L_8dc496:
	mov_s r1,0x22
L_8dc498:
	bl.d L_8e5204
L_8dc49c:
	mov_s r3,0x0
L_8dc49e:
	b L_8c024c
L_8dc4a2:
	nop_s
