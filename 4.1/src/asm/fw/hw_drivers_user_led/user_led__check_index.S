/* user_led__check_index @ 0x8d7658, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_user_led.c
 * Зовут его: user_led__set_pattern
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.user_led__check_index,"ax",@progbits
	.global user_led__check_index
user_led__check_index:
	.global L_8d7658
L_8d7658:
	brhs.d r0,0x3,L_8d7662
L_8d765c:
	push_s blink
	.global L_8d765e
L_8d765e:
	pop_s blink
L_8d7660:
	j_s [blink]
	.global L_8d7662
L_8d7662:
	mov_s r0,blink
L_8d7664:
	mov_s r2,0x101849c
L_8d766a:
	mov_s r1,0xb
L_8d766c:
	bset_s r1,r1,0xc
L_8d766e:
	bl.d L_8c82c0
L_8d7672:
	mov_s r3,0xb7
L_8d7674:
	b_s L_8d765e
L_8d7676:
	nop_s
