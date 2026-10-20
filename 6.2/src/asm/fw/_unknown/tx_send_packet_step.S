/* tx_send_packet_step @ 0x8c736c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: TX_API__send_packet
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bits__set16h_s0_w4, bits__set16h_s5_w2, mac_hdr__copy_addr, memcpy_fw, mid__copy_bssid, mid__lookup_for_tx, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_send_packet_step
tx_send_packet_step:
	.global L_8c736c
L_8c736c:
	push_s blink
L_8c736e:
	bl L_8c01d0
L_8c7372:
	sub_s sp,sp,0x18
L_8c7374:
	mov_s r14,r0
L_8c7376:
	mov_s r19,r2
L_8c7378:
	mov_s r18,r3
L_8c737a:
	bl.d L_8cc3dc
L_8c737e:
	mov_s r0,r1
L_8c7380:
	mov_s r13,r0
L_8c7382:
	add3 r15,r0,0x9
L_8c7386:
	mov r16,sp
L_8c738a:
	bl.d L_8cc3ac
L_8c738e:
	mov_s r1,r16
L_8c7390:
	add r17,sp,0x8
L_8c7394:
	mov_s r0,r15
L_8c7396:
	bl.d L_8cbb58
L_8c739a:
	mov_s r1,r17
L_8c739c:
	add_s r15,sp,0x10
L_8c739e:
	mov_s r0,r13
L_8c73a0:
	mov_s r1,r19
L_8c73a2:
	bl.d L_8c7548
L_8c73a6:
	mov_s r2,r15
L_8c73a8:
	add_s r0,r14,0x4
L_8c73aa:
	mov_s r1,r15
L_8c73ac:
	bl.d L_8c0380
L_8c73b0:
	mov_s r2,0x6
L_8c73b2:
	add r0,r14,0xa
L_8c73b6:
	mov_s r1,r16
L_8c73b8:
	bl.d L_8c0380
L_8c73bc:
	mov_s r2,0x6
L_8c73be:
	add r0,r14,0x10
L_8c73c2:
	mov_s r1,r17
L_8c73c4:
	bl.d L_8c0380
L_8c73c8:
	mov_s r2,0x6
L_8c73ca:
	mov_s r1,0x0
L_8c73cc:
	stw_s r1,[r14,0x16]
L_8c73ce:
	stw_s r1,[r14,0x18]
L_8c73d0:
	add r0,r14,0x18
L_8c73d4:
	bl L_8ed328
L_8c73d8:
	ldw_s r1,[r14,0x18]
L_8c73da:
	bclr_s r1,r1,0x7
L_8c73dc:
	bclr_s r1,r1,0x4
L_8c73de:
	bclr_s r1,r1,0x9
L_8c73e0:
	stw_s r1,[r14,0x18]
L_8c73e2:
	bmsk r1,r18,0x3
L_8c73e6:
	bl L_8ed2ec
L_8c73ea:
	b.d L_8c022c
L_8c73ee:
	add_s sp,sp,0x18
