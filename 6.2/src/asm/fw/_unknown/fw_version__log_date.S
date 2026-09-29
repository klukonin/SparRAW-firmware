/* fw_version__log_date @ 0x8f33b8, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FW date = %02d/%02d/%d
 *   FW time = %02d:%02d:%02d
 * Зовут его: fw_boot__log_versions
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_version__log_date
fw_version__log_date:
	.global L_8f33b8
L_8f33b8:
	push_s blink
L_8f33ba:
	bl L_8c01d4
L_8f33be:
	mov_s r18,r0
L_8f33c0:
	mov_s r13,r1
L_8f33c2:
	mov_s r15,r2
L_8f33c4:
	mov_s r14,r3
L_8f33c6:
	mov r16,r4
L_8f33ca:
	mov r17,r5
L_8f33ce:
	mov_s r1,0x1001668
L_8f33d4:
	mov_s r0,0x20
L_8f33d6:
	mov_s r2,r3
L_8f33d8:
	mov_s r3,r4
L_8f33da:
	bl.d L_8dcd00
L_8f33de:
	mov r4,r5
L_8f33e2:
	mov_s r1,0x1001680
L_8f33e8:
	mov_s r0,0x20
L_8f33ea:
	mov_s r2,r15
L_8f33ec:
	mov_s r3,r13
L_8f33ee:
	bl.d L_8dcd00
L_8f33f2:
	mov r4,r18
L_8f33f6:
	mov_s r0,0x880a00
L_8f33fc:
	st_s r15,[r0,0x14]
L_8f33fe:
	st_s r13,[r0,0x18]
L_8f3400:
	st r18,[r0, 0x1c]
L_8f3404:
	st_s r14,[r0,0x20]
L_8f3406:
	st r16,[r0, 0x24]
L_8f340a:
	b.d L_8c0234
L_8f340e:
	st r17,[r0, 0x28]
L_8f3412:
	nop_s
