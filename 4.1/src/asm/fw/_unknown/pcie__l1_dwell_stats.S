/* pcie__l1_dwell_stats @ 0x8ce044, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 * Зовут его: stats_timer_exp
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log__emit1, hwd_pcie__is_l1_state, hwd_pcie_l1_pm_sub_ctl_get, pcie__dbi_write_seq
 */
	.section .text.pcie__l1_dwell_stats,"ax",@progbits
	.global pcie__l1_dwell_stats
pcie__l1_dwell_stats:
	.global L_8ce044
L_8ce044:
	push_s blink
L_8ce046:
	bl L_8c02b4
L_8ce04a:
	sub_s sp,sp,0x4
L_8ce04c:
	mov_s r15,r0
L_8ce04e:
	mov_s r16,r1
L_8ce050:
	mov_s r17,r2
L_8ce052:
	mov_s r14,0x882500
L_8ce058:
	ld_s r0,[r14,0x54]
L_8ce05a:
	mov_s r18,r3
L_8ce05c:
	bset_s r0,r0,0x3
L_8ce05e:
	st_s r0,[r14,0x54]
L_8ce060:
	mov_s r2,0x1e8480
	.global L_8ce066
L_8ce066:
	/* bl.d 0x008ce310 */
	.byte 0xae,0x0a,0x20,0x00
L_8ce06a:
	/* _sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8ce06c:
	brne_s r0,0,L_8ce070
L_8ce06e:
	brne_s r2,0,L_8ce066
	.global L_8ce070
L_8ce070:
	brne_s r0,0,L_8ce082
L_8ce072:
	mov_s r3,blink
L_8ce074:
	mov_s r2,0x1018a44
L_8ce07a:
	mov_s r0,0x0
L_8ce07c:
	bl.d L_8edfcc
L_8ce080:
	mov_s r1,r0
	.global L_8ce082
L_8ce082:
	mov_s r13,sp
L_8ce084:
	bl.d L_8ce958
L_8ce088:
	mov_s r0,r13
L_8ce08a:
	bmsk_s r15,r15,0x0
L_8ce08c:
	asl_s r2,r15,0x3
L_8ce08e:
	ld_s r1,[sp,0x0]
L_8ce090:
	bmsk r0,r16,0x0
L_8ce094:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_8ce096:
	bic r1,r1,0xc
L_8ce09a:
	bclr_s r2,r2,0x2
L_8ce09c:
	or_s r1,r1,r2
L_8ce09e:
	or_s r0,r0,r1
L_8ce0a0:
	bmsk r1,r17,0x0
L_8ce0a4:
	asl_s r2,r1
L_8ce0a6:
	bmsk r1,r18,0x0
L_8ce0aa:
	bic r0,r0,0x3
L_8ce0ae:
	bclr_s r2,r2,0x0
L_8ce0b0:
	or_s r0,r0,r2
L_8ce0b2:
	or_s r0,r0,r1
L_8ce0b4:
	st_s r0,[sp,0x0]
L_8ce0b6:
	bl.d L_8ce98c
L_8ce0ba:
	mov_s r0,r13
L_8ce0bc:
	ld_s r0,[r14,0x54]
L_8ce0be:
	bclr_s r0,r0,0x3
L_8ce0c0:
	st_s r0,[r14,0x54]
L_8ce0c2:
	b.d L_8c0314
L_8ce0c6:
	add_s sp,sp,0x4
