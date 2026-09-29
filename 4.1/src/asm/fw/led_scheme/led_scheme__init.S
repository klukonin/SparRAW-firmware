/* led_scheme__init @ 0x8d7724, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   led_scheme.cpp
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal, user_led__set_pattern
 * Глобалы (через gp): 0x80039c
 */
	.section .text.led_scheme__init,"ax",@progbits
	.global led_scheme__init
led_scheme__init:
	.global L_8d7724
L_8d7724:
	push_s blink
L_8d7726:
	push_s r13
L_8d7728:
	brhs.d r0,0x4,L_8d7744
L_8d772c:
	mov_s r13,r0
	.global L_8d772e
L_8d772e:
	breq r13,0x3,L_8d7736
L_8d7732:
	st.as r13,[gp,0x8b]
	.global L_8d7736
L_8d7736:
	ld_s r0,[gp,0x22c]
L_8d7738:
	mov_s r1,0x0
L_8d773a:
	bl.d L_8d7694
L_8d773e:
	mov_s r2,0x64
L_8d7740:
	b L_8c033c
	.global L_8d7744
L_8d7744:
	mov_s r0,blink
L_8d7746:
	mov_s r2,0x1016244
L_8d774c:
	mov_s r1,0x1157
L_8d7752:
	bl.d L_8c82c0
L_8d7756:
	mov_s r3,0x29
L_8d7758:
	b_s L_8d772e
L_8d775a:
	nop_s
