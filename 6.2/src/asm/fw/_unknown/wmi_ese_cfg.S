/* wmi_ese_cfg @ 0x8fbb20, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_SCHEDULING_SCHEME_EVENTID for devid %d (status %d).
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_log_emit2, mem_pool__alloc_locked, memset0_words, mid_list__by_mid_fw, schedule_scheme_builder__build_allocations, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_ese_cfg
wmi_ese_cfg:
	.global L_8fbb20
L_8fbb20:
	push_s blink
L_8fbb22:
	bl L_8c01d4
L_8fbb26:
	sub_s sp,sp,0x4
L_8fbb28:
	mov_s r15,r0
L_8fbb2a:
	mov_s r17,r1
L_8fbb2c:
	mov_s r18,r2
L_8fbb2e:
	bl.d L_8cc3dc
L_8fbb32:
	mov_s r0,r1
L_8fbb34:
	ld.as r0,[r0,0xa4]
L_8fbb38:
	bl.d L_8c52cc
L_8fbb3c:
	mov_s r1,r15
L_8fbb3e:
	mov_s r13,r0
L_8fbb40:
	extb r16,r0
L_8fbb44:
	bl.d L_8c33d0
L_8fbb48:
	mov_s r0,r18
L_8fbb4a:
	mov_s r14,r0
L_8fbb4c:
	bl.d L_8c1cd8
L_8fbb50:
	mov_s r1,0x4
L_8fbb52:
	stb_s r13,[r14]
L_8fbb54:
	ldb_s r0,[r15]
L_8fbb56:
	stb_s r13,[r14,0x2]
L_8fbb58:
	stb_s r0,[r14,0x1]
L_8fbb5a:
	mov_s r1,0x100e2d4
L_8fbb60:
	mov_s r0,0x2b
L_8fbb62:
	mov_s r2,r17
L_8fbb64:
	bl.d L_8dcc80
L_8fbb68:
	mov_s r3,r16
L_8fbb6a:
	mov_s r2,0x0
L_8fbb6c:
	st_s r2,[sp,0x0]
L_8fbb6e:
	mov_s r0,r18
L_8fbb70:
	mov_s r1,r14
L_8fbb72:
	mov_s r3,0x1a01
L_8fbb78:
	mov r4,0x4
L_8fbb7c:
	mov r5,r17
L_8fbb80:
	mov_s r6,r2
L_8fbb82:
	bl.d L_8e4fc4
L_8fbb86:
	mov_s r7,r2
L_8fbb88:
	b.d L_8c0234
L_8fbb8c:
	add_s sp,sp,0x4
L_8fbb8e:
	nop_s
