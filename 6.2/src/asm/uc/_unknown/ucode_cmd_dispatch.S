/* ucode_cmd_dispatch @ 0x93c928, 712 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: memset_uc
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fwif_write_qh, get_selected_rf_sector_index_cmd_handler, mac__read_tsf64_uc, set_selected_rf_sector_index_cmd_handler, ss__copy_cfg_from_cmd, ss__update_frames_number, traffic_deferral_cfg_cmd_handler, txrx_umac_if_config_pmc_triggers_handler, uc_sysassert, ucode_cmd_0x00_handler
 * Глобалы (через gp): 0x8005dc, 0x8005e0
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_dispatch
ucode_cmd_dispatch:
	.global L_93c928
L_93c928:
	push_s blink
L_93c92a:
	bl L_920234
L_93c92e:
	sub_s sp,sp,0x8
L_93c930:
	mov_s r13,r0
L_93c932:
	ldw_s r0,[r0,0x4]
L_93c934:
	mov_s r14,r1
L_93c936:
	or r0,r0,0xcd0000
L_93c93e:
	mov_s r32,r0
L_93c940:
	st.ab r0,[r25,0x4]
L_93c944:
	bclr r25,r25,0xa
L_93c948:
	bl.d L_9356cc
L_93c94c:
	mov_s r0,sp
L_93c94e:
	ldw_s r1,[r13,0x4]
L_93c950:
	cmp_s r1,0x4a
L_93c952:
	bhi L_93cbe0
L_93c956:
	ldw.x.as r1,[0x8019dc,r1]
L_93c95e:
	add r0,pcl,0xa
L_93c962:
	add1_s r0,r0,r1
L_93c964:
	j_s [r0]
L_93c966:
	bl.d L_93a8d0
L_93c96a:
	mov_s r0,r14
L_93c96c:
	b L_93cbe8
L_93c970:
	bl.d L_93a9ec
L_93c974:
	mov_s r0,r14
L_93c976:
	b L_93cbe8
L_93c97a:
	bl.d L_93a830
L_93c97e:
	mov_s r0,r14
L_93c980:
	b L_93cbe8
L_93c984:
	bl.d L_927338
L_93c988:
	mov_s r0,r14
L_93c98a:
	b L_93cbe8
L_93c98e:
	bl.d L_93a9d0
L_93c992:
	mov_s r0,r14
L_93c994:
	b L_93cbe8
L_93c998:
	bl.d L_93adf0
L_93c99c:
	mov_s r0,r14
L_93c99e:
	b L_93cbe8
L_93c9a2:
	bl.d L_93abf4
L_93c9a6:
	mov_s r0,r14
L_93c9a8:
	b L_93cbe8
L_93c9ac:
	bl.d L_93ad54
L_93c9b0:
	mov_s r0,r14
L_93c9b2:
	b L_93cbe8
L_93c9b6:
	mov_s r0,blink
L_93c9b8:
	b.d L_93cbe4
L_93c9bc:
	mov_s r1,0xa3
L_93c9be:
	bl.d L_93ae18
L_93c9c2:
	mov_s r0,r14
L_93c9c4:
	b L_93cbe8
L_93c9c8:
	bl.d L_93aea8
L_93c9cc:
	mov_s r0,r14
L_93c9ce:
	b L_93cbe8
L_93c9d2:
	bl.d L_921990
L_93c9d6:
	mov_s r0,r14
L_93c9d8:
	b L_93cbe8
L_93c9dc:
	bl.d L_937da4
L_93c9e0:
	mov_s r0,r14
L_93c9e2:
	b L_93cbe8
L_93c9e6:
	bl.d L_93b924
L_93c9ea:
	mov_s r0,r14
L_93c9ec:
	b L_93cbe8
L_93c9f0:
	bl.d L_93477c
L_93c9f4:
	mov_s r0,r14
L_93c9f6:
	b L_93cbe8
L_93c9fa:
	bl.d L_9220d4
L_93c9fe:
	mov_s r0,r14
L_93ca00:
	b L_93cbe8
L_93ca04:
	bl.d L_934b94
L_93ca08:
	mov_s r0,r14
L_93ca0a:
	b L_93cbe8
L_93ca0e:
	bl.d L_9301e4
L_93ca12:
	mov_s r0,r14
L_93ca14:
	b L_93cbe8
L_93ca18:
	bl.d L_92fcc4
L_93ca1c:
	mov_s r0,r14
L_93ca1e:
	b L_93cbe8
L_93ca22:
	ld_s r1,[r14]
L_93ca24:
	mov_s r0,0x8021b8
L_93ca2a:
	b.d L_93cbe8
L_93ca2e:
	st_s r1,[r0,0x20]
L_93ca30:
	ld_s r1,[r14]
L_93ca32:
	ld_s r0,[r14,0x4]
L_93ca34:
	st.as r1,[gp,0x2d]
L_93ca38:
	b.d L_93cbe8
L_93ca3c:
	st.as r0,[gp,0x2e]
L_93ca40:
	bl.d L_9357dc
L_93ca44:
	mov_s r0,r14
L_93ca46:
	b_s L_93cbe8
L_93ca48:
	bl.d L_93a7a0
L_93ca4c:
	mov_s r0,r14
L_93ca4e:
	b_s L_93cbe8
L_93ca50:
	bl.d L_92e748
L_93ca54:
	mov_s r0,r14
L_93ca56:
	b_s L_93cbe8
L_93ca58:
	bl.d L_93cbf0
L_93ca5c:
	mov_s r0,r14
L_93ca5e:
	b_s L_93cbe8
L_93ca60:
	bl.d L_92e458
L_93ca64:
	mov_s r0,r14
L_93ca66:
	b_s L_93cbe8
L_93ca68:
	bl.d L_93a9b0
L_93ca6c:
	mov_s r0,r14
L_93ca6e:
	b_s L_93cbe8
L_93ca70:
	bl.d L_92e840
L_93ca74:
	mov_s r0,r14
L_93ca76:
	b_s L_93cbe8
L_93ca78:
	bl.d L_920b4c
L_93ca7c:
	mov_s r0,r14
L_93ca7e:
	b_s L_93cbe8
L_93ca80:
	bl.d L_93b1f8
L_93ca84:
	mov_s r0,r14
L_93ca86:
	b_s L_93cbe8
L_93ca88:
	bl.d L_92c5dc
L_93ca8c:
	mov_s r0,r14
L_93ca8e:
	b_s L_93cbe8
L_93ca90:
	bl.d L_937430
L_93ca94:
	mov_s r0,r14
L_93ca96:
	b_s L_93cbe8
L_93ca98:
	mov_s r0,0x803134
L_93ca9e:
	mov_s r1,r14
L_93caa0:
	bl.d L_935d90
L_93caa4:
	ld_s r2,[r14,0x8]
L_93caa6:
	b_s L_93cbe8
L_93caa8:
	mov_s r0,0x803134
L_93caae:
	bl.d L_936014
L_93cab2:
	ld_s r1,[r14]
L_93cab4:
	b_s L_93cbe8
L_93cab6:
	mov_s r0,0x803134
L_93cabc:
	bl.d L_935de4
L_93cac0:
	mov_s r1,r14
L_93cac2:
	b_s L_93cbe8
L_93cac4:
	mov_s r0,0x803134
L_93caca:
	bl.d L_9360a4
L_93cace:
	ld_s r1,[r14]
L_93cad0:
	b_s L_93cbe8
L_93cad2:
	mov_s r0,0x803134
L_93cad8:
	bl.d L_92811c
L_93cadc:
	mov_s r1,r14
L_93cade:
	b_s L_93cbe8
L_93cae0:
	mov_s r0,0x803134
L_93cae6:
	bl.d L_928168
L_93caea:
	ld_s r1,[r14]
L_93caec:
	b_s L_93cbe8
L_93caee:
	mov_s r0,0x803134
L_93caf4:
	bl.d L_924dcc
L_93caf8:
	mov_s r1,r14
L_93cafa:
	b_s L_93cbe8
L_93cafc:
	mov_s r0,0x803134
L_93cb02:
	bl.d L_924e0c
L_93cb06:
	ld_s r1,[r14]
L_93cb08:
	b_s L_93cbe8
L_93cb0a:
	bl.d L_9373fc
L_93cb0e:
	mov_s r0,r14
L_93cb10:
	b_s L_93cbe8
L_93cb12:
	bl.d L_926ab4
L_93cb16:
	mov_s r0,r14
L_93cb18:
	b_s L_93cbe8
L_93cb1a:
	bl.d L_92ff04
L_93cb1e:
	mov_s r0,r14
L_93cb20:
	b_s L_93cbe8
L_93cb22:
	bl.d L_920dc8
L_93cb26:
	mov_s r0,r14
L_93cb28:
	b_s L_93cbe8
L_93cb2a:
	bl.d L_923940
L_93cb2e:
	mov_s r0,r14
L_93cb30:
	b_s L_93cbe8
L_93cb32:
	mov_s r0,0x802f80
L_93cb38:
	bl.d L_93d2a8
L_93cb3c:
	mov_s r1,r14
L_93cb3e:
	b_s L_93cbe8
L_93cb40:
	mov_s r0,0x802f80
L_93cb46:
	bl.d L_93d9d0
L_93cb4a:
	mov_s r1,r14
L_93cb4c:
	b_s L_93cbe8
L_93cb4e:
	bl.d L_93e1c0
L_93cb52:
	mov_s r0,r14
L_93cb54:
	bl.d L_93e150
L_93cb58:
	mov_s r0,r14
L_93cb5a:
	b_s L_93cbe8
L_93cb5c:
	bl.d L_93e168
L_93cb60:
	mov_s r0,r14
L_93cb62:
	bl.d L_93e130
L_93cb66:
	mov_s r0,r14
L_93cb68:
	b_s L_93cbe8
L_93cb6a:
	mov_s r0,0x803134
L_93cb70:
	bl.d L_92e47c
L_93cb74:
	mov_s r1,r14
L_93cb76:
	b_s L_93cbe8
L_93cb78:
	mov_s r0,0x803134
L_93cb7e:
	bl.d L_92e4b4
L_93cb82:
	ld_s r1,[r14]
L_93cb84:
	b_s L_93cbe8
L_93cb86:
	bl.d L_928224
L_93cb8a:
	mov_s r0,r14
L_93cb8c:
	b_s L_93cbe8
L_93cb8e:
	bl.d L_9354c0
L_93cb92:
	mov_s r0,r14
L_93cb94:
	b_s L_93cbe8
L_93cb96:
	bl.d L_926954
L_93cb9a:
	ld_s r0,[r14]
L_93cb9c:
	b_s L_93cbe8
L_93cb9e:
	bl.d L_93a970
L_93cba2:
	mov_s r0,r14
L_93cba4:
	b_s L_93cbe8
L_93cba6:
	bl.d L_93a7d4
L_93cbaa:
	mov_s r0,r14
L_93cbac:
	b_s L_93cbe8
L_93cbae:
	mov_s r0,0x1
L_93cbb0:
	stb r0,[gp, -0xdf]
L_93cbb4:
	stb r0,[gp, -0xde]
L_93cbb8:
	b_s L_93cbe8
L_93cbba:
	bl.d L_9279c8
L_93cbbe:
	mov_s r0,r14
L_93cbc0:
	b_s L_93cbe8
L_93cbc2:
	bl.d L_927368
L_93cbc6:
	mov_s r0,r14
L_93cbc8:
	b_s L_93cbe8
L_93cbca:
	bl L_927618
L_93cbce:
	b_s L_93cbe8
L_93cbd0:
	bl.d L_9351e4
L_93cbd4:
	mov_s r0,r14
L_93cbd6:
	b_s L_93cbe8
L_93cbd8:
	bl.d L_934ba4
L_93cbdc:
	mov_s r0,r14
L_93cbde:
	b_s L_93cbe8
	.global L_93cbe0
L_93cbe0:
	mov_s r0,blink
L_93cbe2:
	mov_s r1,0xa4
	.global L_93cbe4
L_93cbe4:
	bl L_926618
	.global L_93cbe8
L_93cbe8:
	b.d L_9202a4
L_93cbec:
	add_s sp,sp,0x8
L_93cbee:
	nop_s
