/* bi_dti__sleep_and_resume @ 0x9216fc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_dti__kick_worker
 * Зовёт сам: perform_shallow_sleep, uc_spin_until_event4
 */
	.section .text.bi_dti__sleep_and_resume,"ax",@progbits
	.global bi_dti__sleep_and_resume
bi_dti__sleep_and_resume:
	.global L_9216fc
L_9216fc:
	st.a r13,[sp,-0x8]
L_921700:
	st blink,[sp, 0x4]
L_921704:
	mov_s r13,0x801ed0
L_92170a:
	mov_s r0,r13
L_92170c:
	mov_s r1,0x1
L_92170e:
	mov_s r2,0x0
L_921710:
	mov r3,r2
L_921714:
	bl.d L_92af4c
L_921718:
	mov r4,r2
L_92171c:
	bl.d L_9317f0
L_921720:
	mov r0,0x100
L_921724:
	mov_s r0,r13
L_921726:
	mov_s r1,0x0
L_921728:
	mov_s r2,0x0
L_92172a:
	mov_s r3,r2
L_92172c:
	bl.d L_92af4c
L_921730:
	mov r4,r2
L_921734:
	ld blink,[sp, 0x4]
L_921738:
	j.d [blink]
L_92173c:
	ld.ab r13,[sp,0x8]
