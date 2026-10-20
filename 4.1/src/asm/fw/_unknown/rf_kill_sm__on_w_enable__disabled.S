/* rf_kill_sm__on_w_enable__disabled @ 0x8ea1ac, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__inject_event, low_sme__send_rf_mgmt_status, rf_kill__set_flag
 * Глобалы (через gp): 0x800180, 0x800184
 */
	.section .text.rf_kill_sm__on_w_enable__disabled,"ax",@progbits
	.global rf_kill_sm__on_w_enable__disabled
rf_kill_sm__on_w_enable__disabled:
L_8ea1ac:
	push_s blink
L_8ea1ae:
	mov_s r2,r0
L_8ea1b0:
	bl.d L_8f2948
L_8ea1b4:
	mov_s r0,0x0
L_8ea1b6:
	ld_s r0,[gp,0x10]
L_8ea1b8:
	brne_s r0,0,L_8ea1d0
L_8ea1ba:
	ld_s r0,[gp,0x14]
L_8ea1bc:
	brne_s r0,0,L_8ea1d0
L_8ea1be:
	mov_s r0,r2
L_8ea1c0:
	mov_s r1,0x3
L_8ea1c2:
	mov_s r2,0x0
L_8ea1c4:
	mov_s r3,0x0
L_8ea1c6:
	bl.d L_8d6a1c
L_8ea1ca:
	mov r4,0x0
L_8ea1ce:
	b_s L_8ea1d4
	.global L_8ea1d0
L_8ea1d0:
	bl L_8e1048
	.global L_8ea1d4
L_8ea1d4:
	pop_s blink
L_8ea1d6:
	j_s [blink]
