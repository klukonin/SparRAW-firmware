/* lmac_if_send_cmd_0x08 @ 0x8dbb60, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ADD, ba_sm__action_8c4394, dma_mgr__reset_queue_0x19, dma_mgr__reset_queue_0x1a, sm_pring__timeout, tx_api__mask_from_queue
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lmac_if_send_cmd_0x08
lmac_if_send_cmd_0x08:
	.global L_8dbb60
L_8dbb60:
	push_s blink
L_8dbb62:
	bl L_8c01d0
L_8dbb66:
	mov_s r14,r0
L_8dbb68:
	mov_s r13,r1
L_8dbb6a:
	mov_s r15,r2
L_8dbb6c:
	mov_s r16,r3
L_8dbb6e:
	mov r17,r4
L_8dbb72:
	mov r18,r5
L_8dbb76:
	bl.d L_8c3284
L_8dbb7a:
	mov r19,r6
L_8dbb7e:
	stb r16,[r0]
L_8dbb82:
	stb_s r15,[r0,0x1]
L_8dbb84:
	st_s r14,[r0,0x4]
L_8dbb86:
	st_s r13,[r0,0x8]
L_8dbb88:
	mov_s r1,0x0
L_8dbb8a:
	stb_s r1,[r0,0x10]
L_8dbb8c:
	bmsk r1,r17,0x0
L_8dbb90:
	asl_s r2,r1,0x6
L_8dbb92:
	bmsk r1,r18,0x0
L_8dbb96:
	/* asl_s r1,r1,0x5 */
	.byte 0x05,0xb9
L_8dbb98:
	or_s r1,r1,r2
L_8dbb9a:
	st_s r1,[r0,0xc]
L_8dbb9c:
	breq r19,0x0,L_8dbba6
L_8dbba0:
	ld_s r1,[r0,0x10]
L_8dbba2:
	bset_s r1,r1,0x1
L_8dbba4:
	st_s r1,[r0,0x10]
	.global L_8dbba6
L_8dbba6:
	mov_s r1,0x8
L_8dbba8:
	mov_s r2,0x14
L_8dbbaa:
	bl.d L_8e5204
L_8dbbae:
	mov_s r3,0x0
L_8dbbb0:
	b L_8c022c
