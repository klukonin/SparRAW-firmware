/* wmi_set_cca_indications_bi_avg_num @ 0x8fbbe8, 124 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ---->> [HOST EVENT] WMI_SET_CCA_INDICATIONS_BI_AVG_NUM_EVENT
 *   <<---- [HOST EVENT] WMI_SET_CCA_INDICATIONS_BI_AVG_NUM_EVENT
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit0, mem_pool__alloc_locked, mid_list__by_mid_fw, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_cca_indications_bi_avg_num
wmi_set_cca_indications_bi_avg_num:
	.global L_8fbbe8
L_8fbbe8:
	push_s blink
L_8fbbea:
	bl L_8c01dc
L_8fbbee:
	mov_s r16,r1
L_8fbbf0:
	mov_s r15,r2
L_8fbbf2:
	mov_s r3,0x803c00
L_8fbbf8:
	ldb_s r2,[r3,0x1c]
L_8fbbfa:
	ldb_s r1,[r0]
L_8fbbfc:
	sub_s sp,sp,0x4
L_8fbbfe:
	mov_s r13,0x0
L_8fbc00:
	breq r2,r1,L_8fbc1a
L_8fbc04:
	mov_s r1,0x80426c
L_8fbc0a:
	mov_s r2,0x1
L_8fbc0c:
	st_s r13,[r1,0x4]
L_8fbc0e:
	st_s r13,[r1,0xc]
L_8fbc10:
	stb_s r13,[r1,0x8]
L_8fbc12:
	stb_s r13,[r1,0x10]
L_8fbc14:
	stw_s r2,[r1]
L_8fbc16:
	ldb_s r0,[r0]
L_8fbc18:
	stb_s r0,[r3,0x1c]
	.global L_8fbc1a
L_8fbc1a:
	bl.d L_8c33d0
L_8fbc1e:
	mov_s r0,r16
L_8fbc20:
	mov_s r14,r0
L_8fbc22:
	bl.d L_8cc3dc
L_8fbc26:
	mov_s r0,r15
L_8fbc28:
	mov_s r1,0x100e254
L_8fbc2e:
	bl.d L_8dcba8
L_8fbc32:
	mov_s r0,0x2b
L_8fbc34:
	stb_s r13,[r14]
L_8fbc36:
	mov_s r1,0x100e294
L_8fbc3c:
	bl.d L_8dcba8
L_8fbc40:
	mov_s r0,0x2b
L_8fbc42:
	st_s r13,[sp,0x0]
L_8fbc44:
	mov_s r0,r16
L_8fbc46:
	mov_s r1,r14
L_8fbc48:
	mov_s r2,0x0
L_8fbc4a:
	mov_s r3,0x1a08
L_8fbc50:
	mov r4,0x4
L_8fbc54:
	mov_s r5,r15
L_8fbc56:
	mov_s r6,r2
L_8fbc58:
	bl.d L_8e4fc4
L_8fbc5c:
	mov_s r7,r2
L_8fbc5e:
	b.d L_8c0244
L_8fbc62:
	add_s sp,sp,0x4
