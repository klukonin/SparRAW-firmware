/* disconn_sm__init @ 0x8ed188, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_msm__init
 * Зовёт сам: __ld_r13_ret, basic_sm__setup
 * Глобалы (через gp): 0x8001b8
 */
	.section .text.disconn_sm__init,"ax",@progbits
	.global disconn_sm__init
disconn_sm__init:
	.global L_8ed188
L_8ed188:
	push_s blink
L_8ed18a:
	push_s r13
L_8ed18c:
	mov_s r13,r0
L_8ed18e:
	st_s r1,[r0,0x2c]
L_8ed190:
	mov r4,0x8010a0
L_8ed198:
	ld.as r1,[gp,0x12]
L_8ed19c:
	mov_s r2,0x0
L_8ed19e:
	mov_s r3,0x8021f8
L_8ed1a4:
	mov r5,0x8004b4
L_8ed1ac:
	mov r6,0x7
L_8ed1b0:
	bl.d L_8d6478
L_8ed1b4:
	mov r7,0x2
L_8ed1b8:
	mov_s r0,0x1
L_8ed1ba:
	b.d L_8c033c
L_8ed1be:
	st_s r0,[r13,0x28]
