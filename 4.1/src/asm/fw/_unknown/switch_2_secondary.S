/* switch_2_secondary @ 0x8e32f4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   switch_2_secondary - pop request. for CB:0x%x
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log__emit1, llist__insert, radio_mgr__copy_tune_params, rm_main_sm__kick_channel_switch_sm, tail_llist__is_empty
 */
	.section .text.switch_2_secondary,"ax",@progbits
	.global switch_2_secondary
switch_2_secondary:
L_8e32f4:
	push_s blink
L_8e32f6:
	bl L_8c02c0
L_8e32fa:
	mov_s r14,r0
L_8e32fc:
	bl.d L_8dc8e8
L_8e3300:
	ld_s r0,[r0,0x2c]
L_8e3302:
	mov_s r13,r0
L_8e3304:
	ld_s r0,[r14,0x28]
L_8e3306:
	mov_s r15,0x2
L_8e3308:
	breq_s r0,0,L_8e331a
L_8e330a:
	mov_s r2,0x1015f28
L_8e3310:
	mov_s r0,0x8
L_8e3312:
	mov_s r1,r15
L_8e3314:
	bl.d L_8edfcc
L_8e3318:
	ld_s r3,[r13,0xc]
	.global L_8e331a
L_8e331a:
	add2 r0,r14,0x31
L_8e331e:
	bl.d L_8c1fc4
L_8e3322:
	mov_s r1,r13
L_8e3324:
	st_s r15,[r13,0x8]
L_8e3326:
	mov_s r0,r14
L_8e3328:
	bl.d L_8e59f4
L_8e332c:
	mov_s r1,r13
L_8e332e:
	bl.d L_8d75dc
L_8e3332:
	mov_s r0,r14
L_8e3334:
	b L_8c032c
