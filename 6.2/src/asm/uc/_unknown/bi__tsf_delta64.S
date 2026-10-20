/* bi__tsf_delta64 @ 0x924818, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_timing_snapshot_b, l1__snapshot_bi_counter, l1_fixed_sched_ap__ev4_state4, l1_task__entry, mac_prog__cmd02_body
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac__read_tsf64_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi__tsf_delta64
bi__tsf_delta64:
	.global L_924818
L_924818:
	push_s blink
L_92481a:
	bl L_920234
L_92481e:
	sub_s sp,sp,0x8
L_924820:
	mov_s r14,r0
L_924822:
	mov_s r13,r1
L_924824:
	bl.d L_9356cc
L_924828:
	mov_s r0,sp
L_92482a:
	ld_s r0,[sp,0x0]
L_92482c:
	ld_s r1,[sp,0x4]
L_92482e:
	sub.f r0,r0,r14
L_924832:
	sbc r1,r1,r13
L_924836:
	b.d L_9202a4
L_92483a:
	add_s sp,sp,0x8
