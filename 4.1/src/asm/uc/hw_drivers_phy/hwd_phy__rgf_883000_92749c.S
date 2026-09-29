/* hwd_phy__rgf_883000_92749c @ 0x92749c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: rfc_ctrl__switch
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_phy__rgf_883000_92749c,"ax",@progbits
	.global hwd_phy__rgf_883000_92749c
hwd_phy__rgf_883000_92749c:
	.global L_92749c
L_92749c:
	st.a r13,[sp,-0x8]
L_9274a0:
	mov_s r13,r0
L_9274a2:
	bic.f r0,r0,0x3f
L_9274a6:
	st_s r14,[sp,0x4]
L_9274a8:
	bne.d L_9274cc
L_9274ac:
	mov r14,blink
	.global L_9274b0
L_9274b0:
	mov_s r2,0x883000
L_9274b6:
	ld_s r1,[r2,0x6c]
L_9274b8:
	mov_s blink,r14
L_9274ba:
	bic r1,r1,0x3f
L_9274be:
	or_s r1,r1,r13
L_9274c0:
	st_s r1,[r2,0x6c]
L_9274c2:
	ld_s r14,[sp,0x4]
L_9274c4:
	j.d [blink]
L_9274c8:
	ld.ab r13,[sp,0x8]
	.global L_9274cc
L_9274cc:
	mov_s r0,blink
L_9274ce:
	mov_s r2,0x1003448
L_9274d4:
	mov r1,0xac
L_9274d8:
	bl.d L_925548
L_9274dc:
	mov r3,0x60b
L_9274e0:
	b_s L_9274b0
L_9274e2:
	nop_s
