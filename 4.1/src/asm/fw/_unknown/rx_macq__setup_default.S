/* rx_macq__setup_default @ 0x8d6874, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__setup_bcast_queues
 * Зовёт сам: rx_macq__setup
 */
	.section .text.rx_macq__setup_default,"ax",@progbits
	.global rx_macq__setup_default
rx_macq__setup_default:
	.global L_8d6874
L_8d6874:
	push_s blink
L_8d6876:
	mov_s r0,0x0
L_8d6878:
	push_s r0
L_8d687a:
	mov_s r0,0x8435b8
L_8d6880:
	mov_s r1,0x3
L_8d6882:
	mov_s r2,0x2
L_8d6884:
	mov r3,0x660
L_8d6888:
	mov r4,0x1000
L_8d6890:
	asl r5,r4
L_8d6894:
	mov r6,0x48
L_8d6898:
	bl.d L_8d6390
L_8d689c:
	mov r7,0x40
L_8d68a0:
	add_s sp,sp,0x4
L_8d68a2:
	pop_s blink
L_8d68a4:
	j_s [blink]
L_8d68a6:
	nop_s
