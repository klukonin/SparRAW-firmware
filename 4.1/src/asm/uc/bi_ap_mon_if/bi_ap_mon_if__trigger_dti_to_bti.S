/* bi_ap_mon_if__trigger_dti_to_bti @ 0x9305bc, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   bi_ap_mon_if.cpp
 * Зовут его: bi_ap_mon_if__trigger
 * Зовёт сам: basic_sm__step_once, uc_sysassert
 */
	.section .text.bi_ap_mon_if__trigger_dti_to_bti,"ax",@progbits
	.global bi_ap_mon_if__trigger_dti_to_bti
bi_ap_mon_if__trigger_dti_to_bti:
L_9305bc:
	brne_s r13,0,L_9305fc
L_9305be:
	mov_s r0,0x801de8
L_9305c4:
	mov r1,0x0
L_9305c8:
	bl.d L_9288f8
L_9305cc:
	mov r2,0x1
L_9305d0:
	ld blink,[sp, 0x4]
L_9305d4:
	j.d [blink]
L_9305d8:
	ld.ab r13,[sp,0x8]
	.global L_9305dc
L_9305dc:
	mov_s r0,blink
L_9305de:
	mov_s r2,0x1002770
L_9305e4:
	mov r1,0x5c
L_9305e8:
	bl.d L_925548
L_9305ec:
	mov r3,0x63
L_9305f0:
	ld blink,[sp, 0x4]
L_9305f4:
	j.d [blink]
L_9305f8:
	ld.ab r13,[sp,0x8]
	.global L_9305fc
L_9305fc:
	ld blink,[sp, 0x4]
L_930600:
	j.d [blink]
L_930604:
	ld.ab r13,[sp,0x8]
