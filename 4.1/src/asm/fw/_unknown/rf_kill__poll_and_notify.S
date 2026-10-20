/* rf_kill__poll_and_notify @ 0x8de9c0, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, rgf_reg_880280_8ea634, set_reg_880b00_8c0744, set_reg_880b00_8c15d0
 */
	.section .text.rf_kill__poll_and_notify,"ax",@progbits
	.global rf_kill__poll_and_notify
rf_kill__poll_and_notify:
L_8de9c0:
	push_s blink
L_8de9c2:
	push_s r13
L_8de9c4:
	mov_s r0,0x880280
L_8de9ca:
	ld_s r0,[r0,0x8]
L_8de9cc:
	mov_s r13,0x8043d4
L_8de9d2:
	btst_s r0,0x0
L_8de9d4:
	mov_s r0,r13
L_8de9d6:
	mov_s r1,0x0
L_8de9d8:
	mov.eq r1,0x1
L_8de9dc:
	mov_s r2,0x0
L_8de9de:
	mov_s r3,r2
L_8de9e0:
	bl.d L_8d6a1c
L_8de9e4:
	mov_s r4,r2
L_8de9e6:
	bl.d L_8ea634
L_8de9ea:
	mov_s r0,r13
L_8de9ec:
	bl L_8c0744
L_8de9f0:
	bl L_8c15d0
L_8de9f4:
	b L_8c033c
