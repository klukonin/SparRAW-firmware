/* discovery__tsf_wa @ 0x8f9cfc, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   discovery::tsf_wa() WA Config  set_primary_channel = %d, ch = %d
 *   discovery::tsf_wa() WA Config done  ch = %d
 * Зовут его: find_mngr__cfg_offload, scan_mngr__start_scan
 * Зовёт сам: RADIO_MGR__set_primary_channel, RADIO_MGR__unset_primary_channel, __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, fw_log_emit2, radio_mgr__get_current_channel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global discovery__tsf_wa
discovery__tsf_wa:
	.global L_8f9cfc
L_8f9cfc:
	push_s blink
L_8f9cfe:
	bl L_8c01e0
L_8f9d02:
	sub_s sp,sp,0xc
L_8f9d04:
	mov_s r14,r1
L_8f9d06:
	mov_s r15,r2
L_8f9d08:
	mov_s r13,sp
L_8f9d0a:
	bl.d L_8cc130
L_8f9d0e:
	mov_s r0,r13
L_8f9d10:
	ld_s r3,[sp,0x0]
L_8f9d12:
	brne r3,0xffff,L_8f9d40
L_8f9d1a:
	mov_s r1,0x1016e90
L_8f9d20:
	mov_s r0,0x2c
L_8f9d22:
	bl.d L_8dcc80
L_8f9d26:
	mov_s r2,r14
L_8f9d28:
	ld_s r1,[sp,0x4]
L_8f9d2a:
	mov_s r0,r14
L_8f9d2c:
	ld_s r2,[sp,0x8]
L_8f9d2e:
	mov_s r3,r15
L_8f9d30:
	mov r4,0x1
L_8f9d34:
	bl.d L_8e6cec
L_8f9d38:
	mov r5,0x0
L_8f9d3c:
	bl L_8ea87c
	.global L_8f9d40
L_8f9d40:
	bl.d L_8cc130
L_8f9d44:
	mov_s r0,r13
L_8f9d46:
	mov_s r1,0x1016ed4
L_8f9d4c:
	mov_s r0,0x2c
L_8f9d4e:
	bl.d L_8dcc10
L_8f9d52:
	ld_s r2,[sp,0x0]
L_8f9d54:
	b.d L_8c024c
L_8f9d58:
	add_s sp,sp,0xc
L_8f9d5a:
	nop_s
