/* calib_lo__write_vt_codes @ 0x8d0478, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__vt04
 */
	.section .text.calib_lo__write_vt_codes,"ax",@progbits
	.global calib_lo__write_vt_codes
calib_lo__write_vt_codes:
	.global L_8d0478
L_8d0478:
	push_s r13
L_8d047a:
	ld_s r3,[r1]
L_8d047c:
	mov_s r13,0xfffff000
L_8d0482:
	mov_s r0,0xccc
L_8d0488:
	and_s r3,r3,r13
L_8d048a:
	or_s r3,r3,r0
L_8d048c:
	st_s r3,[r2]
L_8d048e:
	ld_s r3,[r1,0x4]
L_8d0490:
	and_s r3,r3,r13
L_8d0492:
	or_s r0,r0,r3
L_8d0494:
	st_s r0,[r2,0x4]
L_8d0496:
	ld_s r0,[r1,0x8]
L_8d0498:
	and r0,r0,0xffff0000
L_8d04a0:
	or r0,r0,0xcccc
L_8d04a8:
	st_s r0,[r2,0x8]
L_8d04aa:
	j_s.d [blink]
L_8d04ac:
	pop_s r13
L_8d04ae:
	nop_s
