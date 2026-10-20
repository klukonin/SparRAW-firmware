/* hwd_rfc__rgf_889100 @ 0x8d04bc, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwm_analog_channel_switch, power_halt_seq
 * Зовёт сам: hwd_rfc_write_core
 */
	.section .text.hwd_rfc__rgf_889100,"ax",@progbits
	.global hwd_rfc__rgf_889100
hwd_rfc__rgf_889100:
	.global L_8d04bc
L_8d04bc:
	push_s blink
L_8d04be:
	brne r1,0x1,L_8d04ce
L_8d04c2:
	mov_s r1,0x8
L_8d04c4:
	mov_s r2,0x0
L_8d04c6:
	bl.d L_8d0f80
L_8d04ca:
	mov_s r3,r2
L_8d04cc:
	b_s L_8d04f8
	.global L_8d04ce
L_8d04ce:
	mov_s r1,0x889100
L_8d04d4:
	ld_s r0,[r1,0x18]
L_8d04d6:
	bclr_s r0,r0,0x4
L_8d04d8:
	st_s r0,[r1,0x18]
L_8d04da:
	mov_s r0,0x7d
L_8d04dc:
	/* asl_s r0,r0,0x7 */
	.byte 0x07,0xb8
L_8d04de:
	mov lp_count,r0
L_8d04e2:
	nop_s
L_8d04e4:
	lp L_8d04ec
L_8d04e8:
	nop_s
L_8d04ea:
	nop_s
	.global L_8d04ec
L_8d04ec:
	mov_s r1,0x889100
L_8d04f2:
	ld_s r0,[r1,0x18]
L_8d04f4:
	bset_s r0,r0,0x4
L_8d04f6:
	st_s r0,[r1,0x18]
	.global L_8d04f8
L_8d04f8:
	pop_s blink
L_8d04fa:
	j_s [blink]
