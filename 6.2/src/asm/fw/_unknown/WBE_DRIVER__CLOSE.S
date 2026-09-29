/* WBE_DRIVER__CLOSE @ 0x8f9b68, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WBE_DRIVER::CLOSE IDLES
 * Зовут его: maintain_sm__action_8cab64, mlme_sm_8027a0__action_8f9ca8
 * Зовёт сам: fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global WBE_DRIVER__CLOSE
WBE_DRIVER__CLOSE:
	.global L_8f9b68
L_8f9b68:
	push_s blink
L_8f9b6a:
	mov_s r1,0x1002f98
L_8f9b70:
	bl.d L_8dcba8
L_8f9b74:
	mov_s r0,0x2f
L_8f9b76:
	mov_s r1,0x2
L_8f9b78:
	mov_s r0,0x882a00
L_8f9b7e:
	st_s r1,[r0,0x74]
L_8f9b80:
	pop_s blink
L_8f9b82:
	j_s [blink]
