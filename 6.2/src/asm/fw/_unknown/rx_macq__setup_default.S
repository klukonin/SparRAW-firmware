/* rx_macq__setup_default @ 0x8d9914, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__oob_pair
 * Зовёт сам: rx_macq__setup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__setup_default
rx_macq__setup_default:
	.global L_8d9914
L_8d9914:
	push_s blink
L_8d9916:
	mov_s r0,0x0
L_8d9918:
	push_s r0
L_8d991a:
	mov_s r0,0x8431b8
L_8d9920:
	mov_s r1,0x3
L_8d9922:
	mov_s r2,0x2
L_8d9924:
	mov r3,0x660
L_8d9928:
	mov r4,0x1000
L_8d9930:
	asl r5,r4
L_8d9934:
	mov r6,0x48
L_8d9938:
	bl.d L_8d93a0
L_8d993c:
	mov r7,0x40
L_8d9940:
	add_s sp,sp,0x4
L_8d9942:
	pop_s blink
L_8d9944:
	j_s [blink]
L_8d9946:
	nop_s
