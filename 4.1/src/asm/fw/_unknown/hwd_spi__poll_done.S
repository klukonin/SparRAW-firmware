/* hwd_spi__poll_done @ 0x8f0e94, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_spi_read
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13
 */
	.section .text.hwd_spi__poll_done,"ax",@progbits
	.global hwd_spi__poll_done
hwd_spi__poll_done:
	.global L_8f0e94
L_8f0e94:
	push_s blink
L_8f0e96:
	bl L_8c02c0
L_8f0e9a:
	mov_s r15,r0
L_8f0e9c:
	mov_s r13,0x0
	.global L_8f0e9e
L_8f0e9e:
	mov_s r0,0x880180
L_8f0ea4:
	ld_s r14,[r0,0x28]
L_8f0ea6:
	mov r0,0x320
L_8f0eaa:
	mov lp_count,r0
L_8f0eae:
	nop_s
L_8f0eb0:
	lp L_8f0eb8
L_8f0eb4:
	nop_s
L_8f0eb6:
	nop_s
	.global L_8f0eb8
L_8f0eb8:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8f0eba:
	bbit0 r14,0x1f,L_8f0ec2
L_8f0ebe:
	brlo r13,r15,L_8f0e9e
	.global L_8f0ec2
L_8f0ec2:
	bbit1 r14,0x1f,L_8f0ed8
L_8f0ec6:
	mov_s r0,0x880a3c
L_8f0ecc:
	st 0x1234,[r0, 0x4c]
L_8f0ed4:
	mov_s r0,0x1
L_8f0ed6:
	b_s L_8f0eda
	.global L_8f0ed8
L_8f0ed8:
	mov_s r0,0x0
	.global L_8f0eda
L_8f0eda:
	b L_8c032c
L_8f0ede:
	nop_s
