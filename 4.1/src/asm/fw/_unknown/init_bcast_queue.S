/* init_bcast_queue @ 0x8d6674, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   init_bcast_queue: supported bcast MTU is %d which is less than %d
 * Зовут его: wmi_handler_bcast_vring_cfg
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit2, tx_macq__config_ring_params, tx_macq__setup
 */
	.section .text.init_bcast_queue,"ax",@progbits
	.global init_bcast_queue
init_bcast_queue:
	.global L_8d6674
L_8d6674:
	push_s blink
L_8d6676:
	bl.d L_8c02c0
L_8d667a:
	mov_s r2,0x10
L_8d667c:
	mov_s r15,r0
L_8d667e:
	mov_s r13,0xfb
L_8d6680:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8d6682:
	mov_s r14,0x8062f4
L_8d6688:
	add3_s r14,r14,r1
L_8d668a:
	stb_s r1,[r14]
L_8d668c:
	stw_s r0,[r14,0x6]
L_8d668e:
	mov_s r0,0x0
L_8d6690:
	stb_s r0,[r14,0x2]
L_8d6692:
	mov_s r0,r14
L_8d6694:
	mov_s r1,0x40
L_8d6696:
	mov_s r3,0x9
L_8d6698:
	asl_s r3,r3,0xb
L_8d669a:
	mov r4,0x800
L_8d66a2:
	bl.d L_8de5d8
L_8d66a6:
	mov_s r5,r13
L_8d66a8:
	mov_s r0,r14
L_8d66aa:
	mov_s r1,0x7
L_8d66ac:
	mov_s r2,0x0
L_8d66ae:
	mov_s r3,r2
L_8d66b0:
	mov_s r4,r2
L_8d66b2:
	mov_s r5,r2
L_8d66b4:
	mov_s r6,r2
L_8d66b6:
	bl.d L_8d63fc
L_8d66ba:
	mov_s r7,r2
L_8d66bc:
	brge r13,r15,L_8d66d2
L_8d66c0:
	mov_s r2,0x1015a5c
L_8d66c6:
	mov_s r0,0x0
L_8d66c8:
	mov_s r1,0x1
L_8d66ca:
	mov_s r3,r13
L_8d66cc:
	bl.d L_8edff8
L_8d66d0:
	mov_s r4,r15
	.global L_8d66d2
L_8d66d2:
	b L_8c032c
L_8d66d6:
	nop_s
