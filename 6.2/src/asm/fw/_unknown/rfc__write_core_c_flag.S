/* rfc__write_core_c_flag @ 0x8d460c, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_rf_xpm_program_byte
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_rfc_write_core_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rfc__write_core_c_flag
rfc__write_core_c_flag:
	.global L_8d460c
L_8d460c:
	push_s blink
L_8d460e:
	push_s r13
L_8d4610:
	mov_s r3,0x803908
L_8d4616:
	ld_s r3,[r3,0x10]
L_8d4618:
	bmsk_s r2,r2,0x0
L_8d461a:
	push_s r3
L_8d461c:
	stw r1,[sp]
L_8d4620:
	ld_s r13,[sp,0x0]
L_8d4622:
	asl r3,r2,0x11
L_8d4626:
	bclr_s r13,r13,0x10
L_8d4628:
	bclr_s r13,r13,0x11
L_8d462a:
	bset_s r13,r13,0x10
L_8d462c:
	extb_s r0,r0
L_8d462e:
	mov_s r1,0xc
L_8d4630:
	mov_s r2,0x0
L_8d4632:
	bl.d L_8d415c
L_8d4636:
	or_s r3,r3,r13
L_8d4638:
	b.d L_8c025c
L_8d463c:
	add_s sp,sp,0x4
L_8d463e:
	nop_s
