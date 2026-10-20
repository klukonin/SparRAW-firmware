/* rx_chain__configure_b @ 0x8c4508, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: rx_macq__setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, macq_desc__write, rx_chain__build_desc_b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_chain__configure_b
rx_chain__configure_b:
	.global L_8c4508
L_8c4508:
	push_s blink
L_8c450a:
	bl.d L_8c01e4
L_8c450e:
	mov_s r2,r1
L_8c4510:
	mov_s r14,r0
L_8c4512:
	mov_s r13,0x847fe8
L_8c4518:
	mov_s r0,r13
L_8c451a:
	bl.d L_8e41a8
L_8c451e:
	ldb_s r1,[r14,0x1]
L_8c4520:
	mov_s r0,r13
L_8c4522:
	ldb_s r1,[r14]
L_8c4524:
	mov_s r2,0x1
L_8c4526:
	mov_s r3,0x3
L_8c4528:
	mov r4,0x0
L_8c452c:
	mov r5,r4
L_8c4530:
	mov r6,r4
L_8c4534:
	bl.d L_8c5010
L_8c4538:
	mov_s r7,r3
L_8c453a:
	b L_8c0254
L_8c453e:
	nop_s
