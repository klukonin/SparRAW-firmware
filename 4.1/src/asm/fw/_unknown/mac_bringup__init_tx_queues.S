/* mac_bringup__init_tx_queues @ 0x8f2860, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, tx_queue__configure_one
 */
	.section .text.mac_bringup__init_tx_queues,"ax",@progbits
	.global mac_bringup__init_tx_queues
mac_bringup__init_tx_queues:
	.global L_8f2860
L_8f2860:
	push_s blink
L_8f2862:
	bl.d L_8c02c4
L_8f2866:
	mov_s r1,0x2e
L_8f2868:
	mov_s r14,0x8
L_8f286a:
	mov_s r0,0x886b00
L_8f2870:
	st_s r14,[r0]
L_8f2872:
	mov_s r0,0x886c00
L_8f2878:
	st_s r1,[r0,0x74]
L_8f287a:
	mov_s r0,0x0
L_8f287c:
	mov_s r1,r14
L_8f287e:
	mov_s r13,0x1
L_8f2880:
	bl.d L_8e5020
L_8f2884:
	mov_s r2,r13
L_8f2886:
	mov_s lp_count,r14
L_8f2888:
	lp L_8f28a0
L_8f288c:
	asl_s r0,r13,0x5
L_8f288e:
	add_s r0,r0,0x4435800
L_8f2894:
	lsr_s r0,r0,0x3
L_8f2896:
	bic r0,r0,0x3
L_8f289a:
	st_s r14,[r0]
L_8f289c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f289e:
	extb_s r13,r13
	.global L_8f28a0
L_8f28a0:
	b L_8c0334
