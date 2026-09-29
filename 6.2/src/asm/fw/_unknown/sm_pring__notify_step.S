/* sm_pring__notify_step @ 0x8eaa38, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__notify_vring_state, vring_schd__bind_if_free, vring_schd__disconnect_notify
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sm_pring__notify_step
sm_pring__notify_step:
	.global L_8eaa38
L_8eaa38:
	push_s blink
L_8eaa3a:
	bl L_8c01e4
L_8eaa3e:
	sub_s sp,sp,0x8
L_8eaa40:
	mov_s r13,r0
L_8eaa42:
	mov_s r14,r1
L_8eaa44:
	mov_s r1,sp
L_8eaa46:
	mov_s r0,0x0
L_8eaa48:
	bl.d L_8e9900
L_8eaa4c:
	mov_s r2,r0
L_8eaa4e:
	ld_s r2,[r13,0x14]
L_8eaa50:
	ld_s r3,[r13,0x18]
L_8eaa52:
	or.f 0x0,r2,r3
L_8eaa56:
	beq_s L_8eaa68
L_8eaa58:
	ld_s r0,[sp,0x4]
L_8eaa5a:
	ld_s r1,[sp,0x0]
L_8eaa5c:
	cmp_s r3,r0
L_8eaa5e:
	cmp.eq r2,r1
L_8eaa62:
	sub.cs r1,r1,r2
L_8eaa66:
	blo_s L_8eaa6a
	.global L_8eaa68
L_8eaa68:
	mov_s r1,0x0
	.global L_8eaa6a
L_8eaa6a:
	ld_s r0,[r13,0x1c]
L_8eaa6c:
	cmp_s r14,0x0
L_8eaa6e:
	add_s r0,r0,r1
L_8eaa70:
	st_s r0,[r13,0x1c]
L_8eaa72:
	mov_s r0,0x0
L_8eaa74:
	mov.eq r1,r0
L_8eaa78:
	beq_s L_8eaa7e
L_8eaa7a:
	ld_s r0,[sp,0x0]
L_8eaa7c:
	ld_s r1,[sp,0x4]
	.global L_8eaa7e
L_8eaa7e:
	st_s r0,[r13,0x14]
L_8eaa80:
	st_s r1,[r13,0x18]
L_8eaa82:
	b.d L_8c0254
L_8eaa86:
	add_s sp,sp,0x8
