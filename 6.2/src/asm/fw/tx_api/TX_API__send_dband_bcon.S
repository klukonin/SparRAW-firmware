/* TX_API__send_dband_bcon @ 0x8e5284, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::send_dband_bcon. length=%d on channel %d.
 *   send_dband_bcon: add_packet() failure
 * Зовут его: add_bcon, add_discovery_bcon
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log_emit0, fw_log_emit2, fw_sysassert_fatal, fwq_tx__add_packet
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global TX_API__send_dband_bcon
TX_API__send_dband_bcon:
	.global L_8e5284
L_8e5284:
	push_s blink
L_8e5286:
	bl L_8c01d0
L_8e528a:
	sub_s sp,sp,0x8
L_8e528c:
	mov_s r13,r0
L_8e528e:
	mov_s r14,r1
L_8e5290:
	mov_s r16,r2
L_8e5292:
	mov_s r17,r3
L_8e5294:
	mov r19,r4
L_8e5298:
	mov r18,r5
L_8e529c:
	mov_s r1,0x1018568
L_8e52a2:
	mov_s r0,0x27
L_8e52a4:
	mov_s r2,r14
L_8e52a6:
	bl.d L_8dcc80
L_8e52aa:
	mov_s r3,r5
L_8e52ac:
	mov_s r15,sp
L_8e52ae:
	breq_s r13,0,L_8e52fe
	.global L_8e52b0
L_8e52b0:
	st_s r13,[r15,0x4]
L_8e52b2:
	sub r13,r13,0x24
L_8e52b6:
	st_s r13,[r15]
L_8e52b8:
	ld_s r1,[sp,0x0]
L_8e52ba:
	mov_s r2,0x0
L_8e52bc:
	stw_s r14,[r1,0x8]
L_8e52be:
	st r16,[r1, 0x20]
L_8e52c2:
	st r17,[r1, 0x18]
L_8e52c6:
	st r19,[r1, 0x1c]
L_8e52ca:
	stw_s r2,[r1,0xc]
L_8e52cc:
	ld_s r0,[r1,0xc]
L_8e52ce:
	stb_s r2,[r1,0x10]
L_8e52d0:
	bset_s r0,r0,0x0
L_8e52d2:
	st_s r0,[r1,0xc]
L_8e52d4:
	stb_s r2,[r1,0xa]
L_8e52d6:
	st_s r2,[r1,0x4]
L_8e52d8:
	mov_s r0,0x8421e4
L_8e52de:
	bl.d L_8c2af4
L_8e52e2:
	mov_s r2,r18
L_8e52e4:
	mov.f r13,r0
L_8e52e8:
	bne_s L_8e52f6
L_8e52ea:
	mov_s r1,0x101859c
L_8e52f0:
	bl.d L_8dcba8
L_8e52f4:
	mov_s r0,0x17
	.global L_8e52f6
L_8e52f6:
	mov_s r0,r13
L_8e52f8:
	b.d L_8c022c
L_8e52fc:
	add_s sp,sp,0x8
	.global L_8e52fe
L_8e52fe:
	mov_s r0,blink
L_8e5300:
	mov_s r1,0x11e9
L_8e5306:
	bl L_8c9b28
L_8e530a:
	b_s L_8e52b0
