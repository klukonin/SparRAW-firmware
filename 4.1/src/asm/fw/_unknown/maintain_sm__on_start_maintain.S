/* maintain_sm__on_start_maintain @ 0x8f13b0, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lm__get_cid, lm__get_mid_id, lmac_if_send_cmd_0x0f, maintain_sm__lock_radio, mid_list__by_mid, stub_ret_8c5a30
 */
	.section .text.maintain_sm__on_start_maintain,"ax",@progbits
	.global maintain_sm__on_start_maintain
maintain_sm__on_start_maintain:
L_8f13b0:
	push_s blink
L_8f13b2:
	bl L_8c02c4
L_8f13b6:
	mov_s r14,r0
L_8f13b8:
	mov_s r0,0x1
L_8f13ba:
	st_s r0,[r14,0x28]
L_8f13bc:
	bl.d L_8ca1a8
L_8f13c0:
	ld_s r0,[r14,0x2c]
L_8f13c2:
	bl L_8ca1b0
L_8f13c6:
	ld_s r0,[r0,0x50]
L_8f13c8:
	mov_s r1,0x0
L_8f13ca:
	cmp_s r0,0x2
L_8f13cc:
	cmp.ne r0,0x3
L_8f13d0:
	mov.ne r0,r1
L_8f13d4:
	bne_s L_8f13d8
L_8f13d6:
	mov_s r0,0x1
	.global L_8f13d8
L_8f13d8:
	extb_s r0,r0
L_8f13da:
	add3 r1,r14,0x10
L_8f13de:
	st_s r0,[r1,0x44]
L_8f13e0:
	mov_s r13,0x0
L_8f13e2:
	st_s r13,[r14,0x40]
L_8f13e4:
	st_s r13,[r14,0x44]
L_8f13e6:
	st_s r13,[r14,0x48]
L_8f13e8:
	st_s r13,[r14,0x4c]
L_8f13ea:
	st_s r13,[r1,0x40]
L_8f13ec:
	st.as r13,[gp,-0x1b]
L_8f13f0:
	st_s r13,[r1,0x48]
L_8f13f2:
	bl.d L_8c5a30
L_8f13f6:
	mov_s r0,r14
L_8f13f8:
	bl.d L_8c9d74
L_8f13fc:
	ld_s r0,[r14,0x2c]
L_8f13fe:
	extb_s r0,r0
L_8f1400:
	bl.d L_8d8a5c
L_8f1404:
	mov_s r1,0x1
L_8f1406:
	ld_s r0,[r14,0x30]
L_8f1408:
	stb r13,[r14, 0x3c]
L_8f140c:
	cmp_s r0,0x1
L_8f140e:
	bl.ne.d L_8de58c
L_8f1412:
	mov.ne r0,r14
L_8f1416:
	.byte 0x21,0x07
