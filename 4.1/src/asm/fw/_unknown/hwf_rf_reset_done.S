/* hwf_rf_reset_done @ 0x8d46c0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RF RESET DONE
 * Зовут его: hwf_rf__wait_reset_done
 * Зовёт сам: fw_log__emit0, tail_SDP__sdp_drive_value
 */
	.section .text.hwf_rf_reset_done,"ax",@progbits
	.global hwf_rf_reset_done
hwf_rf_reset_done:
	.global L_8d46c0
L_8d46c0:
	push_s blink
L_8d46c2:
	bl.d L_8d46b8
L_8d46c6:
	mov_s r0,0x0
L_8d46c8:
	bl.d L_8d46b8
L_8d46cc:
	mov_s r0,0x1
L_8d46ce:
	mov_s r0,0x7d
L_8d46d0:
	/* asl_s r0,r0,0x6 */
	.byte 0x06,0xb8
L_8d46d2:
	mov lp_count,r0
L_8d46d6:
	nop_s
L_8d46d8:
	lp L_8d46e0
L_8d46dc:
	nop_s
L_8d46de:
	nop_s
	.global L_8d46e0
L_8d46e0:
	mov_s r2,0x1016c64
L_8d46e6:
	mov_s r0,0x0
L_8d46e8:
	bl.d L_8edfb0
L_8d46ec:
	mov_s r1,0x2
L_8d46ee:
	pop_s blink
L_8d46f0:
	j_s [blink]
L_8d46f2:
	nop_s
