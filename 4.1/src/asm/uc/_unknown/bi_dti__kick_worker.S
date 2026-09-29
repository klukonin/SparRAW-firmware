/* bi_dti__kick_worker @ 0x931050, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__enter_dti
 * Зовёт сам: abft_responder_worker, bi_dti__sleep_and_resume, mac_mode_kick
 */
	.section .text.bi_dti__kick_worker,"ax",@progbits
	.global bi_dti__kick_worker
bi_dti__kick_worker:
	.global L_931050
L_931050:
	push_s blink
L_931052:
	mov_s r2,0x801e68
L_931058:
	ldb_s r1,[r2,0x1a]
L_93105a:
	breq_s r1,0,L_931064
L_93105c:
	bl L_92910c
L_931060:
	pop_s blink
L_931062:
	j_s [blink]
	.global L_931064
L_931064:
	ldb_s r1,[r2,0x1b]
L_931066:
	breq_s r1,0,L_931070
L_931068:
	bl L_92c594
L_93106c:
	pop_s blink
L_93106e:
	j_s [blink]
	.global L_931070
L_931070:
	bl L_9216fc
L_931074:
	pop_s blink
L_931076:
	j_s [blink]
