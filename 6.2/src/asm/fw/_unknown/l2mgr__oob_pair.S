/* l2mgr__oob_pair @ 0x8fb480, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: l2mgr__config_default_tx_ring, rx_macq__setup_default
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__oob_pair
l2mgr__oob_pair:
	.global L_8fb480
L_8fb480:
	push_s blink
L_8fb482:
	bl L_8d9948
L_8fb486:
	bl L_8d9914
L_8fb48a:
	pop_s blink
L_8fb48c:
	j_s [blink]
L_8fb48e:
	nop_s
