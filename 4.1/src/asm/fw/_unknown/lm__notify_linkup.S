/* lm__notify_linkup @ 0x8d7d0c, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lm_if__on_linkup_ready, lm_main_sm__linkup_failed, lm_main_sm__on_bf_results__lm_state_configured, lm_main_sm__on_self_linkup_done
 * Зовёт сам: conn__linkup_ntf
 */
	.section .text.lm__notify_linkup,"ax",@progbits
	.global lm__notify_linkup
lm__notify_linkup:
	.global L_8d7d0c
L_8d7d0c:
	ld_s r0,[r0,0x4]
L_8d7d0e:
	cmp_s r1,0x0
L_8d7d10:
	mov_s r1,0x0
L_8d7d12:
	mov.ne r1,0x1
L_8d7d16:
	b L_8edb8c
L_8d7d1a:
	nop_s
