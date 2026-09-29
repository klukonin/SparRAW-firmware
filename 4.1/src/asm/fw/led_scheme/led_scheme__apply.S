/* led_scheme__apply @ 0x8d775c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   led_scheme.cpp
 * Зовут его: WBE_DRIVER__pcie_boot_init, fw_sysassert_fatal, led__update_by_link_rate, link_stats_sm__on_stop, link_stats_sm__started, lmac_if__lmac_ready_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal, u_schd__cancel, u_schd__schedule, user_led__set_pattern
 * Глобалы (через gp): 0x80039c
 */
	.section .text.led_scheme__apply,"ax",@progbits
	.global led_scheme__apply
led_scheme__apply:
	.global L_8d775c
L_8d775c:
	push_s blink
L_8d775e:
	bl L_8c02c0
L_8d7762:
	brhs.d r0,0x7,L_8d77ba
L_8d7766:
	mov_s r14,r0
	.global L_8d7768
L_8d7768:
	mov_s r13,0x8004d4
L_8d776e:
	ld_s r0,[r13]
L_8d7770:
	breq_s r0,0,L_8d777a
L_8d7772:
	bl L_8c7794
L_8d7776:
	mov_s r0,0x0
L_8d7778:
	st_s r0,[r13]
	.global L_8d777a
L_8d777a:
	add_s r14,r14,r14
L_8d777c:
	add1_s r14,r14,r14
L_8d777e:
	add r0,r14,0x80345c
L_8d7786:
	ldw_s r1,[r0,0x24]
L_8d7788:
	ldw_s r14,[r0,0x20]
L_8d778a:
	ldw_s r15,[r0,0x22]
L_8d778c:
	breq_s r1,0,L_8d77ac
L_8d778e:
	mulu64 r1,0x3e8
L_8d7792:
	mov_s r1,0x0
L_8d7794:
	mov_s r0,0x177d0
L_8d779a:
	mov_s r2,r1
L_8d779c:
	mov r4,mlo
L_8d77a0:
	mov_s r3,r1
L_8d77a2:
	mov_s r5,r1
L_8d77a4:
	bl.d L_8dc92c
L_8d77a8:
	mov_s r6,r1
L_8d77aa:
	st_s r0,[r13]
	.global L_8d77ac
L_8d77ac:
	ld_s r0,[gp,0x22c]
L_8d77ae:
	mov_s r1,r14
L_8d77b0:
	bl.d L_8d7694
L_8d77b4:
	mov_s r2,r15
L_8d77b6:
	b L_8c032c
	.global L_8d77ba
L_8d77ba:
	mov_s r0,blink
L_8d77bc:
	mov_s r2,0x1016244
L_8d77c2:
	mov_s r1,0x1158
L_8d77c8:
	bl.d L_8c82c0
L_8d77cc:
	mov_s r3,0x4b
L_8d77ce:
	b_s L_8d7768
