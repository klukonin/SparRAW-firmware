/* temp_sense__sample_if_due @ 0x8e25dc, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp_sense__on_system_state
 * Зовёт сам: __ld_r13_ret, fw_read_timer, get_reg_880a3c_8d7540, temp_sense__reschedule_timer
 * Глобалы (через gp): 0x8002b4
 */
	.section .text.temp_sense__sample_if_due,"ax",@progbits
	.global temp_sense__sample_if_due
temp_sense__sample_if_due:
	.global L_8e25dc
L_8e25dc:
	push_s blink
L_8e25de:
	bl.d L_8d7540
L_8e25e2:
	push_s r13
L_8e25e4:
	breq_s r0,0,L_8e261e
L_8e25e6:
	ld_s r0,[gp,0x144]
L_8e25e8:
	brne_s r0,0,L_8e261e
L_8e25ea:
	mov_s r0,0x0
L_8e25ec:
	bl.d L_8e4694
L_8e25f0:
	st.as r0,[gp,-0x9]
L_8e25f4:
	ld.as r13,[gp,-0x1f]
L_8e25f8:
	ld.as r3,[gp,-0x51]
L_8e25fc:
	sub_s r0,r0,r13
L_8e25fe:
	asl_s r1,r0,0x4
L_8e2600:
	cmp r13,-0x1
L_8e2604:
	sub r2,r3,r1
L_8e2608:
	ld_s r0,[gp,-0x140]
L_8e260a:
	beq_s L_8e261a
L_8e260c:
	brhs r1,r3,L_8e261a
L_8e2610:
	brlo r2,0x11,L_8e261a
L_8e2614:
	cmp_s r0,r2
L_8e2616:
	mov.ls r0,r2
	.global L_8e261a
L_8e261a:
	bl L_8dfc98
	.global L_8e261e
L_8e261e:
	b L_8c033c
L_8e2622:
	nop_s
