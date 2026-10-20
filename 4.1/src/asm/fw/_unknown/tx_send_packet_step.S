/* tx_send_packet_step @ 0x8c63e0, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__send_packet
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bf_h_s0_w4, bf_h_s5_w2, mac_hdr__copy_addr, memcpy_fw, mid__copy_bssid, mid__lookup_for_tx, mid_list__by_mid
 */
	.section .text.tx_send_packet_step,"ax",@progbits
	.global tx_send_packet_step
tx_send_packet_step:
	.global L_8c63e0
L_8c63e0:
	push_s blink
L_8c63e2:
	bl L_8c02b0
L_8c63e6:
	sub_s sp,sp,0x18
L_8c63e8:
	mov_s r14,r0
L_8c63ea:
	mov_s r19,r2
L_8c63ec:
	mov_s r18,r3
L_8c63ee:
	bl.d L_8ca1b0
L_8c63f2:
	mov_s r0,r1
L_8c63f4:
	mov_s r13,r0
L_8c63f6:
	add3 r15,r0,0x9
L_8c63fa:
	mov r16,sp
L_8c63fe:
	bl.d L_8ca180
L_8c6402:
	mov_s r1,r16
L_8c6404:
	add r17,sp,0x8
L_8c6408:
	mov_s r0,r15
L_8c640a:
	bl.d L_8c9ae4
L_8c640e:
	mov_s r1,r17
L_8c6410:
	add_s r15,sp,0x10
L_8c6412:
	mov_s r0,r13
L_8c6414:
	mov_s r1,r19
L_8c6416:
	bl.d L_8c655c
L_8c641a:
	mov_s r2,r15
L_8c641c:
	add_s r0,r14,0x4
L_8c641e:
	mov_s r1,r15
L_8c6420:
	bl.d L_8c0460
L_8c6424:
	mov_s r2,0x6
L_8c6426:
	add r0,r14,0xa
L_8c642a:
	mov_s r1,r16
L_8c642c:
	bl.d L_8c0460
L_8c6430:
	mov_s r2,0x6
L_8c6432:
	add r0,r14,0x10
L_8c6436:
	mov_s r1,r17
L_8c6438:
	bl.d L_8c0460
L_8c643c:
	mov_s r2,0x6
L_8c643e:
	mov_s r1,0x0
L_8c6440:
	stw_s r1,[r14,0x16]
L_8c6442:
	stw_s r1,[r14,0x18]
L_8c6444:
	add r0,r14,0x18
L_8c6448:
	bl L_8e82f4
L_8c644c:
	ldw_s r1,[r14,0x18]
L_8c644e:
	bclr_s r1,r1,0x7
L_8c6450:
	bclr_s r1,r1,0x4
L_8c6452:
	bclr_s r1,r1,0x9
L_8c6454:
	stw_s r1,[r14,0x18]
L_8c6456:
	bmsk r1,r18,0x3
L_8c645a:
	bl L_8e82b8
L_8c645e:
	b.d L_8c030c
L_8c6462:
	add_s sp,sp,0x18
