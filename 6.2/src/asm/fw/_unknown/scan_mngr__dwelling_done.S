/* scan_mngr__dwelling_done @ 0x8f2b88, 312 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::dwelling_done() rescan for omni %d
 *   scan_mngr::dwelling_done() - scan_status = %d, m_is_connected = %d
 *   fw_sysapi_mgr::complete_energy_statistics(): RX Packet Energy Statistics Results: status=%d, samples_num=%d, acquisition duration=%d
 *   fw_sysapi_mgr::complete_energy_statistics(): RX Packet Energy Statistics Results: rssi_adc_min=%d, rssi_adc_max=%d
 *   fw_sysapi_mgr::complete_energy_statistics(): RX Packet Energy Statistics Results: rssi_ant_min=%d, rssi_ant_max=%d
 *   fw_sysapi_mgr::complete_energy_statistics(): RX Packet Energy Statistics Results: snr_adc_min=%d, snr_adc_max=%d
 * Зовут его: channels_switch_sm__action_scan_complete, fw_sysapi_mgr__start_energy_statistics
 * Зовёт сам: __ld_r15_to_r13_ret, __ld_r17_to_r13_ret, __st_r15_to_r13, __st_r17_to_r13, basic_sm__handle_event, fw_log_emit1, fw_log_emit2, fw_log_emit3, fw_sysapi_mgr__get_rssi_and_snr_statistics, fw_sysapi_mgr__send_evt2host, fw_sysapi_mgr__stop_sysapi_cmd, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__dwelling_done
scan_mngr__dwelling_done:
	.global L_8f2b88
L_8f2b88:
	push_s blink
L_8f2b8a:
	bl L_8c01e0
L_8f2b8e:
	mov_s r13,r0
L_8f2b90:
	add r13,r13,0x200
L_8f2b94:
	ldb_s r2,[r13,0x14]
L_8f2b96:
	mov_s r14,r0
L_8f2b98:
	/* add_s r2,0x1 */
	.byte 0x01,0xe2
L_8f2b9a:
	extb_s r2,r2
L_8f2b9c:
	mov_s r0,0x857720
L_8f2ba2:
	stb_s r2,[r13,0x14]
L_8f2ba4:
	ldb_s r0,[r0,0x1c]
L_8f2ba6:
	brge.d r2,r0,L_8f2bd4
L_8f2baa:
	mov_s r15,r1
L_8f2bac:
	mov_s r1,0x10156b0
L_8f2bb2:
	bl.d L_8dcc10
L_8f2bb6:
	mov_s r0,0x29
L_8f2bb8:
	bl.d L_8f3160
L_8f2bbc:
	mov_s r0,r14
L_8f2bbe:
	bl.d L_8f1aa0
L_8f2bc2:
	mov_s r0,r14
L_8f2bc4:
	ld_s r2,[r13,0xc]
L_8f2bc6:
	add3 r1,r14,0x3f
L_8f2bca:
	mov_s r0,r14
L_8f2bcc:
	bl.d L_8f9780
L_8f2bd0:
	ld_s r3,[r13,0x10]
L_8f2bd2:
	b_s L_8f2c02
	.global L_8f2bd4
L_8f2bd4:
	mov_s r1,0x10156e0
L_8f2bda:
	mov_s r0,0x29
L_8f2bdc:
	mov_s r2,r15
L_8f2bde:
	bl.d L_8dcc80
L_8f2be2:
	ld_s r3,[r13,0x24]
L_8f2be4:
	ld_s r0,[r13,0x24]
L_8f2be6:
	brne_s r0,0,L_8f2bf2
L_8f2be8:
	mov_s r0,r14
L_8f2bea:
	bl.d L_8f8220
L_8f2bee:
	mov_s r1,r15
L_8f2bf0:
	b_s L_8f2c02
	.global L_8f2bf2
L_8f2bf2:
	add3 r0,r14,0x3a
L_8f2bf6:
	mov_s r1,0x2
L_8f2bf8:
	mov_s r2,r15
