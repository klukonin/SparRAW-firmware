/* ul_stream__ba_sm_evt @ 0x8d6afc, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ul_stream.cpp
 *    ba_sm_evt_type = %x
 * Зовут его: STREAM_MGR, bcast_vring__delete, stream_mgr__addba_req_tx_complete, stream_mgr__ba_disable, stream_mgr__ba_teardown, stream_mgr__on_delba, stream_mgr__on_delba_rx, vring_ba_en__race_check
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, basic_sm__inject_event, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.ul_stream__ba_sm_evt,"ax",@progbits
	.global ul_stream__ba_sm_evt
ul_stream__ba_sm_evt:
	.global L_8d6afc
L_8d6afc:
	push_s blink
L_8d6afe:
	bl L_8c02b4
L_8d6b02:
	mov_s r14,r0
L_8d6b04:
	mov_s r18,r2
L_8d6b06:
	mov_s r17,r3
L_8d6b08:
	brhs.d r1,0x7,L_8d6b3c
L_8d6b0c:
	mov r16,r4
L_8d6b10:
	ldb.x r1,[0x801f2c,r1]
L_8d6b18:
	add r0,pcl,0x8
L_8d6b1c:
	add1_s r0,r0,r1
L_8d6b1e:
	j_s [r0]
L_8d6b20:
	mov_s r13,0x0
L_8d6b22:
	b_s L_8d6b52
L_8d6b24:
	mov_s r13,0x1
L_8d6b26:
	b_s L_8d6b52
L_8d6b28:
	mov_s r13,0x5
L_8d6b2a:
	b_s L_8d6b52
L_8d6b2c:
	mov_s r13,0x3
L_8d6b2e:
	b_s L_8d6b52
L_8d6b30:
	mov_s r13,0x4
L_8d6b32:
	b_s L_8d6b52
L_8d6b34:
	mov_s r13,0x6
L_8d6b36:
	b_s L_8d6b52
L_8d6b38:
	mov_s r13,0xa
L_8d6b3a:
	b_s L_8d6b52
	.global L_8d6b3c
L_8d6b3c:
	mov_s r13,0x8
L_8d6b3e:
	mov_s r0,blink
L_8d6b40:
	mov_s r2,0x100eb18
L_8d6b46:
	mov_s r1,0x129b
L_8d6b4c:
	bl.d L_8c82c0
L_8d6b50:
	mov_s r3,0x3d
	.global L_8d6b52
L_8d6b52:
	mov_s r2,0x100eb28
L_8d6b58:
	mov_s r0,0xb
L_8d6b5a:
	mov_s r1,0x2
L_8d6b5c:
	bl.d L_8edfcc
L_8d6b60:
	mov_s r3,r13
L_8d6b62:
	add r0,r14,0x10
L_8d6b66:
	mov_s r1,r13
L_8d6b68:
	mov_s r2,r18
L_8d6b6a:
	mov_s r3,r17
L_8d6b6c:
	bl.d L_8d6a1c
L_8d6b70:
	mov r4,r16
L_8d6b74:
	b L_8c0314
