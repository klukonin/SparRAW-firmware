/* phy__program_channel_regs @ 0x8d24fc, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, UT_HW_DRIVERS_cmd_handler, hwm_analog_channel_switch
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global phy__program_channel_regs
phy__program_channel_regs:
	.global L_8d24fc
L_8d24fc:
	brhs r0,0x4,L_8d2564
L_8d2500:
	mov_s r3,0x883000
L_8d2506:
	add r1,pcl,0x18
L_8d250a:
	ldb.x r0,[0x8038e0,r0]
L_8d2512:
	mov_s r2,0x883b00
L_8d2518:
	add1_s r1,r1,r0
L_8d251a:
	j_s [r1]
L_8d251c:
	st 0x64fcace,[r3, 0x20]
L_8d2524:
	st 0x6b000101,[r2, 0x3c]
L_8d252c:
	j_s [blink]
L_8d252e:
	st 0x68ba2e9,[r3, 0x20]
L_8d2536:
	st 0x68000101,[r2, 0x3c]
L_8d253e:
	j_s [blink]
L_8d2540:
	st 0x6c77b03,[r3, 0x20]
L_8d2548:
	st 0x65000101,[r2, 0x3c]
L_8d2550:
	j_s [blink]
L_8d2552:
	st 0x703531e,[r3, 0x20]
L_8d255a:
	st 0x62000101,[r2, 0x3c]
L_8d2562:
	j_s [blink]
	.global L_8d2564
L_8d2564:
	j_s [blink]
L_8d2566:
	nop_s
