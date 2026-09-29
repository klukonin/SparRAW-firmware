/* macq__kick_queue @ 0x8e1c7c, 24 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mac_ring_enable, tx_ring__post_frame
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global macq__kick_queue
macq__kick_queue:
	.global L_8e1c7c
L_8e1c7c:
	mov_s r2,0x1
L_8e1c7e:
	mov_s r1,0x0
L_8e1c80:
	bset r1,r1,r0
L_8e1c84:
	mov_s r0,0x886a00
L_8e1c8a:
	st_s r1,[r0,0x18]
L_8e1c8c:
	st_s r1,[r0,0x1c]
L_8e1c8e:
	st_s r2,[r0,0x20]
L_8e1c90:
	j_s [blink]
L_8e1c92:
	nop_s
