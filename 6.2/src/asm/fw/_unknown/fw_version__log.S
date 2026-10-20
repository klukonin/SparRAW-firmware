/* fw_version__log @ 0x8f3414, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FW version = %d.%d.%d
 * Зовут его: fw_boot__log_versions
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw_version__log
fw_version__log:
	.global L_8f3414
L_8f3414:
	push_s blink
L_8f3416:
	bl L_8c01dc
L_8f341a:
	mov_s r13,r0
L_8f341c:
	mov_s r14,r1
L_8f341e:
	mov_s r15,r2
L_8f3420:
	mov_s r16,r3
L_8f3422:
	mov_s r1,0x100169c
L_8f3428:
	mov_s r0,0x20
L_8f342a:
	mov_s r2,r13
L_8f342c:
	mov_s r3,r14
L_8f342e:
	bl.d L_8dcd00
L_8f3432:
	mov r4,r16
L_8f3436:
	mov_s r0,0x880a00
L_8f343c:
	st_s r13,[r0,0x2c]
L_8f343e:
	st_s r14,[r0,0x30]
L_8f3440:
	st_s r15,[r0,0x34]
L_8f3442:
	b.d L_8c0244
L_8f3446:
	st r16,[r0, 0x38]
L_8f344a:
	nop_s
