/* hwf_rf__wait_reset_done @ 0x8d70b8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: init_rf_hw
 * Зовёт сам: fw_sysassert_fatal, hwf_rf__wait_ready_log
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf__wait_reset_done
hwf_rf__wait_reset_done:
	.global L_8d70b8
L_8d70b8:
	push_s blink
L_8d70ba:
	breq_s r0,0,L_8d70ca
L_8d70bc:
	mov_s r0,blink
L_8d70be:
	mov_s r1,0x131a
L_8d70c4:
	bl L_8c9b28
L_8d70c8:
	b_s L_8d70ce
	.global L_8d70ca
L_8d70ca:
	bl L_8d6ff4
	.global L_8d70ce
L_8d70ce:
	pop_s blink
L_8d70d0:
	j_s [blink]
L_8d70d2:
	nop_s
