/* hwd_rfc_read_rgf @ 0x8d04fc, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_read_rgf: read failed. Calling hwd_abif_rfc_divider_restart
 *   hwd_rfc_read_rgf: RF read failed in all %d trials. Returning invalid res_val=0x%8x
 * Зовут его: UT_HW_DRIVERS_cmd_handler, hwd_rfc__read_sector_chain, hwd_rfc__read_sector_reg, hwd_rfc__read_xpm_with_delay, hwd_rfc_sector_dist_gain_set, hwd_rfc_sector_edge_gain_set, hwd_rfc_sector_edge_phase_set, hwd_rfc_sector_x16_state_set, hwd_rfc_xpm_get_data_output, rfc__read_field_484
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit0, fw_log__emit2, hwd_abif_rfc_divider_restart, hwd_rfc_write_core
 */
	.section .text.hwd_rfc_read_rgf,"ax",@progbits
	.global hwd_rfc_read_rgf
hwd_rfc_read_rgf:
	.global L_8d04fc
L_8d04fc:
	push_s blink
L_8d04fe:
	bl L_8c02bc
L_8d0502:
	mov_s r16,r1
L_8d0504:
	mov_s r15,0xdeadbeef
L_8d050a:
	mov_s r14,0x0
L_8d050c:
	b_s L_8d0524
	.global L_8d050e
L_8d050e:
	mov_s r2,0x1019060
L_8d0514:
	mov_s r0,0x0
L_8d0516:
	bl.d L_8edfb0
L_8d051a:
	mov_s r1,0x1
L_8d051c:
	bl.d L_8cbce8
L_8d0520:
	mov_s r0,0x1
L_8d0522:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
	.global L_8d0524
L_8d0524:
	brge r14,0x5,L_8d0558
L_8d0528:
	mov_s r1,0x889100
L_8d052e:
	ld_s r0,[r1,0x18]
L_8d0530:
	mov_s r13,0x889000
L_8d0536:
	bset_s r0,r0,0x6
L_8d0538:
	st_s r0,[r1,0x18]
L_8d053a:
	ld_s r0,[r1,0x18]
L_8d053c:
	mov_s r2,r16
L_8d053e:
	bclr_s r0,r0,0x6
L_8d0540:
	st_s r0,[r1,0x18]
L_8d0542:
	mov_s r0,0x0
L_8d0544:
	mov_s r1,0x4
L_8d0546:
	bl.d L_8d0f80
L_8d054a:
	mov_s r3,r0
L_8d054c:
	ld.as r0,[r13,0xfb]
L_8d0550:
	brne r0,0x1,L_8d050e
L_8d0554:
	ld r15,[r13, 0xd8]
	.global L_8d0558
L_8d0558:
	brne r15,0xdeadbeef,L_8d0578
L_8d0560:
	mov_s r2,0x10190a4
L_8d0566:
	mov_s r0,0x0
L_8d0568:
	mov_s r1,r0
L_8d056a:
	mov r4,0xdeadbeef
L_8d0572:
	bl.d L_8edff8
L_8d0576:
	mov_s r3,0x5
	.global L_8d0578
L_8d0578:
	b.d L_8c0324
L_8d057c:
	mov_s r0,r15
L_8d057e:
	nop_s
