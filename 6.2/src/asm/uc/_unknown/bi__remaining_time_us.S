/* bi__remaining_time_us @ 0x92dc44, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow, rx__send_response_frame
 * Зовёт сам: __ld_r13_to_r13_ret, uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi__remaining_time_us
bi__remaining_time_us:
	.global L_92dc44
L_92dc44:
	push_s blink
L_92dc46:
	push_s r13
L_92dc48:
	mov_s r13,0x80146c
L_92dc4e:
	ld_s r1,[r13]
L_92dc50:
	mov_s r0,0x0
L_92dc52:
	bbit0 r1,0x0,L_92dc68
L_92dc56:
	bl L_9364c8
L_92dc5a:
	ld_s r1,[r13,0x4]
L_92dc5c:
	sub_s r1,r1,r0
L_92dc5e:
	ldw_s r0,[r13,0x18]
L_92dc60:
	max r1,r1,0x0
L_92dc64:
	min r0,r0,r1
	.global L_92dc68
L_92dc68:
	b L_9202ac
