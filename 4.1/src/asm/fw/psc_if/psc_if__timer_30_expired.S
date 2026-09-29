/* psc_if__timer_30_expired @ 0x8dd99c, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   psc_if.cpp
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.psc_if__timer_30_expired,"ax",@progbits
	.global psc_if__timer_30_expired
psc_if__timer_30_expired:
L_8dd99c:
	push_s blink
L_8dd99e:
	push_s r13
L_8dd9a0:
	mov.f r13,r0
L_8dd9a4:
	beq_s L_8dd9b8
	.global L_8dd9a6
L_8dd9a6:
	mov_s r0,0x0
L_8dd9a8:
	st_s r0,[r13,0x30]
L_8dd9aa:
	ldb r0,[r13, 0x35]
L_8dd9ae:
	cmp_s r0,0x3
L_8dd9b0:
	mov_s r0,r13
L_8dd9b2:
	blt_s L_8dd9d0
L_8dd9b4:
	mov_s r1,0x4
L_8dd9b6:
	b_s L_8dd9d2
	.global L_8dd9b8
L_8dd9b8:
	mov_s r0,blink
L_8dd9ba:
	mov_s r2,0x1002b14
L_8dd9c0:
	mov_s r1,0x1425
L_8dd9c6:
	bl.d L_8c82c0
L_8dd9ca:
	mov r3,0x132
L_8dd9ce:
	b_s L_8dd9a6
	.global L_8dd9d0
L_8dd9d0:
	mov_s r1,0x3
	.global L_8dd9d2
L_8dd9d2:
	mov_s r2,0x0
L_8dd9d4:
	mov_s r3,r2
L_8dd9d6:
	bl.d L_8d6a1c
L_8dd9da:
	mov_s r4,r2
L_8dd9dc:
	b L_8c033c
