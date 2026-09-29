/* fw_version__log @ 0x8ebc58, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FW version = %d.%d.%d
 * Зовут его: fw_boot__log_versions
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit3
 */
	.section .text.fw_version__log,"ax",@progbits
	.global fw_version__log
fw_version__log:
	.global L_8ebc58
L_8ebc58:
	push_s blink
L_8ebc5a:
	bl L_8c02bc
L_8ebc5e:
	mov_s r13,r0
L_8ebc60:
	mov_s r16,r1
L_8ebc62:
	mov_s r14,r2
L_8ebc64:
	mov_s r15,r3
L_8ebc66:
	mov_s r2,0x10016d0
L_8ebc6c:
	mov_s r0,0x0
L_8ebc6e:
	mov_s r1,0x2
L_8ebc70:
	mov_s r3,r13
L_8ebc72:
	mov r4,r16
L_8ebc76:
	bl.d L_8ee034
L_8ebc7a:
	mov_s r5,r15
L_8ebc7c:
	mov_s r0,0x880a00
L_8ebc82:
	st_s r13,[r0,0x2c]
L_8ebc84:
	st r16,[r0, 0x30]
L_8ebc88:
	st_s r14,[r0,0x34]
L_8ebc8a:
	b.d L_8c0324
L_8ebc8e:
	st_s r15,[r0,0x38]
