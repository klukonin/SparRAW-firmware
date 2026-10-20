/* host_if__set_sectors_hal @ 0x8dd64c, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   *** SET SECTORS HAL ***
 *   CID = %d
 *   RX ADDRESS = %d
 *   RX CHIP ID = %d
 *   TX ADDRESS = %d
 *   TX CHIP ID = %d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit0, fw_log_emit1, lmac_if__send_sta_cfg_05_b
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_if__set_sectors_hal
host_if__set_sectors_hal:
	.global L_8dd64c
L_8dd64c:
	push_s blink
L_8dd64e:
	bl.d L_8c01e4
L_8dd652:
	mov_s r0,0x25
L_8dd654:
	mov_s r13,r1
L_8dd656:
	mov_s r1,0x1006214
L_8dd65c:
	bl L_8dcba8
L_8dd660:
	mov_s r1,0x100622c
L_8dd666:
	mov_s r0,0x25
L_8dd668:
	bl.d L_8dcc10
L_8dd66c:
	ld_s r2,[r13]
L_8dd66e:
	ld_s r2,[r13,0x4]
L_8dd670:
	mov_s r1,0x1006238
L_8dd676:
	lsr_s r2,r2,0x4
L_8dd678:
	bmsk_s r2,r2,0xe
L_8dd67a:
	bl.d L_8dcc10
L_8dd67e:
	mov_s r0,0x25
L_8dd680:
	mov_s r1,0x1006248
L_8dd686:
	ld_s r2,[r13,0x4]
L_8dd688:
	mov_s r0,0x25
L_8dd68a:
	bl.d L_8dcc10
L_8dd68e:
	bmsk_s r2,r2,0x3
L_8dd690:
	ld_s r2,[r13,0x8]
L_8dd692:
	mov_s r1,0x1006258
L_8dd698:
	lsr_s r2,r2,0x4
L_8dd69a:
	bmsk_s r2,r2,0xe
L_8dd69c:
	bl.d L_8dcc10
L_8dd6a0:
	mov_s r0,0x25
L_8dd6a2:
	mov_s r1,0x1006268
L_8dd6a8:
	ld_s r2,[r13,0x8]
L_8dd6aa:
	mov_s r0,0x25
L_8dd6ac:
	bl.d L_8dcc10
L_8dd6b0:
	bmsk_s r2,r2,0x3
L_8dd6b2:
	ld_s r2,[r13,0x4]
L_8dd6b4:
	ld_s r14,[r13,0x8]
L_8dd6b6:
	lsr r1,r2,0x4
L_8dd6ba:
	bmsk_s r1,r1,0xe
L_8dd6bc:
	lsr r3,r14,0x4
L_8dd6c0:
	bmsk_s r3,r3,0xe
L_8dd6c2:
	ld_s r0,[r13]
L_8dd6c4:
	bmsk_s r2,r2,0x3
L_8dd6c6:
	bl.d L_8dc380
L_8dd6ca:
	bmsk r4,r14,0x3
L_8dd6ce:
	b L_8c0254
L_8dd6d2:
	nop_s
