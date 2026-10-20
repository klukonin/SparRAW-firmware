/* hw_sysapi_get_beamforming_statistics @ 0x8cde44, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   -->>hw_sysapi_get_beamforming_statistics
 *   hw_sysapi_get_beamforming_statistics, no connection for sta_id %d
 *   <<--hw_sysapi_get_beamforming_statistics
 * Зовут его: UT_MODULE_HW_FLOWS_SYSAPI_cmd_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, add_0c_ret, conn_mgr__by_cid, fw_log_emit0, fw_log_emit1, link_stats__pack_conn_entry, memcpy_fw, ut__begin_response, wmi_evt__send_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hw_sysapi_get_beamforming_statistics
hw_sysapi_get_beamforming_statistics:
	.global L_8cde44
L_8cde44:
	push_s blink
L_8cde46:
	bl L_8c01dc
L_8cde4a:
	sub_s sp,sp,0x2c
L_8cde4c:
	mov_s r16,r0
L_8cde4e:
	mov_s r14,r1
L_8cde50:
	mov_s r1,0x101a96c
L_8cde56:
	bl.d L_8dcba8
L_8cde5a:
	mov_s r0,0x20
L_8cde5c:
	ldb_s r13,[r14,0x4]
L_8cde5e:
	mov_s r15,sp
L_8cde60:
	mov_s r0,r15
L_8cde62:
	mov_s r1,0x8035c4
L_8cde68:
	bl.d L_8c0380
L_8cde6c:
	mov_s r2,0x2c
L_8cde6e:
	mov_s r0,r16
L_8cde70:
	mov_s r1,0xa
L_8cde72:
	bl.d L_8eae60
L_8cde76:
	ldw_s r2,[r14,0x2]
L_8cde78:
	mov_s r14,r0
L_8cde7a:
	mov_s r0,0x0
L_8cde7c:
	st_s r0,[r14,0x4]
L_8cde7e:
	bl.d L_8cbffc
L_8cde82:
	mov_s r0,r13
L_8cde84:
	brne_s r0,0,L_8cde96
L_8cde86:
	mov_s r1,0x101a998
L_8cde8c:
	mov_s r0,0x10
L_8cde8e:
	bl.d L_8dcc10
L_8cde92:
	mov_s r2,r13
L_8cde94:
	b_s L_8cdea6
	.global L_8cde96
L_8cde96:
	mov_s r1,0x1
L_8cde98:
	st_s r1,[r14,0x4]
L_8cde9a:
	bl.d L_8cc364
L_8cde9e:
	add_s r0,r0,0x70
L_8cdea0:
	bl.d L_8cdd7c
L_8cdea4:
	mov_s r1,r15
	.global L_8cdea6
L_8cdea6:
	add r0,r14,0x8
L_8cdeaa:
	mov_s r1,sp
L_8cdeac:
	bl.d L_8c0380
L_8cdeb0:
	mov_s r2,0x2c
L_8cdeb2:
	mov_s r0,r16
L_8cdeb4:
	mov_s r1,r14
L_8cdeb6:
	bl.d L_8eae78
L_8cdeba:
	mov_s r2,0x34
L_8cdebc:
	mov_s r1,0x101a9dc
L_8cdec2:
	bl.d L_8dcba8
L_8cdec6:
	mov_s r0,0x20
L_8cdec8:
	b.d L_8c0244
L_8cdecc:
	add_s sp,sp,0x2c
L_8cdece:
	nop_s
