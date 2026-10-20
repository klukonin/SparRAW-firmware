/* calib_lo_leakage_substep @ 0x8dc5bc, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_leakage__sweep
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, abif__get_rx_table_index_force_val, hwd_abif__rx_table_config_vga_dc, hwd_abif__rx_table_index_force_mode, hwd_phy__rx_agc_steps_disable, hwd_phy__rx_enable, hwd_phy__rx_ina_det_mode, phy__get_ina_rssi_adc_db
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_lo_leakage_substep
calib_lo_leakage_substep:
	.global L_8dc5bc
L_8dc5bc:
	push_s blink
L_8dc5be:
	bl L_8c01d8
L_8dc5c2:
	bl.d L_8cf5ec
L_8dc5c6:
	mov_s r15,r1
L_8dc5c8:
	mov_s r16,r0
L_8dc5ca:
	bl.d L_8d2260
L_8dc5ce:
	mov_s r0,0x1
L_8dc5d0:
	bl.d L_8d2630
L_8dc5d4:
	mov_s r0,0x0
L_8dc5d6:
	bl.d L_8d219c
L_8dc5da:
	mov_s r0,0x0
L_8dc5dc:
	bl.d L_8d219c
L_8dc5e0:
	mov_s r0,0x1
L_8dc5e2:
	mov_s r0,0x32
L_8dc5e4:
	mov lp_count,r0
L_8dc5e8:
	nop_s
L_8dc5ea:
	lp L_8dc5f2
L_8dc5ee:
	nop_s
L_8dc5f0:
	nop_s
	.global L_8dc5f2
L_8dc5f2:
	bl.d L_8d2648
L_8dc5f6:
	mov_s r13,0x4
L_8dc5f8:
	sub_s r0,r0,0x14
L_8dc5fa:
	add_s r0,r0,r16
L_8dc5fc:
	cmp_s r0,0xa
L_8dc5fe:
	mov r4,0xa
L_8dc602:
	mov.hi r4,r0
L_8dc606:
	extb r4,r4
L_8dc60a:
	min r4,r4,0x3f
L_8dc60e:
	extb r17,r4
L_8dc612:
	mov_s r0,0x0
L_8dc614:
	bl.d L_8cf5a8
L_8dc618:
	mov_s r1,r0
L_8dc61a:
	mov_s r0,0x1
L_8dc61c:
	bl.d L_8cf5a8
L_8dc620:
	mov_s r1,r17
L_8dc622:
	bl.d L_8d2260
L_8dc626:
	mov_s r0,0x0
L_8dc628:
	bl.d L_8d219c
L_8dc62c:
	mov_s r0,0x0
L_8dc62e:
	mov_s r14,0x1
	.global L_8dc630
L_8dc630:
	sub_s r0,r15,0x1
L_8dc632:
	ldb_s r3,[r0,r14]
L_8dc634:
	mov_s r0,r16
L_8dc636:
	mov_s r1,r14
L_8dc638:
	bl.d L_8cf36c
L_8dc63c:
	mov_s r2,0x1
L_8dc63e:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8dc640:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8dc642:
	brhs.d r13,0x1,L_8dc630
L_8dc646:
	extb_s r14,r14
L_8dc648:
	b L_8c023c
