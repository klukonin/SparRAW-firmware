/* hwf_rf__wait_ready_log @ 0x8d6ff4, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RF RESET DONE
 * Зовут его: hwf_rf__wait_reset_done
 * Зовёт сам: fw_log_emit0, sdp__drive_pin_timed
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwf_rf__wait_ready_log
hwf_rf__wait_ready_log:
	.global L_8d6ff4
L_8d6ff4:
	push_s blink
L_8d6ff6:
	bl.d L_8d6e88
L_8d6ffa:
	mov_s r0,0x0
L_8d6ffc:
	bl.d L_8d6e88
L_8d7000:
	mov_s r0,0x1
L_8d7002:
	mov_s r1,0x101b3b4
L_8d7008:
	bl.d L_8dcba8
L_8d700c:
	mov_s r0,0x20
L_8d700e:
	pop_s blink
L_8d7010:
	j_s [blink]
L_8d7012:
	nop_s
