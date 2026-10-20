/* mem_8571dc__or_bit @ 0x9224a8, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bf_sm__clear_pending
 * Глобалы (через gp): 0x800574
 */
	.section .text.mem_8571dc__or_bit,"ax",@progbits
	.global mem_8571dc__or_bit
mem_8571dc__or_bit:
	.global L_9224a8
L_9224a8:
	mov_s r2,0x0
L_9224aa:
	ld.as r1,[gp,0x13]
L_9224ae:
	bset r2,r2,r0
L_9224b2:
	and_s r1,r1,r2
L_9224b4:
	mov_s r2,0x857180
L_9224ba:
	ld_s r0,[r2,0x5c]
L_9224bc:
	or_s r0,r0,r1
L_9224be:
	j_s.d [blink]
L_9224c0:
	st_s r0,[r2,0x5c]
L_9224c2:
	nop_s
