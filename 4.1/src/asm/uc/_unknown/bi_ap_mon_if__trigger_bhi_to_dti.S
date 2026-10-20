/* bi_ap_mon_if__trigger_bhi_to_dti @ 0x930524, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: basic_sm__dispatch_loop, bi_window_transition_prep
 */
	.section .text.bi_ap_mon_if__trigger_bhi_to_dti,"ax",@progbits
	.global bi_ap_mon_if__trigger_bhi_to_dti
bi_ap_mon_if__trigger_bhi_to_dti:
L_930524:
	mov_s r0,0x801de8
L_93052a:
	mov_s r1,0x2
L_93052c:
	mov_s r2,0x0
L_93052e:
	mov_s r3,0x0
L_930530:
	bl.d L_9287ec
L_930534:
	mov r4,0x0
L_930538:
	bl L_9370b8
L_93053c:
	ld blink,[sp, 0x4]
L_930540:
	j.d [blink]
L_930544:
	ld.ab r13,[sp,0x8]
