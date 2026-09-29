/* macq_hw__disable_queue_fw @ 0x8d0c9c, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sm_pring__state_step, vring_schd__disconnect_notify
 * Зовёт сам: __ld_r13_to_r13_ret
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq_hw__disable_queue_fw
macq_hw__disable_queue_fw:
	.global L_8d0c9c
L_8d0c9c:
	push_s blink
L_8d0c9e:
	push_s r13
L_8d0ca0:
	mov_s r13,r0
L_8d0ca2:
	mul64 r0,0x380
L_8d0ca6:
	add r0,mlo,0x44099c0
L_8d0cae:
	lsr r1,r0,0x3
L_8d0cb2:
	bic r2,r1,0x3
L_8d0cb6:
	ld_s r1,[r2]
L_8d0cb8:
	bmsk_s r0,r0,0x4
L_8d0cba:
	bclr r1,r1,r0
L_8d0cbe:
	st_s r1,[r2]
L_8d0cc0:
	sync
L_8d0cc4:
	mul64 r13,0x380
L_8d0cc8:
	add r0,mlo,0x44096c4
L_8d0cd0:
	lsr r1,r0,0x3
L_8d0cd4:
	bic r2,r1,0x3
L_8d0cd8:
	ld_s r1,[r2]
L_8d0cda:
	bmsk_s r0,r0,0x4
L_8d0cdc:
	bclr r1,r1,r0
L_8d0ce0:
	st_s r1,[r2]
L_8d0ce2:
	sync
L_8d0ce6:
	b L_8c025c
L_8d0cea:
	nop_s
