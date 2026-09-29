/* mac__switch_core_and_setup_dma @ 0x936d64, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_mode__switch_sequence, shallow_sleep_rfc_step
 * Зовёт сам: __ld_r13_ret_uc, dma_mac_setup_wrap, hw_modes_mac__switch_core
 */
	.section .text.mac__switch_core_and_setup_dma,"ax",@progbits
	.global mac__switch_core_and_setup_dma
mac__switch_core_and_setup_dma:
	.global L_936d64
L_936d64:
	push_s blink
L_936d66:
	push_s r13
L_936d68:
	mov.f r13,r0
L_936d6c:
	bl.ne L_927944
L_936d70:
	mov_s r1,0x8009fc
L_936d76:
	mov_s r0,r13
L_936d78:
	mov_s r2,0x0
L_936d7a:
	mov_s r3,r2
L_936d7c:
	bl.d L_927d20
L_936d80:
	mov_s r4,r2
L_936d82:
	b L_92028c
L_936d86:
	nop_s
