/* user_led__set_pattern @ 0x8d7694, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_user_led.c
 * Зовут его: led__clear_scheme, led_scheme__apply, led_scheme__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, stub_ret_8d7690, stub_ret_8d7704, user_led__check_index
 * Глобалы (через gp): 0x800390
 */
	.section .text.user_led__set_pattern,"ax",@progbits
	.global user_led__set_pattern
user_led__set_pattern:
	.global L_8d7694
L_8d7694:
	push_s blink
L_8d7696:
	bl L_8c02c0
L_8d769a:
	mov_s r13,r0
L_8d769c:
	ld_s r0,[gp,0x220]
L_8d769e:
	mov_s r14,r1
L_8d76a0:
	mov_s r15,r2
L_8d76a2:
	breq_s r0,0,L_8d76f2
L_8d76a4:
	brhs r13,0x3,L_8d76ca
	.global L_8d76a8
L_8d76a8:
	mov_s r1,0x8017b4
L_8d76ae:
	add2_s r1,r1,r13
L_8d76b0:
	ld_s r0,[r1]
L_8d76b2:
	brne_s r0,0,L_8d76be
L_8d76b4:
	bl.d L_8d7704
L_8d76b8:
	mov_s r0,r13
L_8d76ba:
	mov_s r0,0x1
L_8d76bc:
	st_s r0,[r1]
	.global L_8d76be
L_8d76be:
	brne_s r14,0,L_8d76de
L_8d76c0:
	mov_s r0,r13
L_8d76c2:
	bl.d L_8d7690
L_8d76c6:
	mov_s r1,0x1
L_8d76c8:
	b_s L_8d76f2
	.global L_8d76ca
L_8d76ca:
	mov_s r0,blink
L_8d76cc:
	mov_s r2,0x101849c
L_8d76d2:
	mov_s r1,0x8
L_8d76d4:
	bset_s r1,r1,0xc
L_8d76d6:
	bl.d L_8c82c0
L_8d76da:
	mov_s r3,0x3c
L_8d76dc:
	b_s L_8d76a8
	.global L_8d76de
L_8d76de:
	mov_s r0,r13
L_8d76e0:
	brne_s r15,0,L_8d76ea
L_8d76e2:
	bl.d L_8d7690
L_8d76e6:
	mov_s r1,0x0
L_8d76e8:
	b_s L_8d76f2
	.global L_8d76ea
L_8d76ea:
	mov_s r1,r14
L_8d76ec:
	bl.d L_8d7658
L_8d76f0:
	mov_s r2,r15
	.global L_8d76f2
L_8d76f2:
	b L_8c032c
L_8d76f6:
	nop_s
