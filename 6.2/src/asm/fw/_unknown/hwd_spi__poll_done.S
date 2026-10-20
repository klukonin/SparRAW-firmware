/* hwd_spi__poll_done @ 0x8f9248, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_spi_read
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_spi__poll_done
hwd_spi__poll_done:
	.global L_8f9248
L_8f9248:
	push_s blink
L_8f924a:
	bl L_8c01e0
L_8f924e:
	mov_s r15,r0
L_8f9250:
	mov_s r13,0x0
	.global L_8f9252
L_8f9252:
	mov_s r0,0x880180
L_8f9258:
	ld_s r14,[r0,0x28]
L_8f925a:
	mov r0,0x320
L_8f925e:
	mov lp_count,r0
L_8f9262:
	nop_s
L_8f9264:
	lp L_8f926c
L_8f9268:
	nop_s
L_8f926a:
	nop_s
	.global L_8f926c
L_8f926c:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f926e:
	bbit0 r14,0x1f,L_8f9276
L_8f9272:
	brlo r13,r15,L_8f9252
	.global L_8f9276
L_8f9276:
	bbit1 r14,0x1f,L_8f928c
L_8f927a:
	mov_s r0,0x880a3c
L_8f9280:
	st 0x1234,[r0, 0x4c]
L_8f9288:
	mov_s r0,0x1
L_8f928a:
	b_s L_8f928e
	.global L_8f928c
L_8f928c:
	mov_s r0,0x0
	.global L_8f928e
L_8f928e:
	b L_8c024c
L_8f9292:
	nop_s
