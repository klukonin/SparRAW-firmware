/* phy__program_channel_regs @ 0x8cf83c, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: POWER_MNGR__deep_sleep_exit, UT_HW_DRIVERS_cmd_handler, hwm_analog_channel_switch
 */
	.section .text.phy__program_channel_regs,"ax",@progbits
	.global phy__program_channel_regs
phy__program_channel_regs:
	.global L_8cf83c
L_8cf83c:
	brhs r0,0x4,L_8cf8a4
L_8cf840:
	mov_s r3,0x883000
L_8cf846:
	add r1,pcl,0x18
L_8cf84a:
	ldb.x r0,[0x803088,r0]
L_8cf852:
	mov_s r2,0x883b00
L_8cf858:
	add1_s r1,r1,r0
L_8cf85a:
	j_s [r1]
L_8cf85c:
	st 0x64fcace,[r3, 0x20]
L_8cf864:
	st 0x6b000101,[r2, 0x3c]
L_8cf86c:
	j_s [blink]
L_8cf86e:
	st 0x68ba2e9,[r3, 0x20]
L_8cf876:
	st 0x68000101,[r2, 0x3c]
L_8cf87e:
	j_s [blink]
L_8cf880:
	st 0x6c77b03,[r3, 0x20]
L_8cf888:
	st 0x65000101,[r2, 0x3c]
L_8cf890:
	j_s [blink]
L_8cf892:
	st 0x703531e,[r3, 0x20]
L_8cf89a:
	st 0x62000101,[r2, 0x3c]
L_8cf8a2:
	j_s [blink]
	.global L_8cf8a4
L_8cf8a4:
	j_s [blink]
L_8cf8a6:
	nop_s
