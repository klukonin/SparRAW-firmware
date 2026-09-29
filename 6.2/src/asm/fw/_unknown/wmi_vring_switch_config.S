/* wmi_vring_switch_config @ 0x8e7340, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_vring_switch_config
wmi_vring_switch_config:
	.global L_8e7340
L_8e7340:
	push_s blink
L_8e7342:
	bl L_8c01e4
L_8e7346:
	mov_s r13,r0
L_8e7348:
	ld_s r0,[r1]
L_8e734a:
	sub_s sp,sp,0x4
L_8e734c:
	mov_s r14,r2
L_8e734e:
	brne_s r0,0,L_8e7352
L_8e7350:
	ld_s r0,[gp,-0x110]
	.global L_8e7352
L_8e7352:
	st.as r0,[gp,-0x44]
L_8e7356:
	ld_s r0,[r1,0x4]
L_8e7358:
	brne_s r0,0,L_8e735c
L_8e735a:
	ld_s r0,[gp,-0x114]
	.global L_8e735c
L_8e735c:
	st.as r0,[gp,-0x45]
L_8e7360:
	bl.d L_8c33d0
L_8e7364:
	mov_s r0,r13
L_8e7366:
	mov_s r1,r0
L_8e7368:
	mov_s r2,0x0
L_8e736a:
	stb_s r2,[r0]
L_8e736c:
	st_s r2,[sp,0x0]
L_8e736e:
	mov_s r0,r13
L_8e7370:
	mov_s r3,0x1868
L_8e7376:
	mov r4,0x4
L_8e737a:
	mov_s r5,r14
L_8e737c:
	mov_s r6,r2
L_8e737e:
	bl.d L_8e4fc4
L_8e7382:
	mov_s r7,r2
L_8e7384:
	b.d L_8c0254
L_8e7388:
	add_s sp,sp,0x4
L_8e738a:
	nop_s
