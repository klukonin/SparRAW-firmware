/* tx_macq__config_ring_params @ 0x8de5d8, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_macq.cpp
 * Зовут его: init_bcast_queue, tx_macq__config_bcast_ring, tx_macq_api_step, tx_queue_mgr__create_queue
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal, mac_indirect__write_entry, txq_ring_param_config_queue
 */
	.section .text.tx_macq__config_ring_params,"ax",@progbits
	.global tx_macq__config_ring_params
tx_macq__config_ring_params:
	.global L_8de5d8
L_8de5d8:
	push_s blink
L_8de5da:
	bl L_8c02b4
L_8de5de:
	sub_s sp,sp,0x1c
L_8de5e0:
	mov_s r13,r0
L_8de5e2:
	mov_s r14,r1
L_8de5e4:
	mov_s r15,r2
L_8de5e6:
	ldb_s r0,[r0,0x2]
L_8de5e8:
	mov r18,r4
L_8de5ec:
	mov_s r16,r3
L_8de5ee:
	mov r17,r5
L_8de5f2:
	brne_s r0,0,L_8de634
	.global L_8de5f4
L_8de5f4:
	ldb_s r0,[r13]
L_8de5f6:
	stw r16,[sp, 0x4]
L_8de5fa:
	st_s r0,[sp,0x0]
L_8de5fc:
	stw r18,[sp, 0x6]
L_8de600:
	stw r14,[sp, 0x8]
L_8de604:
	stw r15,[sp, 0xa]
L_8de608:
	add_s r14,sp,0xc
L_8de60a:
	mov_s r2,sp
L_8de60c:
	mov_s r0,r14
L_8de60e:
	mov_s r1,r17
L_8de610:
	bl.d L_8e516c
L_8de614:
	ldb_s r3,[r13,0x1]
L_8de616:
	mov_s r0,r14
L_8de618:
	ldb_s r1,[r13]
L_8de61a:
	mov_s r2,0x2
L_8de61c:
	mov_s r3,0x0
L_8de61e:
	mov_s r4,r3
L_8de620:
	mov_s r5,r3
L_8de622:
	mov_s r6,r3
L_8de624:
	mov_s r14,0x1
L_8de626:
	bl.d L_8c46a4
L_8de62a:
	mov_s r7,r14
L_8de62c:
	stb_s r14,[r13,0x2]
L_8de62e:
	b.d L_8c0314
L_8de632:
	add_s sp,sp,0x1c
	.global L_8de634
L_8de634:
	mov_s r0,blink
L_8de636:
	mov_s r2,0x1015aa0
L_8de63c:
	mov_s r1,0x127c
L_8de642:
	bl.d L_8c82c0
L_8de646:
	mov_s r3,0x60
