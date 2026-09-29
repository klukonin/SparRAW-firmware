/* bi__remaining_time_us @ 0x92a608, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow, rx__send_response_frame
 * Зовёт сам: __ld_r13_ret_uc, uc_read_tsf_lo
 */
	.section .text.bi__remaining_time_us,"ax",@progbits
	.global bi__remaining_time_us
bi__remaining_time_us:
	.global L_92a608
L_92a608:
	push_s blink
L_92a60a:
	push_s r13
L_92a60c:
	mov_s r13,0x800994
L_92a612:
	ld_s r1,[r13]
L_92a614:
	mov_s r0,0x0
L_92a616:
	bbit0 r1,0x0,L_92a62c
L_92a61a:
	bl L_9315e8
L_92a61e:
	ld_s r1,[r13,0x4]
L_92a620:
	sub_s r1,r1,r0
L_92a622:
	ldw_s r0,[r13,0x18]
L_92a624:
	max r1,r1,0x0
L_92a628:
	min r0,r0,r1
	.global L_92a62c
L_92a62c:
	b L_92028c
