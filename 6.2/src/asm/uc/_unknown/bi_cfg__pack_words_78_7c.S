/* bi_cfg__pack_words_78_7c @ 0x938004, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_cfg__pack_words_thunk
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bi_cfg__fill_slot_desc
 * Глобалы (через gp): 0x8005a0, 0x8005a4
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi_cfg__pack_words_78_7c
bi_cfg__pack_words_78_7c:
	.global L_938004
L_938004:
	push_s blink
L_938006:
	bl L_920230
L_93800a:
	cmp_s r0,0x0
L_93800c:
	mov_s r1,0x8022a8
L_938012:
	ld_s r2,[r1,0x14]
L_938014:
	mov_s r0,0x80229c
L_93801a:
	lsr_s r15,r2
L_93801c:
	lsr r3,r2,0x2
L_938020:
	bmsk r14,r2,0x0
L_938024:
	lsr_s r2,r2,0x3
L_938026:
	ldb_s r13,[r0,0x3]
L_938028:
	bmsk_s r15,r15,0x0
L_93802a:
	ldb r4,[r1, 0xa]
L_93802e:
	bmsk r7,r3,0x0
L_938032:
	ldb r8,[r1, 0x7]
L_938036:
	bmsk_s r2,r2,0x0
L_938038:
	ldb r5,[r1, 0x9]
L_93803c:
	ldb r6,[r1, 0x4]
L_938040:
	ldb r9,[r1, 0x5]
L_938044:
	asl_s r15,r15
L_938046:
	or_s r14,r14,r15
L_938048:
	/* asl_s r13,r13,0x2 */
	.byte 0x02,0xbd
L_93804a:
	or_s r14,r14,r13
L_93804c:
	asl r13,r4,0x7
L_938050:
	or_s r13,r13,r14
L_938052:
	asl r3,r8,0xa
L_938056:
	or_s r3,r3,r13
L_938058:
	asl r13,r7,0x13
L_93805c:
	or_s r13,r13,r3
L_93805e:
	asl r3,r2,0x14
L_938062:
	or_s r3,r3,r13
L_938064:
	st.as r3,[gp,0x1e]
L_938068:
	asl r3,r6,0x7
L_93806c:
	or r3,r3,r5
L_938070:
	asl r13,r9,0x11
L_938074:
	or_s r3,r3,r13
L_938076:
	asl_s r2,r2,0x17
L_938078:
	or_s r2,r2,r3
L_93807a:
	st.as r2,[gp,0x1f]
L_93807e:
	bl.ne L_92af98
L_938082:
	b L_92029c
L_938086:
	nop_s
