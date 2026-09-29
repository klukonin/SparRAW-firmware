/* WBE_DRIVER__link_up_notif @ 0x8edb14, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wbe_driver.cpp
 *   WBE_DRIVER::link_up_notif: DEV2_LINK_UP : 0x%x
 *   WBE_DRIVER::link_up_notif: DEV3_LINK_UP :0x%x
 *   WBE_DRIVER::link_up_notif: COPY_SHADOW_DONE 0x%x
 * Зовут его: isr_pcie_main
 * Зовёт сам: fw_log__emit1, fw_sysassert_fatal, u_schd__add
 */
	.section .text.WBE_DRIVER__link_up_notif,"ax",@progbits
	.global WBE_DRIVER__link_up_notif
WBE_DRIVER__link_up_notif:
	.global L_8edb14
L_8edb14:
	push_s blink
L_8edb16:
	ldb r1,[gp, 0xcc]
L_8edb1a:
	bset r1,r1,r0
L_8edb1e:
	extb_s r3,r1
L_8edb20:
	stb r1,[gp, 0xcc]
L_8edb24:
	breq_s r0,0,L_8edb44
L_8edb26:
	breq r0,0x1,L_8edb4c
L_8edb2a:
	breq r0,0x2,L_8edb84
L_8edb2e:
	mov_s r0,blink
L_8edb30:
	mov_s r2,0x10032e4
L_8edb36:
	mov_s r1,0x6b
L_8edb38:
	bset_s r1,r1,0xc
L_8edb3a:
	bl.d L_8c82c0
L_8edb3e:
	mov r3,0x515
L_8edb42:
	b_s L_8edb5a
	.global L_8edb44
L_8edb44:
	mov_s r2,0x1003a48
L_8edb4a:
	b_s L_8edb52
	.global L_8edb4c
L_8edb4c:
	mov_s r2,0x1003a78
	.global L_8edb52
L_8edb52:
	mov_s r0,0xf
L_8edb54:
	bl.d L_8edfcc
L_8edb58:
	mov_s r1,0x2
	.global L_8edb5a
L_8edb5a:
	ldb r3,[gp, 0xcc]
L_8edb5e:
	brne r3,0x7,L_8edb80
L_8edb62:
	mov_s r2,0x1003aa8
L_8edb68:
	mov_s r0,0xf
L_8edb6a:
	bl.d L_8edfcc
L_8edb6e:
	mov_s r1,0x2
L_8edb70:
	mov_s r0,0x2dad4
L_8edb76:
	mov_s r1,0x0
L_8edb78:
	mov_s r2,r1
L_8edb7a:
	bl.d L_8c2ac8
L_8edb7e:
	mov_s r3,0x2
	.global L_8edb80
L_8edb80:
	pop_s blink
L_8edb82:
	j_s [blink]
	.global L_8edb84
L_8edb84:
	mov_s r2,0x1003aa8
L_8edb8a:
	b_s L_8edb52
