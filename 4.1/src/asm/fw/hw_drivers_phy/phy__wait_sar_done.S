/* phy__wait_sar_done @ 0x8cfbc8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR
 *   hw_drivers_phy.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_sar_step2, hwf_calib_sar_alg
 * Зовёт сам: fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.phy__wait_sar_done,"ax",@progbits
	.global phy__wait_sar_done
phy__wait_sar_done:
	.global L_8cfbc8
L_8cfbc8:
	push_s blink
L_8cfbca:
	mov_s r1,0x0
L_8cfbcc:
	bset_s r1,r1,0x18
	.global L_8cfbce
L_8cfbce:
	mov_s r0,0x885000
L_8cfbd4:
	ld_s r0,[r0,0x4]
L_8cfbd6:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_8cfbd8:
	bbit1 r0,0xd,L_8cfbde
L_8cfbdc:
	brne_s r1,0,L_8cfbce
	.global L_8cfbde
L_8cfbde:
	bbit1 r0,0xd,L_8cfc06
L_8cfbe2:
	mov_s r2,0x10186dc
L_8cfbe8:
	mov_s r0,0x0
L_8cfbea:
	bl.d L_8edfb0
L_8cfbee:
	mov_s r1,r0
L_8cfbf0:
	mov_s r0,blink
L_8cfbf2:
	mov_s r2,0x1018690
L_8cfbf8:
	mov_s r1,0x1333
L_8cfbfe:
	bl.d L_8c82c0
L_8cfc02:
	mov r3,0x40a
	.global L_8cfc06
L_8cfc06:
	pop_s blink
L_8cfc08:
	j_s [blink]
L_8cfc0a:
	nop_s
