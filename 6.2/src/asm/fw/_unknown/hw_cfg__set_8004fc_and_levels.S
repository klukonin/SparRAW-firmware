/* hw_cfg__set_8004fc_and_levels @ 0x8ce060, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r13_to_r13_ret, sdp__set_level_and_init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_cfg__set_8004fc_and_levels
hw_cfg__set_8004fc_and_levels:
	.global L_8ce060
L_8ce060:
	push_s blink
L_8ce062:
	push_s r13
L_8ce064:
	mov_s r13,r2
L_8ce066:
	mov_s r2,0x8004f8
L_8ce06c:
	stb_s r0,[r2,0x4]
L_8ce06e:
	/* add_s r1,0x5 */
	.byte 0x05,0xe1
L_8ce070:
	extb_s r1,r1
L_8ce072:
	bl.d L_8f8510
L_8ce076:
	mov_s r0,0x7
L_8ce078:
	add_s r1,r13,0x5
L_8ce07a:
	extb_s r1,r1
L_8ce07c:
	bl.d L_8f8510
L_8ce080:
	mov_s r0,0x8
L_8ce082:
	b L_8c025c
L_8ce086:
	nop_s
