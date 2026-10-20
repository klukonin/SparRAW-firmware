/* link_lost_diag__dump_rf @ 0x8eaea4, 228 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG RF: RF tx_gain_config_val=%d    atten_config_val=%d
 *   DEBUG RF: CURRENT_STATUS.RF_INFO1: 0x%08x
 *   DEBUG RF: CURRENT_STATUS.CURR_SEC3: 0x%08x
 *   DEBUG RF: CURRENT_STATUS.CURR_SEC4: 0x%08x
 *   DEBUG RF: CURRENT_STATUS.CURR_SEC5: 0x%08x
 *   DEBUG RF: CURRENT_STATUS.CURR_SEC6: 0x%08x
 *   DEBUG RF: MODEM_STAT.RFC_MODEM_STAT_18(mdm_stt_rx_crc_err): 0x%08x
 * Зовут его: link_lost_diag__dump_all
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, fw_log__emit2, get_reg_880a7c_8d74b8, tail_hwd_rfc_read_rgf
 */
	.section .text.link_lost_diag__dump_rf,"ax",@progbits
	.global link_lost_diag__dump_rf
link_lost_diag__dump_rf:
	.global L_8eaea4
L_8eaea4:
	push_s blink
L_8eaea6:
	push_s r13
L_8eaea8:
	bl.d L_8d74b8
L_8eaeac:
	mov_s r13,r0
L_8eaeae:
	breq r0,0x0,L_8eaf84
L_8eaeb2:
	ldb_s r1,[r13]
L_8eaeb4:
	mov_s r0,r13
L_8eaeb6:
	bl.d L_8ddd74
L_8eaeba:
	mov r2,0x504
L_8eaebe:
	mov_s r13,r0
L_8eaec0:
	mov_s r2,0x1005a18
L_8eaec6:
	mov_s r0,0x0
L_8eaec8:
	mov_s r1,0x2
L_8eaeca:
	bmsk r3,r13,0x3
L_8eaece:
	bl.d L_8edff8
L_8eaed2:
	lsr r4,r13,0x4
L_8eaed6:
	mov_s r13,0x803e84
L_8eaedc:
	ldb_s r1,[r13]
L_8eaede:
	mov_s r0,r13
L_8eaee0:
	bl.d L_8ddd74
L_8eaee4:
	mov r2,0x6c8
L_8eaee8:
	mov_s r3,r0
L_8eaeea:
	mov_s r2,0x1005a54
L_8eaef0:
	mov_s r0,0x0
L_8eaef2:
	bl.d L_8edfcc
L_8eaef6:
	mov_s r1,0x2
L_8eaef8:
	ldb_s r1,[r13]
L_8eaefa:
	mov_s r0,r13
L_8eaefc:
	bl.d L_8ddd74
L_8eaf00:
	mov r2,0x6d4
L_8eaf04:
	mov_s r3,r0
L_8eaf06:
	mov_s r2,0x1005a80
L_8eaf0c:
	mov_s r0,0x0
L_8eaf0e:
	bl.d L_8edfcc
L_8eaf12:
	mov_s r1,0x2
L_8eaf14:
	ldb_s r1,[r13]
L_8eaf16:
	mov_s r0,r13
L_8eaf18:
	bl.d L_8ddd74
L_8eaf1c:
	mov r2,0x6d8
L_8eaf20:
	mov_s r3,r0
L_8eaf22:
	mov_s r2,0x1005aac
L_8eaf28:
	mov_s r0,0x0
L_8eaf2a:
	bl.d L_8edfcc
L_8eaf2e:
	mov_s r1,0x2
L_8eaf30:
	ldb_s r1,[r13]
L_8eaf32:
	mov_s r0,r13
L_8eaf34:
	bl.d L_8ddd74
L_8eaf38:
	mov r2,0x6dc
L_8eaf3c:
	mov_s r3,r0
L_8eaf3e:
	mov_s r2,0x1005ad8
L_8eaf44:
	mov_s r0,0x0
L_8eaf46:
	bl.d L_8edfcc
L_8eaf4a:
	mov_s r1,0x2
L_8eaf4c:
	ldb_s r1,[r13]
L_8eaf4e:
	mov_s r0,r13
L_8eaf50:
	bl.d L_8ddd74
L_8eaf54:
	mov r2,0x6e0
L_8eaf58:
	mov_s r3,r0
L_8eaf5a:
	mov_s r2,0x1005b04
L_8eaf60:
	mov_s r0,0x0
L_8eaf62:
	bl.d L_8edfcc
L_8eaf66:
	mov_s r1,0x2
L_8eaf68:
	ldb_s r1,[r13]
L_8eaf6a:
	mov_s r0,r13
L_8eaf6c:
	bl.d L_8ddd74
L_8eaf70:
	mov r2,0x42c
L_8eaf74:
	mov_s r3,r0
L_8eaf76:
	mov_s r2,0x1005b30
L_8eaf7c:
	mov_s r0,0x0
L_8eaf7e:
	bl.d L_8edfcc
L_8eaf82:
	mov_s r1,0x2
	.global L_8eaf84
L_8eaf84:
	b L_8c033c
