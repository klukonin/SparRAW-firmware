/* scan_mngr__config_dwell_time @ 0x8ea5a4, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::config_dwell_time() pf_mode_en
 *   scan_mngr::config_dwell_time() Configuring dwell time according to special configuration
 *   scan_mngr::config_dwell_time() Configuring dwell time for default scan (120ms)
 *   scan_mngr::config_dwell_time() Configuring dwell time for long scan (500ms)
 *   scan_mngr::config_dwell_time() Configuring dwell time for short scan (180ms)
 * Зовут его: scan_mngr__start_scan
 * Зовёт сам: __ld_r13_ret, fw_log__emit0
 */
	.section .text.scan_mngr__config_dwell_time,"ax",@progbits
	.global scan_mngr__config_dwell_time
scan_mngr__config_dwell_time:
	.global L_8ea5a4
L_8ea5a4:
	push_s blink
L_8ea5a6:
	push_s r13
L_8ea5a8:
	mov_s r13,r0
L_8ea5aa:
	mov_s r2,0x80345c
L_8ea5b0:
	ld_s r0,[r2,0xc]
L_8ea5b2:
	breq_s r0,0,L_8ea5ce
L_8ea5b4:
	mov_s r2,0x1012a44
L_8ea5ba:
	mov_s r0,0x9
L_8ea5bc:
	bl.d L_8edfb0
L_8ea5c0:
	mov_s r1,0x2
L_8ea5c2:
	mov_s r0,0x8004cc
L_8ea5c8:
	ld_s r0,[r0]
L_8ea5ca:
	st_s r0,[r13,0x70]
L_8ea5cc:
	b_s L_8ea62e
	.global L_8ea5ce
L_8ea5ce:
	ld_s r0,[r2,0x18]
L_8ea5d0:
	bbit0 r0,0x7,L_8ea5ec
L_8ea5d4:
	mov_s r2,0x1012a70
	.global L_8ea5da
L_8ea5da:
	mov_s r0,0x9
L_8ea5dc:
	bl.d L_8edfb0
L_8ea5e0:
	mov_s r1,0x2
L_8ea5e2:
	st 0x7a120,[r13, 0x70]
L_8ea5ea:
	b_s L_8ea62e
	.global L_8ea5ec
L_8ea5ec:
	cmp r1,0xb4
L_8ea5f0:
	beq_s L_8ea618
L_8ea5f2:
	cmp r1,0x1f4
L_8ea5f6:
	beq_s L_8ea610
L_8ea5f8:
	mov_s r2,0x1012acc
L_8ea5fe:
	mov_s r0,0x9
L_8ea600:
	bl.d L_8edfb0
L_8ea604:
	mov_s r1,0x2
L_8ea606:
	st 0x1d4c0,[r13, 0x70]
L_8ea60e:
	b_s L_8ea62e
	.global L_8ea610
L_8ea610:
	mov_s r2,0x1012b1c
L_8ea616:
	b_s L_8ea5da
	.global L_8ea618
L_8ea618:
	mov_s r2,0x1012b68
L_8ea61e:
	mov_s r0,0x9
L_8ea620:
	bl.d L_8edfb0
L_8ea624:
	mov_s r1,0x2
L_8ea626:
	st 0x2bf20,[r13, 0x70]
	.global L_8ea62e
L_8ea62e:
	b L_8c033c
L_8ea632:
	nop_s
