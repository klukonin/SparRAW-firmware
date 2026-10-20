/* host_if__bf_ctrl_hal @ 0x8d953c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   *** BF CTRL HAL ***
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit0
 */
	.section .text.host_if__bf_ctrl_hal,"ax",@progbits
	.global host_if__bf_ctrl_hal
host_if__bf_ctrl_hal:
	.global L_8d953c
L_8d953c:
	push_s blink
L_8d953e:
	bl.d L_8c02c4
L_8d9542:
	mov_s r1,0x2
L_8d9544:
	mov_s r13,r0
L_8d9546:
	mov_s r14,r2
L_8d9548:
	mov_s r2,0x1006120
L_8d954e:
	bl.d L_8edfb0
L_8d9552:
	mov_s r0,0x5
L_8d9554:
	bl.d L_8c2c38
L_8d9558:
	mov_s r0,r13
L_8d955a:
	mov_s r1,r0
L_8d955c:
	mov_s r0,r13
L_8d955e:
	mov_s r2,0x0
L_8d9560:
	mov_s r3,0x1862
L_8d9566:
	mov_s r4,r2
L_8d9568:
	mov_s r5,r14
L_8d956a:
	mov_s r6,r2
L_8d956c:
	bl.d L_8e0460
L_8d9570:
	mov_s r7,r2
L_8d9572:
	b L_8c0334
L_8d9576:
	nop_s
