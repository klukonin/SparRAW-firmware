/* hwd_abif__rgf_889300_8ccb7c @ 0x8ccb7c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf__rf_lo_setup, phy_ber__enable_dig_loopback
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_889300_8ccb7c,"ax",@progbits
	.global hwd_abif__rgf_889300_8ccb7c
hwd_abif__rgf_889300_8ccb7c:
	.global L_8ccb7c
L_8ccb7c:
	push_s blink
L_8ccb7e:
	bl L_8c02c4
L_8ccb82:
	bclr.f r14,r0,0x0
L_8ccb86:
	mov_s r13,r0
L_8ccb88:
	bne_s L_8ccba6
	.global L_8ccb8a
L_8ccb8a:
	brne_s r14,0,L_8ccbba
	.global L_8ccb8c
L_8ccb8c:
	mov_s r0,0x889300
L_8ccb92:
	ld_s r2,[r0,0x64]
L_8ccb94:
	asl_s r1,r13
L_8ccb96:
	bclr_s r2,r2,0x1
L_8ccb98:
	or_s r1,r1,r2
L_8ccb9a:
	bclr_s r1,r1,0x2
L_8ccb9c:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_8ccb9e:
	or_s r13,r13,r1
L_8ccba0:
	st_s r13,[r0,0x64]
L_8ccba2:
	b L_8c0334
	.global L_8ccba6
L_8ccba6:
	mov_s r0,blink
L_8ccba8:
	mov_s r2,0x1019954
L_8ccbae:
	mov_s r1,0xad
L_8ccbb0:
	bl.d L_8c82c0
L_8ccbb4:
	mov r3,0x706
L_8ccbb8:
	b_s L_8ccb8a
	.global L_8ccbba
L_8ccbba:
	mov_s r0,blink
L_8ccbbc:
	mov_s r2,0x1019954
L_8ccbc2:
	mov_s r1,0xae
L_8ccbc4:
	bl.d L_8c82c0
L_8ccbc8:
	mov r3,0x706
L_8ccbcc:
	b_s L_8ccb8c
L_8ccbce:
	nop_s
