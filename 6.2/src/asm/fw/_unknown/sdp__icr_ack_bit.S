/* sdp__icr_ack_bit @ 0x8d4758, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sdp__init_pair
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sdp__icr_ack_bit
sdp__icr_ack_bit:
	.global L_8d4758
L_8d4758:
	mov_s r1,0x0
L_8d475a:
	bset r1,r1,r0
L_8d475e:
	mov_s r0,0x880b00
L_8d4764:
	st_s r1,[r0,0x50]
L_8d4766:
	j_s [blink]
