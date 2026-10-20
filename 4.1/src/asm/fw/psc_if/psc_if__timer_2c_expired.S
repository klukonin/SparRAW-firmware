/* psc_if__timer_2c_expired @ 0x8dd958, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   psc_if.cpp
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.psc_if__timer_2c_expired,"ax",@progbits
	.global psc_if__timer_2c_expired
psc_if__timer_2c_expired:
L_8dd958:
	push_s blink
L_8dd95a:
	push_s r13
L_8dd95c:
	mov.f r13,r0
L_8dd960:
	beq_s L_8dd974
	.global L_8dd962
L_8dd962:
	mov_s r0,0x0
L_8dd964:
	st_s r0,[r13,0x2c]
L_8dd966:
	ldb r0,[r13, 0x35]
L_8dd96a:
	cmp_s r0,0x3
L_8dd96c:
	mov_s r0,r13
L_8dd96e:
	blt_s L_8dd98c
L_8dd970:
	mov_s r1,0x4
L_8dd972:
	b_s L_8dd98e
	.global L_8dd974
L_8dd974:
	mov_s r0,blink
L_8dd976:
	mov_s r2,0x1002b14
L_8dd97c:
	mov_s r1,0x1421
L_8dd982:
	bl.d L_8c82c0
L_8dd986:
	mov r3,0x125
L_8dd98a:
	b_s L_8dd962
	.global L_8dd98c
L_8dd98c:
	mov_s r1,0x3
	.global L_8dd98e
L_8dd98e:
	mov_s r2,0x0
L_8dd990:
	mov_s r3,r2
L_8dd992:
	bl.d L_8d6a1c
L_8dd996:
	mov_s r4,r2
L_8dd998:
	b L_8c033c
