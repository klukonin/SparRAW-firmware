/* tx_macq__config_ring_params @ 0x8e29b8, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: init_bcast_queue, l2mgr__config_default_tx_ring, tx_macq_api_step, tx_queue_mgr__create_queue
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal, macq_desc__write, txq_ring_param_config_queue
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tx_macq__config_ring_params
tx_macq__config_ring_params:
	.global L_8e29b8
L_8e29b8:
	push_s blink
L_8e29ba:
	bl L_8c01d4
L_8e29be:
	sub_s sp,sp,0x1c
L_8e29c0:
	mov_s r14,r0
L_8e29c2:
	mov_s r13,r1
L_8e29c4:
	mov_s r15,r2
L_8e29c6:
	ldb_s r0,[r0,0xc]
L_8e29c8:
	mov r18,r4
L_8e29cc:
	mov_s r17,r3
L_8e29ce:
	mov r16,r5
L_8e29d2:
	brne_s r0,0,L_8e2a20
	.global L_8e29d4
L_8e29d4:
	stw r17,[r14]
L_8e29d8:
	stw_s r13,[r14,0x2]
L_8e29da:
	stw r18,[r14, 0x4]
L_8e29de:
	ldb_s r0,[r14,0xa]
L_8e29e0:
	stw_s r15,[r14,0x8]
L_8e29e2:
	st_s r0,[sp,0x0]
L_8e29e4:
	stw r17,[sp, 0x4]
L_8e29e8:
	stw r18,[sp, 0x6]
L_8e29ec:
	stw r13,[sp, 0x8]
L_8e29f0:
	stw r15,[sp, 0xa]
L_8e29f4:
	add_s r13,sp,0xc
L_8e29f6:
	mov_s r2,sp
L_8e29f8:
	mov_s r0,r13
L_8e29fa:
	mov_s r1,r16
L_8e29fc:
	bl.d L_8ea4b8
L_8e2a00:
	ldb_s r3,[r14,0xb]
L_8e2a02:
	mov_s r0,r13
L_8e2a04:
	ldb_s r1,[r14,0xa]
L_8e2a06:
	mov_s r2,0x2
L_8e2a08:
	mov_s r3,0x0
L_8e2a0a:
	mov_s r4,r3
L_8e2a0c:
	mov_s r5,r3
L_8e2a0e:
	mov_s r6,r3
L_8e2a10:
	mov_s r13,0x1
L_8e2a12:
	bl.d L_8c5010
L_8e2a16:
	mov_s r7,r13
L_8e2a18:
	stb_s r13,[r14,0xc]
L_8e2a1a:
	b.d L_8c0234
L_8e2a1e:
	add_s sp,sp,0x1c
	.global L_8e2a20
L_8e2a20:
	mov_s r0,blink
L_8e2a22:
	mov_s r1,0x127c
L_8e2a28:
	bl L_8c9b28
L_8e2a2c:
	b_s L_8e29d4
L_8e2a2e:
	nop_s
