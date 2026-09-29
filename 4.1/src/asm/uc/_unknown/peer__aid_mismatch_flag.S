/* peer__aid_mismatch_flag @ 0x9374d0, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__collect_awake_peers, nav_db__update
 */
	.section .text.peer__aid_mismatch_flag,"ax",@progbits
	.global peer__aid_mismatch_flag
peer__aid_mismatch_flag:
	.global L_9374d0
L_9374d0:
	mov_s r2,r0
L_9374d2:
	ld.as r3,[gp,-0x31]
L_9374d6:
	add1 r4,r0,r0
L_9374da:
	sub.f r2,r2,r3
L_9374de:
	ldb r0,[r4,0x801132]
L_9374e6:
	mov.ne r2,0x1
L_9374ea:
	j_s.d [blink]
L_9374ec:
	st_s r2,[r1]
L_9374ee:
	nop_s
