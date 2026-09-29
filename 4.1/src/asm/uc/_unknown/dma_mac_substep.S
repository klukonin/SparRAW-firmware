/* dma_mac_substep @ 0x927dd0, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mac_setup_wrap
 * Зовёт сам: hwd_abif__rgf_88a000, hwd_abif__rgf_88b000, hwd_phy__rgf_883000_9272b8, hwd_phy__rgf_884000, hwd_phy__set_mode_uc, set_reg_886dc8, set_reg_886dc8_926e7c
 */
	.section .text.dma_mac_substep,"ax",@progbits
	.global dma_mac_substep
dma_mac_substep:
	.global L_927dd0
L_927dd0:
	push_s r13
L_927dd2:
	mov_s r6,r0
L_927dd4:
	mov r13,blink
L_927dd8:
	brne.d r6,0x1,L_927e00
L_927ddc:
	mov r0,0x0
L_927de0:
	bl L_9272fc
L_927de4:
	bl.d L_9272b8
L_927de8:
	mov r0,0x0
L_927dec:
	bl L_926e7c
L_927df0:
	bl L_926e64
L_927df4:
	bl.d L_926a10
L_927df8:
	mov r0,0x1
L_927dfc:
	b L_927e64
	.global L_927e00
L_927e00:
	bl L_926a10
L_927e04:
	mov r5,0x88a000
L_927e0c:
	ld.as r2,[r5,0x81]
L_927e10:
	ldb r3,[gp, -0xfe]
L_927e14:
	or r2,r2,0x7e000
L_927e1c:
	st.as r2,[r5,0x81]
L_927e20:
	breq r3,0x0,L_927e30
L_927e24:
	ldb r1,[gp, -0xff]
L_927e28:
	b.d L_927e34
L_927e2c:
	mov r0,0x1
	.global L_927e30
L_927e30:
	mov_s r0,0x0
L_927e32:
	mov_s r1,r0
	.global L_927e34
L_927e34:
	bl L_926a58
L_927e38:
	ldb r4,[gp, -0xfd]
L_927e3c:
	cmp r4,0x0
L_927e40:
	mov r0,0x1
L_927e44:
	mov.eq r0,0x0
L_927e48:
	bl L_927340
L_927e4c:
	bl L_926e7c
L_927e50:
	bl L_926e64
L_927e54:
	bl.d L_9272fc
L_927e58:
	mov r0,0x1
L_927e5c:
	bl.d L_9272b8
L_927e60:
	mov r0,0x1
	.global L_927e64
L_927e64:
	mov_s blink,r13
L_927e66:
	j_s.d [blink]
L_927e68:
	pop_s r13
L_927e6a:
	nop_s
