/* brp__init_ctx @ 0x92b068, 168 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp_responder_flow_enter
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, brp__split_id, memset0_words_uc, rfc__clear_core_reg1, rfca__select_rf_uc
 * Глобалы (через gp): 0x8005b8
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global brp__init_ctx
brp__init_ctx:
	.global L_92b068
L_92b068:
	push_s blink
L_92b06a:
	bl.d L_920224
L_92b06e:
	mov_s r1,0x10
L_92b070:
	mov_s r18,r0
L_92b072:
	mov_s r14,0x800824
L_92b078:
	bl.d L_920a84
L_92b07c:
	add3 r0,r14,0xb
L_92b080:
	mov r16,0x8006b4
L_92b088:
	ldb r0,[r16, 0x3]
L_92b08c:
	stb r18,[r14, 0x58]
L_92b090:
	mov_s r17,r0
L_92b092:
	stb_s r0,[r14,0x4]
L_92b094:
	mov_s r13,0x0
L_92b096:
	mov_s r15,0x8
	.global L_92b098
L_92b098:
	mov_s r1,0x0
L_92b09a:
	add3 r0,r14,r13
L_92b09e:
	st_s r1,[r0,0x8]
L_92b0a0:
	st_s r1,[r0,0xc]
L_92b0a2:
	asl_s r0,r13,0x6
L_92b0a4:
	add_s r0,r0,0x801c94
L_92b0aa:
	bl.d L_920a84
L_92b0ae:
	mov_s r1,0x40
L_92b0b0:
	asl_s r0,r13,0x5
L_92b0b2:
	add_s r0,r0,0x801ef4
L_92b0b8:
	bl.d L_920a84
L_92b0bc:
	mov_s r1,0x20
L_92b0be:
	/* sub_s r15,r15,0x1 */
	.byte 0x61,0xbf
L_92b0c0:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_92b0c2:
	brhs.d r15,0x1,L_92b098
L_92b0c6:
	extb_s r13,r13
L_92b0c8:
	ld_s r0,[r14,0x60]
L_92b0ca:
	mov_s r1,0x801ed4
L_92b0d0:
	bset_s r0,r0,0x0
L_92b0d2:
	st_s r0,[r14,0x60]
L_92b0d4:
	ldw_s r0,[r1,0x18]
L_92b0d6:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92b0d8:
	extw_s r0,r0
L_92b0da:
	stw_s r0,[r1,0x18]
L_92b0dc:
	ldw_s r0,[gp,0x90]
L_92b0de:
	st r17,[r14, 0x5c]
L_92b0e2:
	bbit1 r0,r18,L_92b10c
L_92b0e6:
	ldb r0,[r16, 0x2]
L_92b0ea:
	bl.d L_928b8c
L_92b0ee:
	mov_s r1,0x0
L_92b0f0:
	bl.d L_929f94
L_92b0f4:
	mov_s r0,0x0
L_92b0f6:
	ldb r0,[r16, 0x5]
L_92b0fa:
	bl.d L_928b8c
L_92b0fe:
	mov_s r1,0x0
L_92b100:
	mov_s r0,0x801024
L_92b106:
	bl.d L_934dc8
L_92b10a:
	ld_s r0,[r0]
	.global L_92b10c
L_92b10c:
	b L_920284
