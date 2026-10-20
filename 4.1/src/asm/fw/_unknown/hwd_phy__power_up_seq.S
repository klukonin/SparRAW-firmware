/* hwd_phy__power_up_seq @ 0x8d50e4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_MODES_cmd_handler, assert__restore_hw_for_dump, ut_hw_modes_cmd_0x308
 * Зовёт сам: hwd_phy__enable_880a80, hwd_phy__enable_880b00, hwd_phy__rgf_880c00, hwd_phy__set_880c00, hwd_phy_init, phy__power_up_and_wait_ack
 */
	.section .text.hwd_phy__power_up_seq,"ax",@progbits
	.global hwd_phy__power_up_seq
hwd_phy__power_up_seq:
	.global L_8d50e4
L_8d50e4:
	push_s blink
L_8d50e6:
	breq_s r0,0,L_8d5108
L_8d50e8:
	bl.d L_8cf07c
L_8d50ec:
	mov_s r0,0x4
L_8d50ee:
	bl.d L_8cf484
L_8d50f2:
	mov_s r0,0x1
L_8d50f4:
	bl.d L_8cee90
L_8d50f8:
	mov_s r0,0x1
L_8d50fa:
	bl.d L_8cf04c
L_8d50fe:
	mov_s r0,0x1
L_8d5100:
	bl.d L_8cf1b8
L_8d5104:
	mov_s r0,0x0
L_8d5106:
	b_s L_8d512a
	.global L_8d5108
L_8d5108:
	bl.d L_8cf1b8
L_8d510c:
	mov_s r0,0x1
L_8d510e:
	bl.d L_8cf04c
L_8d5112:
	mov_s r0,0x0
L_8d5114:
	bl.d L_8cee90
L_8d5118:
	mov_s r0,0x0
L_8d511a:
	bl.d L_8cf484
L_8d511e:
	mov_s r0,0x0
L_8d5120:
	bl.d L_8cf07c
L_8d5124:
	mov_s r0,0x0
L_8d5126:
	bl L_8ceff0
	.global L_8d512a
L_8d512a:
	pop_s blink
L_8d512c:
	j_s [blink]
L_8d512e:
	nop_s
