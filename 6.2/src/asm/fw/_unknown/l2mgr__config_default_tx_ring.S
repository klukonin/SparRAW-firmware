/* l2mgr__config_default_tx_ring @ 0x8d9948, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__oob_pair
 * Зовёт сам: __ld_r13_to_r13_ret, qdesc_cfg__get_w14_field, tx_macq__config_ring_params
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__config_default_tx_ring
l2mgr__config_default_tx_ring:
	.global L_8d9948
L_8d9948:
	push_s blink
L_8d994a:
	push_s r13
L_8d994c:
	mov_s r13,0x806194
L_8d9952:
	mov_s r0,0x18
L_8d9954:
	bl.d L_8cc2fc
L_8d9958:
	stb_s r0,[r13,0xa]
L_8d995a:
	mov_s r5,r0
L_8d995c:
	mov_s r0,r13
L_8d995e:
	mov_s r1,0x0
L_8d9960:
	mov r2,0x1c2
L_8d9964:
	mov_s r3,0x3
L_8d9966:
	mov r4,0x2000
L_8d996e:
	bl.d L_8e29b8
L_8d9972:
	asl_s r3,r3,0xc
L_8d9974:
	b L_8c025c
