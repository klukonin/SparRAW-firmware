/* bi_ap_mon__trigger_tail @ 0x92b2e0, 12 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: bi_ap_mon_if__trigger
 */
	.section .text.bi_ap_mon__trigger_tail,"ax",@progbits
	.global bi_ap_mon__trigger_tail
bi_ap_mon__trigger_tail:
L_92b2e0:
	j_s [r2]
	.global sub_92b2e2
sub_92b2e2:
L_92b2e2:
	mov_s r0,0x1
L_92b2e4:
	b.d L_9304c8
L_92b2e8:
	mov r1,0x0
