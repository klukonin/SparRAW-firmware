/* l2_mgr__wmi_scan_cmd @ 0x8eca58, 196 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   l2_mgr::wmi_scan_cmd() SCAN CMD (Type = %d, Number of channels = %d)
 *   l2_mgr::wmi_scan_cmd() PROHIBITs cids 0x%x of MID#%d
 * Зовут его: low_sme__wmi_scan_cmd_handler
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, bit_iter__has_more, bitmap__alloc_bit, field_set_0x00__8e5dfc, fw_log_emit2, fw_sysassert_fatal, l2_mgr__scan_start_log, l2mgr__pending_op_set, lm_if__inject_evt9, mid_list__any_in_state2_fw, mid_list__by_mid_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2_mgr__wmi_scan_cmd
l2_mgr__wmi_scan_cmd:
	.global L_8eca58
L_8eca58:
	push_s blink
L_8eca5a:
	bl L_8c01d4
L_8eca5e:
	sub_s sp,sp,0x4
L_8eca60:
	mov_s r16,r0
L_8eca62:
	mov_s r18,r1
L_8eca64:
	mov_s r0,0x0
L_8eca66:
	bl.d L_8e6358
L_8eca6a:
	mov_s r17,r0
L_8eca6c:
	bl.d L_8cc484
L_8eca70:
	mov_s r15,sp
L_8eca72:
	mov_s r1,r0
L_8eca74:
	bl.d L_8e5dfc
L_8eca78:
	mov_s r0,r15
L_8eca7a:
	b_s L_8eca9a
	.global L_8eca7c
L_8eca7c:
	bl.d L_8df444
L_8eca80:
	mov_s r0,r15
L_8eca82:
	bl L_8cc3dc
L_8eca86:
	mov.f r13,r0
L_8eca8a:
	beq_s L_8ecae0
	.global L_8eca8c
L_8eca8c:
	mov_s r0,r13
L_8eca8e:
	bl.d L_8cc424
L_8eca92:
	mov_s r1,0x1
L_8eca94:
	mov.f r14,r0
L_8eca98:
	bne_s L_8ecaee
	.global L_8eca9a
L_8eca9a:
	bl.d L_8cdcc4
L_8eca9e:
	mov_s r0,r15
L_8ecaa0:
	brne_s r0,0,L_8eca7c
L_8ecaa2:
	bl.d L_8cc3dc
L_8ecaa6:
	mov_s r0,r18
L_8ecaa8:
	mov_s r18,r0
L_8ecaaa:
	ldb r2,[r16, 0x10]
L_8ecaae:
	mov_s r1,0x100df14
L_8ecab4:
	mov_s r0,0x29
L_8ecab6:
	bl.d L_8dcc80
L_8ecaba:
	ldb r3,[r16, 0x11]
L_8ecabe:
	mov_s r0,0x2
L_8ecac0:
	bl.d L_8e8a14
L_8ecac4:
	mov_s r1,0x0
L_8ecac6:
	bl L_8c37ac
L_8ecaca:
	mov_s r1,r16
L_8ecacc:
	mov_s r3,r0
L_8ecace:
	mov_s r0,r18
L_8ecad0:
	add r0,r0,0x234
L_8ecad4:
	bl.d L_8f8338
L_8ecad8:
	mov_s r2,r17
L_8ecada:
	b.d L_8c0234
L_8ecade:
	add_s sp,sp,0x4
	.global L_8ecae0
L_8ecae0:
	mov_s r0,blink
L_8ecae2:
	mov_s r1,0x16b7
L_8ecae8:
	bl L_8c9b28
L_8ecaec:
	b_s L_8eca8c
	.global L_8ecaee
L_8ecaee:
	ldb r17,[r13, 0x24]
L_8ecaf2:
	mov_s r1,0x100df5c
L_8ecaf8:
	mov_s r0,0x29
L_8ecafa:
	mov_s r2,r17
L_8ecafc:
	bl.d L_8dcc80
L_8ecb00:
	ldb_s r3,[r13,0x10]
L_8ecb02:
	bl L_8cd080
L_8ecb06:
	ld_s r1,[r0]
L_8ecb08:
	ld_s r2,[r1,0x1c]
L_8ecb0a:
	jl_s.d [r2]
L_8ecb0c:
	mov_s r1,r17
L_8ecb0e:
	mov_s r17,r0
L_8ecb10:
	bl.d L_8e011c
L_8ecb14:
	add3 r0,r14,0xe
L_8ecb18:
	b_s L_8eca9a
L_8ecb1a:
	nop_s
