/* mac_bringup__init_rx_fields @ 0x8e4510, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_bringup__init_rx_desc
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, macq_desc__write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_bringup__init_rx_fields
mac_bringup__init_rx_fields:
	.global L_8e4510
L_8e4510:
	push_s blink
L_8e4512:
	bl.d L_8c01e0
L_8e4516:
	mov_s r2,0x1
L_8e4518:
	mov_s r15,r1
L_8e451a:
	add3 r14,r0,0xa
L_8e451e:
	add r13,r0,0x20
L_8e4522:
	mov_s r3,0x0
L_8e4524:
	mov_s r4,r3
L_8e4526:
	mov_s r5,r3
L_8e4528:
	mov_s r6,r3
L_8e452a:
	bl.d L_8c5010
L_8e452e:
	mov r7,0x2
L_8e4532:
	mov_s r0,r14
L_8e4534:
	mov_s r1,r15
L_8e4536:
	mov_s r2,0x1
L_8e4538:
	mov_s r3,0x2
L_8e453a:
	mov r4,0x0
L_8e453e:
	mov r5,0x0
L_8e4542:
	mov r6,0x0
L_8e4546:
	bl.d L_8c5010
L_8e454a:
	mov_s r7,r2
L_8e454c:
	mov_s r0,r13
L_8e454e:
	mov_s r1,r15
L_8e4550:
	mov_s r2,0x1
L_8e4552:
	mov_s r3,0x3
L_8e4554:
	mov r4,0x0
L_8e4558:
	mov r5,0x0
L_8e455c:
	mov r6,0x0
L_8e4560:
	bl.d L_8c5010
L_8e4564:
	mov_s r7,r3
L_8e4566:
	b L_8c024c
L_8e456a:
	nop_s
