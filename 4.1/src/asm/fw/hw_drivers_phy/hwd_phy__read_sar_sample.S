/* hwd_phy__read_sar_sample @ 0x8cf7b4, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler, calib_sar_step, calib_sar_step2
 */
	.section .text.hwd_phy__read_sar_sample,"ax",@progbits
	.global hwd_phy__read_sar_sample
hwd_phy__read_sar_sample:
	.global L_8cf7b4
L_8cf7b4:
	mov_s r2,0x885010
L_8cf7ba:
	add3_s r2,r2,r0
L_8cf7bc:
	ld_s r3,[r2]
L_8cf7be:
	mov_s r2,0x885014
L_8cf7c4:
	add3_s r2,r2,r0
L_8cf7c6:
	ld_s r2,[r2]
L_8cf7c8:
	extw_s r3,r3
L_8cf7ca:
	asl_s r2,r2,0x10
L_8cf7cc:
	add_s r2,r2,r3
L_8cf7ce:
	asr r3,r2,0x1f
L_8cf7d2:
	st_s r2,[r1]
L_8cf7d4:
	st_s r3,[r1,0x4]
L_8cf7d6:
	mov_s r2,0x885050
L_8cf7dc:
	add3_s r2,r2,r0
L_8cf7de:
	ld_s r3,[r2]
L_8cf7e0:
	mov_s r2,0x885054
L_8cf7e6:
	add3_s r2,r2,r0
L_8cf7e8:
	ld_s r0,[r2]
L_8cf7ea:
	extw_s r3,r3
L_8cf7ec:
	asl_s r0,r0,0x10
L_8cf7ee:
	add_s r0,r0,r3
L_8cf7f0:
	asr r2,r0,0x1f
L_8cf7f4:
	st_s r0,[r1,0x8]
L_8cf7f6:
	j_s.d [blink]
L_8cf7f8:
	st_s r2,[r1,0xc]
L_8cf7fa:
	nop_s
