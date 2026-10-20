/* rfc__read_field_484 @ 0x8d0444, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_lo_power__vt04
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_rfc_read_rgf
 */
	.section .text.rfc__read_field_484,"ax",@progbits
	.global rfc__read_field_484
rfc__read_field_484:
	.global L_8d0444
L_8d0444:
	push_s blink
L_8d0446:
	bl L_8c02c4
L_8d044a:
	mov_s r14,r1
L_8d044c:
	extb_s r13,r0
L_8d044e:
	mov_s r0,r13
L_8d0450:
	bl.d L_8d04fc
L_8d0454:
	mov r1,0x1e4
L_8d0458:
	st_s r0,[r14]
L_8d045a:
	mov_s r0,r13
L_8d045c:
	bl.d L_8d04fc
L_8d0460:
	mov r1,0x1e8
L_8d0464:
	st_s r0,[r14,0x4]
L_8d0466:
	mov_s r0,r13
L_8d0468:
	bl.d L_8d04fc
L_8d046c:
	mov r1,0x1ec
L_8d0470:
	b.d L_8c0334
L_8d0474:
	st_s r0,[r14,0x8]
L_8d0476:
	nop_s
