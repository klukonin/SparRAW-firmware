/* lmac_if_send_cmd_0x14 @ 0x8d8390, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: MAINTAIN_SM__OPEN, maintain_sm__reset_link_cfg
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x14,"ax",@progbits
	.global lmac_if_send_cmd_0x14
lmac_if_send_cmd_0x14:
	.global L_8d8390
L_8d8390:
	push_s blink
L_8d8392:
	bl L_8c02b4
L_8d8396:
	mov_s r14,r0
L_8d8398:
	mov_s r13,r1
L_8d839a:
	mov_s r15,r2
L_8d839c:
	mov_s r16,r3
L_8d839e:
	mov r17,r4
L_8d83a2:
	bl.d L_8c2b0c
L_8d83a6:
	mov r18,r5
L_8d83aa:
	st_s r14,[r0]
L_8d83ac:
	bmsk_s r13,r13,0x0
L_8d83ae:
	ld_s r1,[r0,0x4]
L_8d83b0:
	asl_s r2,r13,0x3
L_8d83b2:
	bclr_s r1,r1,0x3
L_8d83b4:
	or_s r2,r2,r1
L_8d83b6:
	bmsk_s r15,r15,0x0
L_8d83b8:
	/* asl_s r15,r15,0x2 */
	.byte 0x02,0xbf
L_8d83ba:
	bclr_s r2,r2,0x2
L_8d83bc:
	or_s r2,r2,r15
L_8d83be:
	bmsk r1,r16,0x0
L_8d83c2:
	asl_s r1,r1
L_8d83c4:
	bclr_s r2,r2,0x1
L_8d83c6:
	or_s r2,r2,r1
L_8d83c8:
	bmsk r1,r17,0x0
L_8d83cc:
	bclr_s r2,r2,0x0
L_8d83ce:
	or_s r2,r2,r1
L_8d83d0:
	bmsk r1,r18,0x0
L_8d83d4:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8d83d6:
	bclr_s r2,r2,0x4
L_8d83d8:
	or_s r1,r1,r2
L_8d83da:
	st_s r1,[r0,0x4]
L_8d83dc:
	mov_s r1,0x14
L_8d83de:
	mov_s r2,0x8
L_8d83e0:
	bl.d L_8e0694
L_8d83e4:
	mov_s r3,0x0
L_8d83e6:
	b L_8c0314
L_8d83ea:
	nop_s
