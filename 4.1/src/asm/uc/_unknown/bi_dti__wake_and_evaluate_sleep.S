/* bi_dti__wake_and_evaluate_sleep @ 0x931308, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__on_dti
 * Зовёт сам: pm__wake_sequence, power_manager__decide_shallow_sleep, ps__notify_awake_peers
 */
	.section .text.bi_dti__wake_and_evaluate_sleep,"ax",@progbits
	.global bi_dti__wake_and_evaluate_sleep
bi_dti__wake_and_evaluate_sleep:
	.global L_931308
L_931308:
	st.a r13,[sp,-0x8]
L_93130c:
	st blink,[sp, 0x4]
L_931310:
	bl.d L_925184
L_931314:
	mov r13,r0
L_931318:
	bl.d L_930098
L_93131c:
	mov r0,r13
L_931320:
	mov r0,0x801ed0
L_931328:
	bl L_92ad98
L_93132c:
	ld blink,[sp, 0x4]
L_931330:
	j.d [blink]
L_931334:
	ld.ab r13,[sp,0x8]
