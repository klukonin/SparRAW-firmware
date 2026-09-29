/* rate_search__reset_stats @ 0x93003c, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tx_flow_substep
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memset0_words_uc, sched_bitmap__next_set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rate_search__reset_stats
rate_search__reset_stats:
	.global L_93003c
L_93003c:
	push_s blink
L_93003e:
	bl L_920230
L_930042:
	ldb_s r14,[r0]
L_930044:
	mov_s r15,r1
L_930046:
	mul64 r14,0x2c
L_93004a:
	add r13,mlo,0x802670
L_930052:
	add r0,r13,0x24
L_930056:
	bl.d L_920a84
L_93005a:
	mov_s r1,0x8
L_93005c:
	brne r15,0x1,L_930064
L_930060:
	ldb_s r0,[r13,0x1b]
L_930062:
	stb_s r0,[r13,0x1a]
	.global L_930064
L_930064:
	mul64 r14,0x26
L_930068:
	ldb_s r1,[r13,0x1c]
L_93006a:
	add r15,mlo,0x8027d0
L_930072:
	ldw_s r2,[r15,0x24]
L_930074:
	ldw_s r0,[r15,0x22]
L_930076:
	asl_s r2,r2,0x10
L_930078:
	or_s r0,r0,r2
L_93007a:
	norm r0,r0
L_93007e:
	rsub r2,r0,0x1e
L_930082:
	breq r1,r2,L_93008e
L_930086:
	bl.d L_92ff78
L_93008a:
	mov_s r0,r14
L_93008c:
	stb_s r0,[r13,0x1c]
	.global L_93008e
L_93008e:
	ldb_s r2,[r13,0x1a]
L_930090:
	ldw_s r1,[r15,0x24]
L_930092:
	ldw_s r0,[r15,0x22]
L_930094:
	asl_s r1,r1,0x10
L_930096:
	or_s r0,r0,r1
L_930098:
	norm r0,r0
L_93009c:
	rsub r1,r0,0x1e
L_9300a0:
	cmp_s r2,r1
L_9300a2:
	mov_s r0,0x1
L_9300a4:
	b.d L_92029c
L_9300a8:
	sub_s.ne r0,r0,r0
L_9300aa:
	nop_s
