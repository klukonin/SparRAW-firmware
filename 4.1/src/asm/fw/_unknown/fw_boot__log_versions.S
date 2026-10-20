/* fw_boot__log_versions @ 0x8f0ccc, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: bootloader_version__log, fw_version__log, fw_version__log_date, set_reg_880a10
 * Глобалы (через gp): 0x800214
 */
	.section .text.fw_boot__log_versions,"ax",@progbits
	.global fw_boot__log_versions
fw_boot__log_versions:
	.global L_8f0ccc
L_8f0ccc:
	push_s blink
L_8f0cce:
	bl L_8efe50
L_8f0cd2:
	ld_s r0,[gp,-0x10c]
L_8f0cd4:
	ld.as r1,[gp,-0x42]
L_8f0cd8:
	ld.as r2,[gp,-0x41]
L_8f0cdc:
	bl.d L_8ebc58
L_8f0ce0:
	ld.as r3,[gp,-0x44]
L_8f0ce4:
	ldb r4,[gp, 0xa3]
L_8f0ce8:
	ldb r5,[gp, 0xa5]
L_8f0cec:
	ldb_s r0,[gp,0xa4]
L_8f0cee:
	ldb r1,[gp, 0xa2]
L_8f0cf2:
	ldb r2,[gp, 0xa1]
L_8f0cf6:
	bl.d L_8ebc00
L_8f0cfa:
	ldb r3,[gp, 0xa0]
L_8f0cfe:
	bl.d L_8ebbf4
L_8f0d02:
	mov_s r0,0x2
L_8f0d04:
	pop_s blink
L_8f0d06:
	j_s [blink]
