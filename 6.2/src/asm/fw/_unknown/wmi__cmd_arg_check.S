/* wmi__cmd_arg_check @ 0x8e909c, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, basic_calib__check_g8000a4, mem_pool__alloc_locked, temp__get_rf_by_index, temp_sense__get_cached, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__cmd_arg_check
wmi__cmd_arg_check:
	.global L_8e909c
L_8e909c:
	push_s blink
L_8e909e:
	bl L_8c01d4
L_8e90a2:
	mov_s r17,r0
L_8e90a4:
	ld_s r0,[r1,0x8]
L_8e90a6:
	sub_s sp,sp,0x4
L_8e90a8:
	breq r0,0x1,L_8e90ba
L_8e90ac:
	mov_s r0,L_8e5dac-0x8c0000
L_8e90b2:
	bl.d L_8dddc0
L_8e90b6:
	mov_s r1,r17
L_8e90b8:
	b_s L_8e9108
	.global L_8e90ba
L_8e90ba:
	bl.d L_8c33d0
L_8e90be:
	mov_s r0,r17
L_8e90c0:
	mov_s r16,r0
L_8e90c2:
	add r18,r0,0x4
L_8e90c6:
	mov_s r15,0x0
L_8e90c8:
	bl.d L_8cb91c
L_8e90cc:
	mov_s r0,r15
L_8e90ce:
	st r0,[r16]
L_8e90d2:
	mov_s r13,0x8
L_8e90d4:
	mov_s r14,r15
	.global L_8e90d6
L_8e90d6:
	mov_s r0,r14
L_8e90d8:
	bl.d L_8cca40
L_8e90dc:
	mov_s r1,0x0
L_8e90de:
	add2 r12,r18,r14
L_8e90e2:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8e90e4:
	st_s r0,[r12]
L_8e90e6:
	brhs.d r13,0x1,L_8e90d6
L_8e90ea:
	/* _add_s r14,0x1 */
	.byte 0x01,0xe6
L_8e90ec:
	st_s r15,[sp,0x0]
L_8e90ee:
	mov_s r0,r17
L_8e90f0:
	mov_s r1,r16
L_8e90f2:
	mov_s r2,0x0
L_8e90f4:
	mov_s r3,0x180e
L_8e90fa:
	mov r4,0x24
L_8e90fe:
	mov_s r5,r2
L_8e9100:
	mov_s r6,r2
L_8e9102:
	bl.d L_8e4fc4
L_8e9106:
	mov_s r7,r2
	.global L_8e9108
L_8e9108:
	b.d L_8c0234
L_8e910c:
	add_s sp,sp,0x4
L_8e910e:
	nop_s
