/* hwd_phy__power_up_seq @ 0x8d7b84, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, assert__restore_hw_for_dump, ut_hw_modes_cmd_0x308
 * Зовёт сам: hwd_phy__enable_880a80, hwd_phy__enable_880b00, hwd_phy__uses_rgf_880c00_8d1d04, hwd_phy__uses_rgf_880c00_8d1d34, hwd_phy_init, hwd_phy_pwr_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_phy__power_up_seq
hwd_phy__power_up_seq:
	.global L_8d7b84
L_8d7b84:
	push_s blink
L_8d7b86:
	breq_s r0,0,L_8d7ba8
L_8d7b88:
	bl.d L_8d1d34
L_8d7b8c:
	mov_s r0,0x4
L_8d7b8e:
	bl.d L_8d2158
L_8d7b92:
	mov_s r0,0x1
L_8d7b94:
	bl.d L_8d1b2c
L_8d7b98:
	mov_s r0,0x1
L_8d7b9a:
	bl.d L_8d1d04
L_8d7b9e:
	mov_s r0,0x1
L_8d7ba0:
	bl.d L_8d1e68
L_8d7ba4:
	mov_s r0,0x0
L_8d7ba6:
	b_s L_8d7bca
	.global L_8d7ba8
L_8d7ba8:
	bl.d L_8d1e68
L_8d7bac:
	mov_s r0,0x1
L_8d7bae:
	bl.d L_8d1d04
L_8d7bb2:
	mov_s r0,0x0
L_8d7bb4:
	bl.d L_8d1b2c
L_8d7bb8:
	mov_s r0,0x0
L_8d7bba:
	bl.d L_8d2158
L_8d7bbe:
	mov_s r0,0x0
L_8d7bc0:
	bl.d L_8d1d34
L_8d7bc4:
	mov_s r0,0x0
L_8d7bc6:
	bl L_8d1ccc
	.global L_8d7bca
L_8d7bca:
	pop_s blink
L_8d7bcc:
	j_s [blink]
L_8d7bce:
	nop_s
