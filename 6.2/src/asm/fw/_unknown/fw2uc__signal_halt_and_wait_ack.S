/* fw2uc__signal_halt_and_wait_ack @ 0x8db148, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DO_WHILE_WITH_MAX_ITER OCCUR curr_blink=0x%x
 * Зовут его: POWER_MNGR__halt, hwm_analog__prepare_buf
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global fw2uc__signal_halt_and_wait_ack
fw2uc__signal_halt_and_wait_ack:
	.global L_8db148
L_8db148:
	push_s blink
L_8db14a:
	bl.d L_8c01e4
L_8db14e:
	mov_s r1,0x2
L_8db150:
	mov_s r0,0x886d80
L_8db156:
	st_s r1,[r0,0x58]
L_8db158:
	sync
L_8db15c:
	mov r14,0x3e9
	.global L_8db160
L_8db160:
	mov lp_count,0x12c
L_8db164:
	lp L_8db17c
L_8db168:
	mov_s r0,0x886d80
L_8db16e:
	ld_s r13,[r0,0x50]
L_8db170:
	lsr_s r13,r13
L_8db172:
	bxor r13,r13,0x0
L_8db176:
	btst_s r13,0x0
L_8db178:
	bne_s L_8db17c
L_8db17a:
	nop_s
	.global L_8db17c
L_8db17c:
	bbit1 r13,0x0,L_8db18e
L_8db180:
	mov_s r2,blink
L_8db182:
	mov_s r1,0x1004c38
L_8db188:
	bl.d L_8dcc10
L_8db18c:
	mov_s r0,0x0
	.global L_8db18e
L_8db18e:
	bbit1 r13,0x0,L_8db198
L_8db192:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8db194:
	brhs r14,0x1,L_8db160
	.global L_8db198
L_8db198:
	bbit0 r13,0x0,L_8db1a0
	.global L_8db19c
L_8db19c:
	b L_8c0254
	.global L_8db1a0
L_8db1a0:
	mov_s r0,blink
L_8db1a2:
	mov_s r1,0x1316
L_8db1a8:
	bl L_8c9b28
L_8db1ac:
	b_s L_8db19c
L_8db1ae:
	nop_s
