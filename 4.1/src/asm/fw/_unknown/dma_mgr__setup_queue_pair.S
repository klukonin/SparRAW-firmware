/* dma_mgr__setup_queue_pair @ 0x8d5dec, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: dma_mgr__reset_queue_0x19, dma_mgr__reset_queue_0x1a, tx_api__init_oob_dma_queues
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, dma_mgr__configure_ring, fwq_tx__init
 */
	.section .text.dma_mgr__setup_queue_pair,"ax",@progbits
	.global dma_mgr__setup_queue_pair
dma_mgr__setup_queue_pair:
	.global L_8d5dec
L_8d5dec:
	push_s blink
L_8d5dee:
	bl L_8c02ac
L_8d5df2:
	mov_s r14,r0
L_8d5df4:
	mov_s r18,r1
L_8d5df6:
	mov_s r17,r2
L_8d5df8:
	mov_s r20,r3
L_8d5dfa:
	mov_s r15,r4
L_8d5dfc:
	mov r16,r5
L_8d5e00:
	add3 r13,r0,0xa
L_8d5e04:
	ld_s r0,[r13]
L_8d5e06:
	mov r19,r6
L_8d5e0a:
	ld r5,[r0, 0x8]
L_8d5e0e:
	mov_s r0,r13
L_8d5e10:
	mov_s r1,r3
L_8d5e12:
	mov_s r2,r4
L_8d5e14:
	mov_s r3,r16
L_8d5e16:
	jl.d [r5]
L_8d5e1a:
	mov r4,r6
L_8d5e1e:
	add2 r0,r14,0x1b
L_8d5e22:
	ld_s r1,[r0]
L_8d5e24:
	mov_s r2,r15
L_8d5e26:
	ld r5,[r1, 0x8]
L_8d5e2a:
	mov_s r1,r20
L_8d5e2c:
	mov_s r3,r16
L_8d5e2e:
	jl.d [r5]
L_8d5e32:
	mov r4,r19
L_8d5e36:
	st r13,[r14, 0x8c]
L_8d5e3a:
	bmsk r1,r16,0x11
L_8d5e3e:
	mov_s r0,r15
L_8d5e40:
	mov_s r2,0x0
L_8d5e42:
	mov_s r3,r19
L_8d5e44:
	mov r4,0x1
L_8d5e48:
	mov r5,r4
L_8d5e4c:
	mov_s r6,r2
L_8d5e4e:
	bl.d L_8c611c
L_8d5e52:
	mov_s r7,r2
L_8d5e54:
	mov_s r0,r14
L_8d5e56:
	mov_s r1,r18
L_8d5e58:
	bl.d L_8d62c0
L_8d5e5c:
	mov_s r2,r17
L_8d5e5e:
	b L_8c0304
L_8d5e62:
	nop_s
