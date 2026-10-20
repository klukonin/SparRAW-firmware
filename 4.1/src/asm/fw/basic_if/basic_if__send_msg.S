/* basic_if__send_msg @ 0x8c9598, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   basic_if.cpp
 * Зовут его: low_sme__send_evt2sw
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_mailbox__enqueue_msg, fw_sysassert_fatal
 */
	.section .text.basic_if__send_msg,"ax",@progbits
	.global basic_if__send_msg
basic_if__send_msg:
	.global L_8c9598
L_8c9598:
	push_s blink
L_8c959a:
	bl L_8c02b8
L_8c959e:
	mov_s r15,r0
L_8c95a0:
	mov.f r14,r1
L_8c95a4:
	mov_s r17,r2
L_8c95a6:
	mov_s r16,r3
L_8c95a8:
	beq_s L_8c95d4
	.global L_8c95aa
L_8c95aa:
	lr r13,[0xa]
L_8c95ae:
	bclr r0,r13,0x1
L_8c95b2:
	flag r0
L_8c95b6:
	add_s r0,r15,0x4
L_8c95b8:
	mov_s r1,r14
L_8c95ba:
	mov_s r2,r17
L_8c95bc:
	bl.d L_8c9468
L_8c95c0:
	mov_s r3,r16
L_8c95c2:
	lr r0,[0xa]
L_8c95c6:
	bic r13,r13,-0x3
L_8c95ca:
	or_s r13,r13,r0
L_8c95cc:
	flag r13
L_8c95d0:
	b L_8c031c
	.global L_8c95d4
L_8c95d4:
	mov_s r0,blink
L_8c95d6:
	mov_s r2,0x100269c
L_8c95dc:
	mov_s r1,0xc2
L_8c95de:
	bl.d L_8c82c0
L_8c95e2:
	mov_s r3,0x20
L_8c95e4:
	b_s L_8c95aa
L_8c95e6:
	nop_s
