/* sm_pring__slot_optimized @ 0x8e4ef4, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PRING #%d slot optimized recognized at %d.
 *   sm_pring_connectivity.cpp
 * Зовут его: sm_pring__update_slot
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log__emit2, fw_read_timer, fw_sysassert_fatal, sm_pring__free_slots, sm_pring__notify_vring_state, u_schd__cancel
 */
	.section .text.sm_pring__slot_optimized,"ax",@progbits
	.global sm_pring__slot_optimized
sm_pring__slot_optimized:
	.global L_8e4ef4
L_8e4ef4:
	push_s blink
L_8e4ef6:
	bl L_8c02bc
L_8e4efa:
	mov_s r14,r0
L_8e4efc:
	bl.d L_8d9ad8
L_8e4f00:
	mov_s r16,r1
L_8e4f02:
	mov_s r15,r0
L_8e4f04:
	ld_s r0,[r14,0x28]
L_8e4f06:
	breq_s r0,0,L_8e4f42
	.global L_8e4f08
L_8e4f08:
	ld_s r0,[r14,0x10]
L_8e4f0a:
	mov_s r13,0x0
L_8e4f0c:
	st_s r13,[r14,0x28]
L_8e4f0e:
	brne r15,r0,L_8e4f3e
L_8e4f12:
	ld_s r0,[r14,0x24]
L_8e4f14:
	breq_s r0,0,L_8e4f1c
L_8e4f16:
	bl L_8c7794
L_8e4f1a:
	st_s r13,[r14,0x24]
	.global L_8e4f1c
L_8e4f1c:
	bl L_8e4694
L_8e4f20:
	ldw_s r3,[r14]
L_8e4f22:
	mov_s r4,r0
L_8e4f24:
	mov_s r2,0x100ee2c
L_8e4f2a:
	mov_s r0,0x7
L_8e4f2c:
	mov_s r1,0x2
L_8e4f2e:
	bl.d L_8edff8
L_8e4f32:
	asl r4,r4,0x4
L_8e4f36:
	ldw_s r0,[r14]
L_8e4f38:
	bl.d L_8e4df4
L_8e4f3c:
	mov_s r1,r16
	.global L_8e4f3e
L_8e4f3e:
	b L_8c0324
	.global L_8e4f42
L_8e4f42:
	mov_s r0,blink
L_8e4f44:
	mov_s r2,0x100ec18
L_8e4f4a:
	mov_s r1,0xe7
L_8e4f4c:
	bset_s r1,r1,0xc
L_8e4f4e:
	bl.d L_8c82c0
L_8e4f52:
	mov_s r3,0xe0
L_8e4f54:
	b_s L_8e4f08
L_8e4f56:
	nop_s
