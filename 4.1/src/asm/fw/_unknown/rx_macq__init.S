/* rx_macq__init @ 0x8d6754, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_pool__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, rx_macq__bind_all_queues, rx_macq__setup, vring_ctx_by_index
 */
	.section .text.rx_macq__init,"ax",@progbits
	.global rx_macq__init
rx_macq__init:
	.global L_8d6754
L_8d6754:
	push_s blink
L_8d6756:
	bl L_8c02c4
L_8d675a:
	sub_s sp,sp,0x4
L_8d675c:
	mov_s r13,0x0
L_8d675e:
	bl.d L_8ca828
L_8d6762:
	mov_s r0,r13
L_8d6764:
	mov_s r14,r0
L_8d6766:
	st_s r13,[sp,0x0]
L_8d6768:
	mov_s r1,r13
L_8d676a:
	mov_s r2,r13
L_8d676c:
	mov r3,0x520
L_8d6770:
	mov r4,0xc00
L_8d6778:
	mov r5,0x1a5
L_8d677c:
	mov_s r6,r13
L_8d677e:
	bl.d L_8d6390
L_8d6782:
	mov r7,0x4
L_8d6786:
	mov_s r0,r14
L_8d6788:
	mov_s r1,0x4
L_8d678a:
	bl.d L_8dd124
L_8d678e:
	mov_s r2,r13
L_8d6790:
	bl.d L_8ca828
L_8d6794:
	mov_s r0,0x1
L_8d6796:
	mov_s r14,r0
L_8d6798:
	st_s r13,[sp,0x0]
L_8d679a:
	mov_s r1,0x1
L_8d679c:
	mov_s r2,0x5
L_8d679e:
	mov r3,0x220
L_8d67a2:
	mov r4,0xda5
L_8d67aa:
	mov r5,0x189
L_8d67ae:
	mov r6,0x4
L_8d67b2:
	bl.d L_8d6390
L_8d67b6:
	mov r7,0x4
L_8d67ba:
	mov_s r0,r14
L_8d67bc:
	mov_s r1,0x4
L_8d67be:
	bl.d L_8dd124
L_8d67c2:
	mov_s r2,r13
L_8d67c4:
	b.d L_8c0334
L_8d67c8:
	add_s sp,sp,0x4
L_8d67ca:
	nop_s
