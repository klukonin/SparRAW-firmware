/* init_rf_hw @ 0x8f590c, 244 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   marlon_r_if_class::init_board_file_inteface: Board file initialization error. RF configurations are not accessible. System will enter no RF flow
 *   init_rf_hw: no enabled RFs; g_rfc_connected_indx_vec = 0x%x, brd_rfs  = 0x%x
 *   init_rf_hw: g_rfc_connected_indx_vec=0x%x, m_rfc_enabled=0x%x, g_rfc_active_indx_vec=0x%x
 * Зовут его: fw_main
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit0, fw_log_emit2, fw_log_emit3, fw_sysassert_fatal, hwd__program_889_group, hwd_abif__dvs_if_splitter_enable, hwd_abif__dvs_lo_splitter_enable, hwd_abif__dvs_rf_activate, hwd_abif__dvs_rfca_cmd_enable, hwd_abif__fs_off, hwd_abif__fs_on
 * Глобалы (через gp): 0x800242, 0x800243
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global init_rf_hw
init_rf_hw:
	.global L_8f590c
L_8f590c:
	push_s blink
L_8f590e:
	push_s r13
L_8f5910:
	bl.d L_8cea04
L_8f5914:
	mov_s r13,r0
L_8f5916:
	bl.d L_8cea38
L_8f591a:
	mov_s r0,0x1
L_8f591c:
	bl.d L_8cebac
L_8f5920:
	mov_s r0,0x0
L_8f5922:
	bl.d L_8ce6b8
L_8f5926:
	mov_s r0,0xff
L_8f5928:
	bl.d L_8ce794
L_8f592c:
	mov_s r0,0xff
L_8f592e:
	bl.d L_8ce838
L_8f5932:
	mov_s r0,0xff
L_8f5934:
	bl.d L_8d70b8
L_8f5938:
	mov_s r0,0x0
L_8f593a:
	mov_s r0,0x3a980
L_8f5940:
	mov lp_count,r0
L_8f5944:
	nop_s
L_8f5946:
	lp L_8f594e
L_8f594a:
	nop_s
L_8f594c:
	nop_s
	.global L_8f594e
L_8f594e:
	bl.d L_8d7560
L_8f5952:
	mov_s r0,0x1
L_8f5954:
	bl.d L_8d7560
L_8f5958:
	mov_s r0,0x0
L_8f595a:
	bl.d L_8d31dc
L_8f595e:
	mov_s r0,0x1
L_8f5960:
	bl L_8d6f68
L_8f5964:
	stb r0,[gp, 0xbf]
L_8f5968:
	bl.d L_8f5700
L_8f596c:
	mov_s r0,r13
L_8f596e:
	brne_s r0,0,L_8f597c
L_8f5970:
	mov_s r1,0x1005c1c
L_8f5976:
	bl.d L_8dcba8
L_8f597a:
	mov_s r0,0x0
	.global L_8f597c
L_8f597c:
	add r13,r13,0x440
L_8f5980:
	ldb_s r3,[r13,0x1c]
L_8f5982:
	ldb_s r0,[gp,0xbf]
L_8f5984:
	brne_s r3,0,L_8f598e
L_8f5986:
	sub_s r1,r0,0x1
L_8f5988:
	bic_s r0,r0,r1
L_8f598a:
	stb_s r0,[r13,0x1e]
L_8f598c:
	b_s L_8f59b2
	.global L_8f598e
L_8f598e:
	and_s r0,r0,r3
L_8f5990:
	stb_s r0,[r13,0x1e]
L_8f5992:
	breq r3,r0,L_8f59b2
L_8f5996:
	mov_s r1,0x1005cb0
L_8f599c:
	mov_s r0,0x0
L_8f599e:
	bl.d L_8dcc80
L_8f59a2:
	ldb r2,[gp, 0xbf]
L_8f59a6:
	mov_s r0,blink
L_8f59a8:
	mov_s r1,0x1452
L_8f59ae:
	bl L_8c9b28
	.global L_8f59b2
L_8f59b2:
	bl.d L_8d7500
L_8f59b6:
	mov_s r0,0xff
L_8f59b8:
	mov_s r0,0x0
L_8f59ba:
	bl.d L_8d705c
L_8f59be:
	mov_s r1,r0
L_8f59c0:
	ldb_s r0,[r13,0x1e]
L_8f59c2:
	mov_s r1,0x1
L_8f59c4:
	b_s L_8f59cc
	.global L_8f59c6
L_8f59c6:
	and_s r0,r0,r2
L_8f59c8:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8f59ca:
	extw_s r1,r1
	.global L_8f59cc
L_8f59cc:
	brlt.d r1,0x1,L_8f59c6
L_8f59d0:
	sub_s r2,r0,0x1
L_8f59d2:
	bic_s r0,r0,r2
L_8f59d4:
	extb r4,r0
L_8f59d8:
	stb r0,[gp, 0xbe]
L_8f59dc:
	ldb r2,[gp, 0xbf]
L_8f59e0:
	mov_s r1,0x1005d00
L_8f59e6:
	mov_s r0,0x20
L_8f59e8:
	bl.d L_8dcd00
L_8f59ec:
	ldb_s r3,[r13,0x1e]
L_8f59ee:
	bl.d L_8d7500
L_8f59f2:
	ldb_s r0,[r13,0x1e]
L_8f59f4:
	ldb_s r0,[gp,0xbe]
L_8f59f6:
	bl.d L_8ce910
L_8f59fa:
	mov_s r1,0x0
L_8f59fc:
	b L_8c025c
