/* hwd_phy__rgf_883000_9272b8 @ 0x9272b8, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: dma_mac_substep
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_phy__rgf_883000_9272b8,"ax",@progbits
	.global hwd_phy__rgf_883000_9272b8
hwd_phy__rgf_883000_9272b8:
	.global L_9272b8
L_9272b8:
	st.a r13,[sp,-0x8]
L_9272bc:
	mov_s r13,r0
L_9272be:
	bclr.f r0,r0,0x0
L_9272c2:
	st_s r14,[sp,0x4]
L_9272c4:
	bne.d L_9272e4
L_9272c8:
	mov r14,blink
	.global L_9272cc
L_9272cc:
	mov_s r2,0x883000
L_9272d2:
	ld_s r1,[r2,0x10]
L_9272d4:
	mov_s blink,r14
L_9272d6:
	bclr_s r1,r1,0x0
L_9272d8:
	or_s r13,r13,r1
L_9272da:
	st_s r13,[r2,0x10]
L_9272dc:
	ld_s r14,[sp,0x4]
L_9272de:
	j_s.d [blink]
L_9272e0:
	ld.ab r13,[sp,0x8]
	.global L_9272e4
L_9272e4:
	mov_s r0,blink
L_9272e6:
	mov_s r2,0x1003448
L_9272ec:
	mov r1,0xac
L_9272f0:
	bl.d L_925548
L_9272f4:
	mov r3,0x1c4
L_9272f8:
	b_s L_9272cc
L_9272fa:
	nop_s
