/* ut_hw_drivers__reply_not_supported @ 0x8cdb18, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_HW_DRIVERS_cmd_handler
 * Зовёт сам: wmi_evt__send_command_not_supported
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ut_hw_drivers__reply_not_supported
ut_hw_drivers__reply_not_supported:
	.global L_8cdb18
L_8cdb18:
	ldw_s r3,[r1]
L_8cdb1a:
	mov_s r1,0x9
L_8cdb1c:
	asl_s r1,r1,0x8
L_8cdb1e:
	b.d L_8e5728
L_8cdb22:
	mov r2,0x700
L_8cdb26:
	nop_s
