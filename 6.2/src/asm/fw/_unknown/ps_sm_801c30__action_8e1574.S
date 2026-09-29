/* ps_sm_801c30__action_8e1574 @ 0x8e1574, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps_sm_801c30__action_8e1574
ps_sm_801c30__action_8e1574:
	.global L_8e1574
L_8e1574:
	push_s blink
L_8e1576:
	mov_s r1,r0
L_8e1578:
	mov_s r0,0x21514
L_8e157e:
	ld.as r4,[gp,-0x15]
L_8e1582:
	mov_s r2,0x0
L_8e1584:
	mov_s r3,0x1
L_8e1586:
	mov_s r5,r2
L_8e1588:
	bl.d L_8e0c0c
L_8e158c:
	mov_s r6,r2
L_8e158e:
	st.as r0,[gp,-0x17]
L_8e1592:
	pop_s blink
L_8e1594:
	j_s [blink]
L_8e1596:
	nop_s
