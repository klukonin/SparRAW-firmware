/* bi_ap_mon_if__trigger_aw_to_dti @ 0x9305a4, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bi_ap_mon_if__trigger, bi_window_timing_update
 */
	.section .text.bi_ap_mon_if__trigger_aw_to_dti,"ax",@progbits
	.global bi_ap_mon_if__trigger_aw_to_dti
bi_ap_mon_if__trigger_aw_to_dti:
L_9305a4:
	bl.d L_921ce8
L_9305a8:
	mov r0,0x1
L_9305ac:
	mov_s r0,0x801de8
L_9305b2:
	mov_s r1,0x4
L_9305b4:
	b.d L_93050c
L_9305b8:
	mov r2,0x0
