/* sdp__drive_pin @ 0x8d13b0, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: SDP__sdp_drive_value, SDP__sdp_init__2, hwf_phy_production_loopback_test
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r14_to_r13_ret, __st_r14_to_r13
 */
	.section .text.sdp__drive_pin,"ax",@progbits
	.global sdp__drive_pin
sdp__drive_pin:
	.global L_8d13b0
L_8d13b0:
	push_s blink
L_8d13b2:
	bl L_8c02c4
L_8d13b6:
	mov_s r13,r0
L_8d13b8:
	mov_s r14,r1
L_8d13ba:
	bl.d L_8d14a8
L_8d13be:
	mov_s r0,r1
L_8d13c0:
	mov_s r1,0x0
L_8d13c2:
	mov_s r0,0x880b80
L_8d13c8:
	bset r1,r1,r14
L_8d13cc:
	brne r13,0x1,L_8d13d4
L_8d13d0:
	st_s r1,[r0,0x10]
L_8d13d2:
	b_s L_8d13d6
	.global L_8d13d4
L_8d13d4:
	st_s r1,[r0,0x8]
	.global L_8d13d6
L_8d13d6:
	b L_8c0334
L_8d13da:
	nop_s
