/* rx_pool__init @ 0x8d626c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__init
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mem_pool__init, memset0_words, rx_macq__init, rx_pool__configure_ring
 */
	.section .text.rx_pool__init,"ax",@progbits
	.global rx_pool__init
rx_pool__init:
	.global L_8d626c
L_8d626c:
	push_s blink
L_8d626e:
	bl L_8c02c4
L_8d6272:
	mov_s r13,0x84af54
L_8d6278:
	mov_s r1,0x3ea0
L_8d627e:
	bl.d L_8c1a78
L_8d6282:
	mov_s r0,r13
L_8d6284:
	mov_s r14,0x8062c4
L_8d628a:
	add r0,r14,0x1c
L_8d628e:
	mov_s r1,r13
L_8d6290:
	mov r2,0x538
L_8d6294:
	bl.d L_8c6c70
L_8d6298:
	mov_s r3,0xc
L_8d629a:
	bl L_8d6754
L_8d629e:
	mov_s r13,0x843800
L_8d62a4:
	mov_s r0,r13
L_8d62a6:
	bl.d L_8c1a78
L_8d62aa:
	mov r1,0x100
L_8d62ae:
	mov_s r0,r14
L_8d62b0:
	mov_s r1,r13
L_8d62b2:
	mov_s r2,0x8
L_8d62b4:
	bl.d L_8d5dbc
L_8d62b8:
	mov_s r3,0x4
L_8d62ba:
	b L_8c0334
L_8d62be:
	nop_s
