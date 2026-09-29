/* fsched__time_left_class @ 0x924f48, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_fixed_sched_ap__ev4_state2
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fsched__slot_half4, mac__read_usec_to_tbtt_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global fsched__time_left_class
fsched__time_left_class:
	.global L_924f48
L_924f48:
	push_s blink
L_924f4a:
	bl L_920234
L_924f4e:
	mov_s r14,r0
L_924f50:
	bl.d L_937550
L_924f54:
	mov_s r0,0x0
L_924f56:
	mov_s r13,r0
L_924f58:
	mov_s r1,0x80064c
L_924f5e:
	ldb_s r0,[r1,0x6]
L_924f60:
	brlt r0,0x1,L_924f6a
L_924f64:
	ld_s r0,[r1,0x1c]
L_924f66:
	brhs r13,r0,L_924f82
	.global L_924f6a
L_924f6a:
	st_s r13,[r1,0x1c]
L_924f6c:
	breq_s r14,0,L_924f86
L_924f6e:
	mov_s r0,0x801be8
L_924f74:
	bl L_927d5c
L_924f78:
	brhs r13,r0,L_924f8e
L_924f7c:
	cmp_s r13,0x64
L_924f7e:
	mov_s r0,0x1
L_924f80:
	bhi_s L_924f90
	.global L_924f82
L_924f82:
	mov_s r0,0x2
L_924f84:
	b_s L_924f90
	.global L_924f86
L_924f86:
	brlo r13,0xbb8,L_924f82
	.global L_924f8e
L_924f8e:
	mov_s r0,0x0
	.global L_924f90
L_924f90:
	b L_9202a4
