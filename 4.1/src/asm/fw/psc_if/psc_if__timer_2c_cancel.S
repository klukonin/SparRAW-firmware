/* psc_if__timer_2c_cancel @ 0x8dda70, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   psc_if.cpp
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.psc_if__timer_2c_cancel,"ax",@progbits
	.global psc_if__timer_2c_cancel
psc_if__timer_2c_cancel:
L_8dda70:
	push_s blink
L_8dda72:
	push_s r13
L_8dda74:
	mov.f r13,r0
L_8dda78:
	beq_s L_8dda8e
	.global L_8dda7a
L_8dda7a:
	mov_s r2,0x0
L_8dda7c:
	st_s r2,[r13,0x2c]
L_8dda7e:
	mov_s r0,r13
L_8dda80:
	mov_s r1,0x3
L_8dda82:
	mov_s r3,r2
L_8dda84:
	bl.d L_8d6a1c
L_8dda88:
	mov_s r4,r2
L_8dda8a:
	b L_8c033c
	.global L_8dda8e
L_8dda8e:
	mov_s r0,blink
L_8dda90:
	mov_s r2,0x1002b14
L_8dda96:
	mov_s r1,0x1427
L_8dda9c:
	bl.d L_8c82c0
L_8ddaa0:
	mov r3,0x10f
L_8ddaa4:
	b_s L_8dda7a
L_8ddaa6:
	nop_s
