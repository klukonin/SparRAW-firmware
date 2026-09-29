/* wmi_set_ap_slot_size @ 0x8e6178, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_cmd_pool__alloc, lmac_if__post_cmd, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_ap_slot_size
wmi_set_ap_slot_size:
	.global L_8e6178
L_8e6178:
	push_s blink
L_8e617a:
	bl L_8c01e0
L_8e617e:
	sub_s sp,sp,0x4
L_8e6180:
	mov_s r14,r0
L_8e6182:
	bl.d L_8c33d0
L_8e6186:
	mov_s r13,r1
L_8e6188:
	bl.d L_8c3284
L_8e618c:
	mov_s r15,r0
L_8e618e:
	st_s r13,[r0]
L_8e6190:
	mov_s r1,0x4a
L_8e6192:
	mov_s r2,0x4
L_8e6194:
	mov_s r13,0x0
L_8e6196:
	bl.d L_8e5204
L_8e619a:
	mov_s r3,r13
L_8e619c:
	st_s r13,[sp,0x0]
L_8e619e:
	mov_s r0,r14
L_8e61a0:
	mov_s r1,r15
L_8e61a2:
	mov_s r2,r13
L_8e61a4:
	mov_s r3,0x1a0f
L_8e61aa:
	mov r4,0x4
L_8e61ae:
	mov_s r5,r13
L_8e61b0:
	mov_s r6,r13
L_8e61b2:
	bl.d L_8e4fc4
L_8e61b6:
	mov_s r7,r13
L_8e61b8:
	b.d L_8c024c
L_8e61bc:
	add_s sp,sp,0x4
L_8e61be:
	nop_s
