/* hwd_abif__rgf_889300_8ccc78 @ 0x8ccc78, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwf__rf_lo_setup, phy_ber__enable_dig_loopback
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_abif__rgf_889300_8ccc78,"ax",@progbits
	.global hwd_abif__rgf_889300_8ccc78
hwd_abif__rgf_889300_8ccc78:
	.global L_8ccc78
L_8ccc78:
	push_s blink
L_8ccc7a:
	push_s r13
L_8ccc7c:
	cmp_s r0,0x0
L_8ccc7e:
	mov_s r13,0x1
L_8ccc80:
	sub_s.ne r13,r13,r13
L_8ccc82:
	mov_s r12,r13
L_8ccc84:
	bic.f r12,r12,-0xff
L_8ccc88:
	bne_s L_8ccc9e
	.global L_8ccc8a
L_8ccc8a:
	mov_s r1,0x889300
L_8ccc90:
	ld_s r0,[r1,0x64]
L_8ccc92:
	/* asl_s r13,r13,0x4 */
	.byte 0x04,0xbd
L_8ccc94:
	bclr_s r0,r0,0x4
L_8ccc96:
	or_s r13,r13,r0
L_8ccc98:
	st_s r13,[r1,0x64]
L_8ccc9a:
	b L_8c033c
	.global L_8ccc9e
L_8ccc9e:
	mov_s r0,blink
L_8ccca0:
	mov_s r2,0x1019954
L_8ccca6:
	mov_s r1,0xac
L_8ccca8:
	bl.d L_8c82c0
L_8cccac:
	mov r3,0x730
L_8cccb0:
	b_s L_8ccc8a
L_8cccb2:
	nop_s
