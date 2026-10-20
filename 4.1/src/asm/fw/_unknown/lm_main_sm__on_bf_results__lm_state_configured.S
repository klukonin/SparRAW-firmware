/* lm_main_sm__on_bf_results__lm_state_configured @ 0x8db384, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: lm__notify_linkup
 */
	.section .text.lm_main_sm__on_bf_results__lm_state_configured,"ax",@progbits
	.global lm_main_sm__on_bf_results__lm_state_configured
lm_main_sm__on_bf_results__lm_state_configured:
L_8db384:
	ld_s r1,[r1,0xc]
L_8db386:
	ld_s r0,[r0,0x2c]
L_8db388:
	cmp_s r1,0x1
L_8db38a:
	mov_s r1,0x0
L_8db38c:
	mov.ne r1,0x1
L_8db390:
	b L_8d7d0c
