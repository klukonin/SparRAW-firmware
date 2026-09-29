/* pcie__rearm_l1_timer @ 0x8e91c4, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: isr_pcie_main
 * Зовёт сам: __ld_r13_ret, u_schd__cancel, u_schd__schedule
 * Глобалы (через gp): 0x800434
 */
	.section .text.pcie__rearm_l1_timer,"ax",@progbits
	.global pcie__rearm_l1_timer
pcie__rearm_l1_timer:
	.global L_8e91c4
L_8e91c4:
	push_s blink
L_8e91c6:
	push_s r13
L_8e91c8:
	ld_s r0,[gp,-0x40]
L_8e91ca:
	mov_s r13,0x0
L_8e91cc:
	breq_s r0,0,L_8e91d6
L_8e91ce:
	bl L_8c7794
L_8e91d2:
	st.as r13,[gp,-0x10]
	.global L_8e91d6
L_8e91d6:
	mov_s r0,0x1dc3c
L_8e91dc:
	ld.as r4,[gp,0xb1]
L_8e91e0:
	mov_s r1,0x0
L_8e91e2:
	mov_s r2,r1
L_8e91e4:
	mov_s r3,r1
L_8e91e6:
	mov_s r5,r1
L_8e91e8:
	bl.d L_8dc92c
L_8e91ec:
	mov_s r6,r1
L_8e91ee:
	b.d L_8c033c
L_8e91f2:
	.byte 0xf0,0x1a
