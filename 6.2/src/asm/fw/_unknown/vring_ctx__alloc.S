/* vring_ctx__alloc @ 0x8c3490, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_bcast_vring_cfg, wmi_vring_cfg
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal, mem_pool__allocate
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_ctx__alloc
vring_ctx__alloc:
	.global L_8c3490
L_8c3490:
	push_s blink
L_8c3492:
	mov_s r0,0x847b34
L_8c3498:
	bl.d L_8c354c
L_8c349c:
	push_s r13
L_8c349e:
	mov.f r13,r0
L_8c34a2:
	beq_s L_8c34aa
	.global L_8c34a4
L_8c34a4:
	b.d L_8c025c
L_8c34a8:
	mov_s r0,r13
	.global L_8c34aa
L_8c34aa:
	mov_s r0,blink
L_8c34ac:
	mov_s r1,0x85
L_8c34ae:
	bl.d L_8c9b28
L_8c34b2:
	bset_s r1,r1,0xc
L_8c34b4:
	b_s L_8c34a4
L_8c34b6:
	nop_s
