/* radio_mgr__call_method_10 @ 0x8ea800, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__on_frag_done, channel_estimation_cmd_start, channels_switch_sm__action_scan_complete, dma__set_881b24_bit1, find_main_sm__stop, hw_sysapi_rfc_read_write_rgf, hw_sysapi_rx_omni_sector_set, l2_mgr__high_false_alarm_secondary_lock_cb, maintain_sm__fbf_failed, maintain_sm__release_radio_after_bf_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global radio_mgr__call_method_10
radio_mgr__call_method_10:
	.global L_8ea800
L_8ea800:
	mov_s r1,r0
L_8ea802:
	ld_s r0,[gp,-0x40]
L_8ea804:
	ld_s r2,[r0]
L_8ea806:
	ld_s r2,[r2,0x10]
L_8ea808:
	j_s [r2]
L_8ea80a:
	nop_s
L_8ea80c:
	lr r0,[0xa]
L_8ea810:
	bclr r1,r0,0x1
L_8ea814:
	flag r1
L_8ea818:
	mov_s r1,0x880b00
L_8ea81e:
	st 0x40000,[r1, 0x64]
L_8ea826:
	lr r1,[0xa]
L_8ea82a:
	bic r0,r0,-0x3
L_8ea82e:
	or_s r0,r0,r1
L_8ea830:
	flag r0
L_8ea834:
	j_s [blink]
L_8ea836:
	nop_s
L_8ea838:
	lr r0,[0xa]
L_8ea83c:
	bclr r1,r0,0x1
L_8ea840:
	flag r1
L_8ea844:
	mov_s r1,0x880b00
L_8ea84a:
	st 0x80000,[r1, 0x64]
L_8ea852:
	lr r1,[0xa]
L_8ea856:
	bic r0,r0,-0x3
L_8ea85a:
	or_s r0,r0,r1
L_8ea85c:
	flag r0
L_8ea860:
	j_s [blink]
L_8ea862:
	nop_s
