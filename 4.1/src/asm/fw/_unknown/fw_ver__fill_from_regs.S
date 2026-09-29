/* fw_ver__fill_from_regs @ 0x8ebccc, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bootloader_version__log, wmi_handler_fw_ver
 */
	.section .text.fw_ver__fill_from_regs,"ax",@progbits
	.global fw_ver__fill_from_regs
fw_ver__fill_from_regs:
	.global L_8ebccc
L_8ebccc:
	push_s r13
L_8ebcce:
	breq_s r3,0,L_8ebcda
L_8ebcd0:
	mov_s r13,0x880a00
L_8ebcd6:
	ld_s r13,[r13,0x38]
L_8ebcd8:
	stw_s r13,[r3]
	.global L_8ebcda
L_8ebcda:
	breq_s r2,0,L_8ebce6
L_8ebcdc:
	mov_s r3,0x880a00
L_8ebce2:
	ld_s r3,[r3,0x34]
L_8ebce4:
	stw_s r3,[r2]
	.global L_8ebce6
L_8ebce6:
	breq_s r1,0,L_8ebcf2
L_8ebce8:
	mov_s r2,0x880a00
L_8ebcee:
	ld_s r2,[r2,0x30]
L_8ebcf0:
	stb_s r2,[r1]
	.global L_8ebcf2
L_8ebcf2:
	breq_s r0,0,L_8ebcfe
L_8ebcf4:
	mov_s r1,0x880a00
L_8ebcfa:
	ld_s r1,[r1,0x2c]
L_8ebcfc:
	stb_s r1,[r0]
	.global L_8ebcfe
L_8ebcfe:
	j_s.d [blink]
L_8ebd00:
	pop_s r13
L_8ebd02:
	nop_s
