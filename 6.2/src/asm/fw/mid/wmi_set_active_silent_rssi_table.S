/* wmi_set_active_silent_rssi_table @ 0x8e6120, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, calib__start_scheme4, calib_obj4__reset_d4, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_set_active_silent_rssi_table
wmi_set_active_silent_rssi_table:
	.global L_8e6120
L_8e6120:
	push_s blink
L_8e6122:
	bl L_8c01d8
L_8e6126:
	sub_s sp,sp,0x4
L_8e6128:
	mov_s r15,r0
L_8e612a:
	mov_s r14,r1
L_8e612c:
	bl.d L_8cbb90
L_8e6130:
	mov_s r17,r2
L_8e6132:
	mov_s r16,r0
L_8e6134:
	bl.d L_8c33d0
L_8e6138:
	mov_s r0,r15
L_8e613a:
	mov_s r13,r0
L_8e613c:
	st_s r14,[r0,0x4]
L_8e613e:
	cmp_s r14,0x0
L_8e6140:
	cmp.ne r14,0x1
L_8e6144:
	mov_s r0,0x1
L_8e6146:
	bne_s L_8e6152
L_8e6148:
	mov_s r0,r16
L_8e614a:
	bl.d L_8e6fd4
L_8e614e:
	mov_s r1,r14
L_8e6150:
	mov_s r0,0x0
	.global L_8e6152
L_8e6152:
	st_s r0,[r13]
L_8e6154:
	mov_s r2,0x0
L_8e6156:
	st_s r2,[sp,0x0]
L_8e6158:
	mov_s r0,r15
L_8e615a:
	mov_s r1,r13
L_8e615c:
	mov_s r3,0x185c
L_8e6162:
	mov r4,0x8
L_8e6166:
	mov r5,r17
L_8e616a:
	mov_s r6,r2
L_8e616c:
	bl.d L_8e4fc4
L_8e6170:
	mov_s r7,r2
L_8e6172:
	b.d L_8c023c
L_8e6176:
	add_s sp,sp,0x4
