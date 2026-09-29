/* bi_ap_mon_if__trigger_bti_to_abft @ 0x930548, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__step_once
 */
	.section .text.bi_ap_mon_if__trigger_bti_to_abft,"ax",@progbits
	.global bi_ap_mon_if__trigger_bti_to_abft
bi_ap_mon_if__trigger_bti_to_abft:
L_930548:
	mov_s r0,0x801de8
L_93054e:
	mov_s r1,0x1
L_930550:
	bl.d L_9288f8
L_930554:
	mov r2,0x0
L_930558:
	ld blink,[sp, 0x4]
L_93055c:
	j.d [blink]
L_930560:
	ld.ab r13,[sp,0x8]
