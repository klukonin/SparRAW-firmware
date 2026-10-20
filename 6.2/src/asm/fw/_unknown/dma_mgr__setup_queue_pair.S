/* dma_mgr__setup_queue_pair @ 0x8d8f28, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__reset_queue_0x19, dma_mgr__reset_queue_0x1a, tx_api__tx_complete_cb
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, dma_mgr__configure_ring, fwq_tx__init
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global dma_mgr__setup_queue_pair
dma_mgr__setup_queue_pair:
	.global L_8d8f28
L_8d8f28:
	push_s blink
L_8d8f2a:
	bl L_8c01cc
L_8d8f2e:
	mov_s r14,r0
L_8d8f30:
	mov_s r18,r1
L_8d8f32:
	mov_s r17,r2
L_8d8f34:
	mov_s r20,r3
L_8d8f36:
	mov_s r15,r4
L_8d8f38:
	mov r16,r5
L_8d8f3c:
	add3 r13,r0,0xa
L_8d8f40:
	ld_s r0,[r13]
L_8d8f42:
	mov r19,r6
L_8d8f46:
	ld r5,[r0, 0x8]
L_8d8f4a:
	mov_s r0,r13
L_8d8f4c:
	mov_s r1,r3
L_8d8f4e:
	mov_s r2,r4
L_8d8f50:
	mov_s r3,r16
L_8d8f52:
	jl.d [r5]
L_8d8f56:
	mov r4,r6
L_8d8f5a:
	add2 r0,r14,0x1b
L_8d8f5e:
	ld_s r1,[r0]
L_8d8f60:
	mov_s r2,r15
L_8d8f62:
	ld r5,[r1, 0x8]
L_8d8f66:
	mov_s r1,r20
L_8d8f68:
	mov_s r3,r16
L_8d8f6a:
	jl.d [r5]
L_8d8f6e:
	mov r4,r19
L_8d8f72:
	st r13,[r14, 0x8c]
L_8d8f76:
	bmsk r1,r16,0x11
L_8d8f7a:
	mov_s r0,r15
L_8d8f7c:
	mov_s r2,0x0
L_8d8f7e:
	mov_s r3,r19
L_8d8f80:
	mov r4,0x1
L_8d8f84:
	mov r5,r4
L_8d8f88:
	mov_s r6,r2
L_8d8f8a:
	bl.d L_8c6e90
L_8d8f8e:
	mov_s r7,r2
L_8d8f90:
	mov_s r0,r14
L_8d8f92:
	mov_s r1,r18
L_8d8f94:
	bl.d L_8d92e0
L_8d8f98:
	mov_s r2,r17
L_8d8f9a:
	b L_8c0224
L_8d8f9e:
	nop_s
