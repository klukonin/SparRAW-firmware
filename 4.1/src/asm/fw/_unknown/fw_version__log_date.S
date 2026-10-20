/* fw_version__log_date @ 0x8ebc00, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FW date = %02d/%02d/%d
 *   FW time = %02d:%02d:%02d
 * Зовут его: fw_boot__log_versions
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit3
 */
	.section .text.fw_version__log_date,"ax",@progbits
	.global fw_version__log_date
fw_version__log_date:
	.global L_8ebc00
L_8ebc00:
	push_s blink
L_8ebc02:
	bl L_8c02b4
L_8ebc06:
	mov_s r18,r0
L_8ebc08:
	mov_s r17,r1
L_8ebc0a:
	mov_s r13,r2
L_8ebc0c:
	mov_s r14,r3
L_8ebc0e:
	mov r16,r4
L_8ebc12:
	mov_s r15,r5
L_8ebc14:
	mov_s r2,0x100169c
L_8ebc1a:
	mov_s r0,0x0
L_8ebc1c:
	bl.d L_8ee034
L_8ebc20:
	mov_s r1,0x2
L_8ebc22:
	mov_s r2,0x10016b4
L_8ebc28:
	mov_s r0,0x0
L_8ebc2a:
	mov_s r1,0x2
L_8ebc2c:
	mov_s r3,r13
L_8ebc2e:
	mov r4,r17
L_8ebc32:
	bl.d L_8ee034
L_8ebc36:
	mov r5,r18
L_8ebc3a:
	mov_s r0,0x880a00
L_8ebc40:
	st_s r13,[r0,0x14]
L_8ebc42:
	st r17,[r0, 0x18]
L_8ebc46:
	st r18,[r0, 0x1c]
L_8ebc4a:
	st_s r14,[r0,0x20]
L_8ebc4c:
	st r16,[r0, 0x24]
L_8ebc50:
	b.d L_8c0314
L_8ebc54:
	st_s r15,[r0,0x28]
L_8ebc56:
	nop_s
