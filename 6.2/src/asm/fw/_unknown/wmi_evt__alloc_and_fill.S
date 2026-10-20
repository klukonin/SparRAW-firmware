/* wmi_evt__alloc_and_fill @ 0x8cb07c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, mem_pool__free__8cb19c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_evt__alloc_and_fill
wmi_evt__alloc_and_fill:
	.global L_8cb07c
L_8cb07c:
	push_s blink
L_8cb07e:
	bl L_8c01e4
L_8cb082:
	mov.f r14,r0
L_8cb086:
	sub_s sp,sp,0xc
L_8cb088:
	mov_s r13,sp
L_8cb08a:
	beq_s L_8cb0a6
	.global L_8cb08c
L_8cb08c:
	st_s r14,[r13,0x8]
L_8cb08e:
	add r0,r14,0x10
L_8cb092:
	st_s r0,[r13,0x4]
L_8cb094:
	sub r14,r14,0x28
L_8cb098:
	st_s r14,[r13]
L_8cb09a:
	bl.d L_8cb19c
L_8cb09e:
	ld_s r0,[sp,0x0]
L_8cb0a0:
	b.d L_8c0254
L_8cb0a4:
	add_s sp,sp,0xc
	.global L_8cb0a6
L_8cb0a6:
	mov_s r0,blink
L_8cb0a8:
	mov_s r1,0x3
L_8cb0aa:
	bl.d L_8c9b28
L_8cb0ae:
	bset_s r1,r1,0xc
L_8cb0b0:
	b_s L_8cb08c
L_8cb0b2:
	nop_s
