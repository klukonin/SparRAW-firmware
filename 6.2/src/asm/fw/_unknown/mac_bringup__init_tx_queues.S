/* mac_bringup__init_tx_queues @ 0x8fa7a4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac__set_cid_mcs
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_bringup__init_tx_queues
mac_bringup__init_tx_queues:
	.global L_8fa7a4
L_8fa7a4:
	push_s blink
L_8fa7a6:
	bl.d L_8c01e4
L_8fa7aa:
	mov_s r1,0x2e
L_8fa7ac:
	mov_s r14,0x8
L_8fa7ae:
	mov_s r0,0x886b00
L_8fa7b4:
	st_s r14,[r0]
L_8fa7b6:
	mov_s r0,0x886c00
L_8fa7bc:
	st_s r1,[r0,0x74]
L_8fa7be:
	mov_s r0,0x0
L_8fa7c0:
	mov_s r1,r14
L_8fa7c2:
	mov_s r13,0x1
L_8fa7c4:
	bl.d L_8ea3b8
L_8fa7c8:
	mov_s r2,r13
L_8fa7ca:
	mov_s lp_count,r14
L_8fa7cc:
	lp L_8fa7e4
L_8fa7d0:
	asl_s r0,r13,0x5
L_8fa7d2:
	add_s r0,r0,0x4435800
L_8fa7d8:
	lsr_s r0,r0,0x3
L_8fa7da:
	bic r0,r0,0x3
L_8fa7de:
	st_s r14,[r0]
L_8fa7e0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8fa7e2:
	extb_s r13,r13
	.global L_8fa7e4
L_8fa7e4:
	b L_8c0254
