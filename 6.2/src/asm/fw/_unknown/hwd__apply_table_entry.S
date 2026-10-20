/* hwd__apply_table_entry @ 0x8f2e0c, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: fw_sysapi__send_measure_evt
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_lshr64, hwd__apply_table_entry_c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd__apply_table_entry
hwd__apply_table_entry:
	.global L_8f2e0c
L_8f2e0c:
	push_s blink
L_8f2e0e:
	bl L_8c01d8
L_8f2e12:
	mov_s r16,r0
L_8f2e14:
	mov_s r13,r1
L_8f2e16:
	mov_s r14,r2
L_8f2e18:
	mov r17,r4
L_8f2e1c:
	mov_s r15,r5
L_8f2e1e:
	ld r4,[r2]
L_8f2e22:
	ld r5,[r2, 0x4]
L_8f2e26:
	ld_s r2,[r3]
L_8f2e28:
	bl.d L_8f8f60
L_8f2e2c:
	ld_s r3,[r3,0x4]
L_8f2e2e:
	add r1,r13,0x10
L_8f2e32:
	ld r4,[r17]
L_8f2e36:
	mov_s r0,r16
L_8f2e38:
	ld r5,[r17, 0x4]
L_8f2e3c:
	ld_s r2,[r15]
L_8f2e3e:
	bl.d L_8f8f60
L_8f2e42:
	ld_s r3,[r15,0x4]
L_8f2e44:
	ld_s r1,[r15]
L_8f2e46:
	ld r4,[r17]
L_8f2e4a:
	sub.f r2,r4,r1
L_8f2e4e:
	ld r5,[r17, 0x4]
L_8f2e52:
	add r1,r13,0x30
L_8f2e56:
	ld_s r0,[r15,0x4]
L_8f2e58:
	sbc r3,r5,r0
L_8f2e5c:
	bl.d L_8f8f60
L_8f2e60:
	mov_s r0,r16
L_8f2e62:
	ld_s r1,[r14,0x4]
L_8f2e64:
	ld_s r0,[r14]
L_8f2e66:
	bl.d L_8c0430
L_8f2e6a:
	mov_s r2,0x3
L_8f2e6c:
	st_s r0,[r13,0x38]
L_8f2e6e:
	b.d L_8c023c
L_8f2e72:
	st_s r1,[r13,0x3c]
