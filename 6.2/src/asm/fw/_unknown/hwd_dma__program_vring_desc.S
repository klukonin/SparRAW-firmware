/* hwd_dma__program_vring_desc @ 0x8d0d0c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ADD
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, dpal__cpl_timeout_evt
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__program_vring_desc
hwd_dma__program_vring_desc:
	.global L_8d0d0c
L_8d0d0c:
	push_s blink
L_8d0d0e:
	bl L_8c01e4
L_8d0d12:
	mov_s r13,r3
L_8d0d14:
	asl r14,r0,0x8
L_8d0d18:
	add r0,r14,0x440c160
L_8d0d20:
	lsr_s r0,r0,0x3
L_8d0d22:
	bic r0,r0,0x3
L_8d0d26:
	st_s r1,[r0]
L_8d0d28:
	bl.d L_8c9680
L_8d0d2c:
	mov_s r0,r2
L_8d0d2e:
	add r4,r14,0x440c1a0
L_8d0d36:
	lsr r4,r4,0x3
L_8d0d3a:
	bic r0,r4,0x3
L_8d0d3e:
	st_s r13,[r0]
L_8d0d40:
	b L_8c0254
