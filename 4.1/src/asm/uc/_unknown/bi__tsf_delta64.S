/* bi__tsf_delta64 @ 0x924544, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_timing_snapshot_b, bi_window_timing_update
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, uc_read_tsf64
 */
	.section .text.bi__tsf_delta64,"ax",@progbits
	.global bi__tsf_delta64
bi__tsf_delta64:
	.global L_924544
L_924544:
	push_s blink
L_924546:
	bl L_920214
L_92454a:
	sub_s sp,sp,0x8
L_92454c:
	mov_s r14,r0
L_92454e:
	mov_s r13,r1
L_924550:
	bl.d L_930cb0
L_924554:
	mov_s r0,sp
L_924556:
	ld_s r0,[sp,0x0]
L_924558:
	ld_s r1,[sp,0x4]
L_92455a:
	sub.f r0,r0,r14
L_92455e:
	sbc r1,r1,r13
L_924562:
	b.d L_920284
L_924566:
	add_s sp,sp,0x8
