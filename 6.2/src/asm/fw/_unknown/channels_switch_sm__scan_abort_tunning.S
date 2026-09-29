/* channels_switch_sm__scan_abort_tunning @ 0x8c209c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   channels_switch_sm::scan_abort_tunning() while tuning!!!
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global channels_switch_sm__scan_abort_tunning
channels_switch_sm__scan_abort_tunning:
	.global L_8c209c
L_8c209c:
	push_s blink
L_8c209e:
	push_s r13
L_8c20a0:
	mov_s r13,r0
L_8c20a2:
	mov_s r1,0x1017524
L_8c20a8:
	bl.d L_8dcba8
L_8c20ac:
	mov_s r0,0x29
L_8c20ae:
	mov_s r1,0x20
L_8c20b0:
	ld_s r0,[r13,0x8]
L_8c20b2:
	b.d L_8c025c
L_8c20b6:
	st_s r1,[r0,0x70]
