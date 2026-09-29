/* ut_hw_drivers_cmd_0x40c @ 0x8d003c, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 */
	.section .text.ut_hw_drivers_cmd_0x40c,"ax",@progbits
	.global ut_hw_drivers_cmd_0x40c
ut_hw_drivers_cmd_0x40c:
	.global L_8d003c
L_8d003c:
	mov_s r1,0x884000
L_8d0042:
	ld_s r0,[r1,0x8]
L_8d0044:
	bclr_s r0,r0,0x0
L_8d0046:
	st_s r0,[r1,0x8]
L_8d0048:
	mov_s r1,0x880180
L_8d004e:
	ld_s r0,[r1,0x60]
L_8d0050:
	bic r0,r0,0x1c0
L_8d0054:
	st_s r0,[r1,0x60]
L_8d0056:
	mov_s r1,0x884100
L_8d005c:
	ld_s r0,[r1,0x40]
L_8d005e:
	bclr_s r0,r0,0x0
L_8d0060:
	st_s r0,[r1,0x40]
L_8d0062:
	ld_s r0,[r1,0x48]
L_8d0064:
	mov_s r0,0x1
L_8d0066:
	st_s r0,[r1,0x48]
L_8d0068:
	j_s [blink]
L_8d006a:
	nop_s
