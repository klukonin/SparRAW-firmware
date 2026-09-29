/* conn_mgr__first_active @ 0x8cc254, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_add_key__pick_mid
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, iter__init, iter__next, list__has_items
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__first_active
conn_mgr__first_active:
	.global L_8cc254
L_8cc254:
	push_s blink
L_8cc256:
	bl.d L_8c01e4
L_8cc25a:
	add r1,r0,0x18
L_8cc25e:
	sub_s sp,sp,0x4
L_8cc260:
	mov_s r13,sp
L_8cc262:
	bl.d L_8e5df4
L_8cc266:
	mov_s r0,r13
L_8cc268:
	mov_s r14,0x0
L_8cc26a:
	b_s L_8cc27a
	.global L_8cc26c
L_8cc26c:
	bl.d L_8df438
L_8cc270:
	mov_s r0,r13
L_8cc272:
	mov_s r14,r0
L_8cc274:
	ldb r0,[r0, 0xf0]
L_8cc278:
	brne_s r0,0,L_8cc282
	.global L_8cc27a
L_8cc27a:
	bl.d L_8cdcb8
L_8cc27e:
	mov_s r0,r13
L_8cc280:
	brne_s r0,0,L_8cc26c
	.global L_8cc282
L_8cc282:
	mov_s r0,r14
L_8cc284:
	b.d L_8c0254
L_8cc288:
	add_s sp,sp,0x4
L_8cc28a:
	nop_s
