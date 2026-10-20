/* wmi_beamforming_mgmt @ 0x8dcfa8, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   START_0
 *   DONE_0
 *   START_1
 *   DONE_1
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit0, lmac_cmd_pool__alloc, lmac_if__post_cmd, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_beamforming_mgmt
wmi_beamforming_mgmt:
	.global L_8dcfa8
L_8dcfa8:
	push_s blink
L_8dcfaa:
	bl L_8c01d8
L_8dcfae:
	sub_s sp,sp,0x4
L_8dcfb0:
	mov_s r16,r0
L_8dcfb2:
	bl.d L_8c3284
L_8dcfb6:
	mov_s r15,r2
L_8dcfb8:
	mov_s r14,r0
L_8dcfba:
	mov_s r0,0x1
L_8dcfbc:
	st_s r0,[r14]
L_8dcfbe:
	mov_s r13,0x0
L_8dcfc0:
	st_s r13,[r14,0x4]
L_8dcfc2:
	st_s r13,[r14,0x8]
L_8dcfc4:
	mov_s r1,0x10061f4
L_8dcfca:
	bl.d L_8dcba8
L_8dcfce:
	mov_s r0,r13
L_8dcfd0:
	mov_s r0,r14
L_8dcfd2:
	mov_s r1,0x9
L_8dcfd4:
	mov_s r2,0xc
L_8dcfd6:
	bl.d L_8e5204
L_8dcfda:
	mov_s r3,r15
L_8dcfdc:
	mov_s r1,0x10061fc
L_8dcfe2:
	bl.d L_8dcba8
L_8dcfe6:
	mov_s r0,r13
L_8dcfe8:
	bl.d L_8c33d0
L_8dcfec:
	mov_s r0,r16
L_8dcfee:
	mov_s r17,r0
L_8dcff0:
	mov_s r1,0x1006204
L_8dcff6:
	bl.d L_8dcba8
L_8dcffa:
	mov_s r0,r13
L_8dcffc:
	st_s r13,[sp,0x0]
L_8dcffe:
	mov_s r0,r16
L_8dd000:
	mov_s r1,r17
L_8dd002:
	mov_s r2,r13
L_8dd004:
	mov_s r3,0x1836
L_8dd00a:
	mov_s r4,r13
L_8dd00c:
	mov_s r5,r15
L_8dd00e:
	mov_s r6,r13
L_8dd010:
	bl.d L_8e4fc4
L_8dd014:
	mov_s r7,r13
L_8dd016:
	mov_s r1,0x100620c
L_8dd01c:
	bl.d L_8dcba8
L_8dd020:
	mov_s r0,r13
L_8dd022:
	b.d L_8c023c
L_8dd026:
	add_s sp,sp,0x4
