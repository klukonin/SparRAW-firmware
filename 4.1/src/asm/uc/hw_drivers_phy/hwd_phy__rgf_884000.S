/* hwd_phy__rgf_884000 @ 0x9272fc, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_phy.c
 * Зовут его: dma_mac_substep
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_phy__rgf_884000,"ax",@progbits
	.global hwd_phy__rgf_884000
hwd_phy__rgf_884000:
	.global L_9272fc
L_9272fc:
	st.a r13,[sp,-0x8]
L_927300:
	mov_s r13,r0
L_927302:
	bclr.f r0,r0,0x0
L_927306:
	st_s r14,[sp,0x4]
L_927308:
	bne.d L_927328
L_92730c:
	mov r14,blink
	.global L_927310
L_927310:
	mov_s r2,0x884000
L_927316:
	ld_s r1,[r2,0x8]
L_927318:
	mov_s blink,r14
L_92731a:
	bclr_s r1,r1,0x0
L_92731c:
	or_s r13,r13,r1
L_92731e:
	st_s r13,[r2,0x8]
L_927320:
	ld_s r14,[sp,0x4]
L_927322:
	j_s.d [blink]
L_927324:
	ld.ab r13,[sp,0x8]
	.global L_927328
L_927328:
	mov_s r0,blink
L_92732a:
	mov_s r2,0x1003448
L_927330:
	mov r1,0xac
L_927334:
	bl.d L_925548
L_927338:
	mov r3,0xe3
L_92733c:
	b_s L_927310
L_92733e:
	nop_s