L_8f2bfa:
	mov_s r3,0x0
L_8f2bfc:
	bl.d L_8d9b6c
L_8f2c00:
	mov_s r4,r3
	.global L_8f2c02
L_8f2c02:
	b L_8c024c
L_8f2c06:
	nop_s
	.global L_8f2c08
L_8f2c08:
	push_s blink
L_8f2c0a:
	bl L_8c01d8
L_8f2c0e:
	mov_s r13,r0
L_8f2c10:
	mov_s r14,0x857280
L_8f2c16:
	ld_s r0,[r14,0x20]
L_8f2c18:
	brhs.d r0,0x15,L_8f2cb6
L_8f2c1c:
	mov_s r17,r1
	.global L_8f2c1e
L_8f2c1e:
	add r16,r13,0x3c
L_8f2c22:
	mov_s r0,r13
L_8f2c24:
	ld_s r1,[r14,0x20]
L_8f2c26:
	mov_s r2,0x1
L_8f2c28:
	add r3,r14,0x24
L_8f2c2c:
	add2 r4,r14,0x1d
L_8f2c30:
	bl.d L_8f3780
L_8f2c34:
	mov r5,r16
L_8f2c38:
	ld_s r0,[r13,0x28]
L_8f2c3a:
	add r4,r13,0x4
L_8f2c3e:
	ld_s r1,[r13,0x24]
L_8f2c40:
	st_s r0,[r13,0x40]
L_8f2c42:
	mov_s r0,0x857200
L_8f2c48:
	st_s r1,[r13,0x3c]
L_8f2c4a:
	ld r1,[r0, 0x98]
L_8f2c4e:
	mov_s r2,r16
L_8f2c50:
	ld r0,[r0, 0x9c]
L_8f2c54:
	st_s r1,[r13,0x44]
L_8f2c56:
	st_s r0,[r13,0x48]
L_8f2c58:
	mov_s r0,r13
L_8f2c5a:
	mov_s r1,r17
L_8f2c5c:
	bl.d L_8f8948
L_8f2c60:
	mov_s r3,0x2c
L_8f2c62:
	mov_s r0,r13
L_8f2c64:
	bl.d L_8f9bd0
L_8f2c68:
	mov_s r1,0x1
L_8f2c6a:
	ld_s r14,[r13,0x44]
L_8f2c6c:
	ld_s r0,[r13,0x3c]
L_8f2c6e:
	mov_s r1,0x1012d64
L_8f2c74:
	sub r4,r14,r0
L_8f2c78:
	mov_s r0,0x20
L_8f2c7a:
	mov_s r2,r17
L_8f2c7c:
	bl.d L_8dcd00
L_8f2c80:
	ld_s r3,[r13,0x64]
L_8f2c82:
	mov_s r1,0x1012dec
L_8f2c88:
	ld_s r2,[r13,0x4c]
L_8f2c8a:
	mov_s r0,0x20
L_8f2c8c:
	bl.d L_8dcc80
L_8f2c90:
	ld_s r3,[r13,0x50]
L_8f2c92:
	mov_s r1,0x1012e60
L_8f2c98:
	ld_s r2,[r13,0x5c]
L_8f2c9a:
	mov_s r0,0x20
L_8f2c9c:
	bl.d L_8dcc80
L_8f2ca0:
	ld_s r3,[r13,0x60]
L_8f2ca2:
	mov_s r1,0x1012ed4
L_8f2ca8:
	ld_s r2,[r13,0x54]
L_8f2caa:
	mov_s r0,0x20
L_8f2cac:
	bl.d L_8dcc80
L_8f2cb0:
	ld_s r3,[r13,0x58]
L_8f2cb2:
	b L_8c023c
	.global L_8f2cb6
L_8f2cb6:
	mov_s r0,blink
L_8f2cb8:
	bl.d L_8c9b28
L_8f2cbc:
	mov_s r1,0x9f
L_8f2cbe:
	b_s L_8f2c1e
