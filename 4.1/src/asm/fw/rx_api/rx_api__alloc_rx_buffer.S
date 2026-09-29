/* rx_api__alloc_rx_buffer @ 0x8c2bf4, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/rx_api.h
 * Зовут его: fwq_tx__handle_completion, mid__refill_rx_buffers
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, mem_pool__allocate
 */
	.section .text.rx_api__alloc_rx_buffer,"ax",@progbits
	.global rx_api__alloc_rx_buffer
rx_api__alloc_rx_buffer:
	.global L_8c2bf4
L_8c2bf4:
	push_s blink
L_8c2bf6:
	bl L_8c02c4
L_8c2bfa:
	sub_s sp,sp,0xc
L_8c2bfc:
	mov_s r0,0x8062e0
L_8c2c02:
	bl.d L_8c2dc8
L_8c2c06:
	mov_s r14,sp
L_8c2c08:
	mov.f r13,r0
L_8c2c0c:
	beq_s L_8c2c22
	.global L_8c2c0e
L_8c2c0e:
	st_s r13,[r14]
L_8c2c10:
	add r0,r13,0x28
L_8c2c14:
	st_s r0,[r14,0x8]
L_8c2c16:
	add_s r13,r13,0x38
L_8c2c18:
	st_s r13,[r14,0x4]
L_8c2c1a:
	ld_s r0,[sp,0x4]
L_8c2c1c:
	b.d L_8c0334
L_8c2c20:
	add_s sp,sp,0xc
	.global L_8c2c22
L_8c2c22:
	mov_s r0,blink
L_8c2c24:
	mov_s r2,0x10152d0
L_8c2c2a:
	mov_s r1,0x1
L_8c2c2c:
	bset_s r1,r1,0xc
L_8c2c2e:
	bl.d L_8c82c0
L_8c2c32:
	mov_s r3,0x2a
L_8c2c34:
	b_s L_8c2c0e
L_8c2c36:
	nop_s
