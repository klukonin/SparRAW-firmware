/* lm__notify_linkup @ 0x8dae74, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_if__on_linkup_ready, lm_main_sm__linkup_failed, lm_sm__action_8dad54, lm_sm__action_8df614
 * Зовёт сам: conn__linkup_ntf
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global lm__notify_linkup
lm__notify_linkup:
	.global L_8dae74
L_8dae74:
	ld_s r0,[r0,0x4]
L_8dae76:
	cmp_s r1,0x0
L_8dae78:
	mov_s r1,0x0
L_8dae7a:
	mov.ne r1,0x1
L_8dae7e:
	b L_8dae44
L_8dae82:
	nop_s
