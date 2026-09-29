/* rm_ch_switch_sm__notify_ch_switch_done @ 0x8c5b44, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring_schd__move_to_ready
 * Зовёт сам: __ld_r13_to_r13_ret, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rm_ch_switch_sm__notify_ch_switch_done
rm_ch_switch_sm__notify_ch_switch_done:
	.global L_8c5b44
L_8c5b44:
	push_s blink
L_8c5b46:
	bl.d L_8c01e4
L_8c5b4a:
	mul64 r1,0x3c
L_8c5b4e:
	add_s r0,r0,0x28
L_8c5b50:
	add r14,r0,mlo
L_8c5b54:
	ld_s r0,[r14,0x14]
L_8c5b56:
	mov_s r13,r1
L_8c5b58:
	breq_s r0,0,L_8c5b64
L_8c5b5a:
	breq r13,0x1,L_8c5b6a
	.global L_8c5b5e
L_8c5b5e:
	ld_s r0,[r14,0x14]
L_8c5b60:
	ldb_s r0,[r0,0xb]
L_8c5b62:
	brne_s r0,0,L_8c5b78
	.global L_8c5b64
L_8c5b64:
	b.d L_8c0254
L_8c5b68:
	mov_s r0,r14
	.global L_8c5b6a
L_8c5b6a:
	mov_s r0,blink
L_8c5b6c:
	mov_s r1,0x140b
L_8c5b72:
	bl L_8c9b28
L_8c5b76:
	b_s L_8c5b5e
	.global L_8c5b78
L_8c5b78:
	cmp_s r13,0x1
L_8c5b7a:
	mov.eq r0,blink
L_8c5b7e:
	mov.eq r1,0x140c
L_8c5b86:
	bl.eq L_8c9b28
L_8c5b8a:
	b_s L_8c5b64
L_8c5b8c:
	push_s blink
L_8c5b8e:
	push_s r13
L_8c5b90:
	mov.f r13,r0
L_8c5b94:
	beq_s L_8c5baa
	.global L_8c5b96
L_8c5b96:
	bl L_8e9524
L_8c5b9a:
	mov_s r0,0x0
L_8c5b9c:
	st_s r0,[r13,0x10]
L_8c5b9e:
	ld_s r0,[r13,0x2c]
L_8c5ba0:
	ld_s r1,[r0,0x10]
L_8c5ba2:
	jl_s.d [r1]
L_8c5ba4:
	mov_s r0,r13
L_8c5ba6:
	b L_8c025c
	.global L_8c5baa
L_8c5baa:
	mov_s r0,blink
L_8c5bac:
	mov_s r1,0x1438
L_8c5bb2:
	bl L_8c9b28
L_8c5bb6:
	b_s L_8c5b96
