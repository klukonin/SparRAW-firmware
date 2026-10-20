/* WBE_DRIVER__link_down_notif @ 0x8eda38, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wbe_driver.cpp
 *   WBE_DRIVER::link_down_notif: DEV2_LINK_DOWN - Disconnect
 * Зовут его: isr_pcie_main
 * Зовёт сам: fw_log__emit0, fw_sysassert_fatal, set_reg_882680, u_schd__add
 */
	.section .text.WBE_DRIVER__link_down_notif,"ax",@progbits
	.global WBE_DRIVER__link_down_notif
WBE_DRIVER__link_down_notif:
	.global L_8eda38
L_8eda38:
	push_s blink
L_8eda3a:
	bl.d L_8ee778
L_8eda3e:
	mov_s r1,r0
L_8eda40:
	breq_s r1,0,L_8eda58
L_8eda42:
	mov_s r0,blink
L_8eda44:
	mov_s r2,0x10032e4
L_8eda4a:
	mov_s r1,0x6c
L_8eda4c:
	bset_s r1,r1,0xc
L_8eda4e:
	bl.d L_8c82c0
L_8eda52:
	mov r3,0x531
L_8eda56:
	b_s L_8eda76
	.global L_8eda58
L_8eda58:
	mov_s r2,0x1003adc
L_8eda5e:
	mov_s r0,0xf
L_8eda60:
	bl.d L_8edfb0
L_8eda64:
	mov_s r1,0x2
L_8eda66:
	mov_s r0,0x2b448
L_8eda6c:
	mov_s r1,0x1
L_8eda6e:
	mov_s r2,0x0
L_8eda70:
	bl.d L_8c2ac8
L_8eda74:
	mov_s r3,0x2
	.global L_8eda76
L_8eda76:
	pop_s blink
