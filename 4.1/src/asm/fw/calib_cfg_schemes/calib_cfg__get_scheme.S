/* calib_cfg__get_scheme @ 0x8ca4a4, 100 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   calib_cfg_schemes.c
 * Зовут его: calib_mngr__log_scheme, calib_mngr__reset_scheme, calib_mngr__restart_scheme
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.calib_cfg__get_scheme,"ax",@progbits
	.global calib_cfg__get_scheme
calib_cfg__get_scheme:
	.global L_8ca4a4
L_8ca4a4:
	push_s blink
L_8ca4a6:
	bl L_8c02c0
L_8ca4aa:
	mov_s r14,r0
L_8ca4ac:
	brhs.d r1,0x4,L_8ca4d2
L_8ca4b0:
	mov_s r13,r1
	.global L_8ca4b2
L_8ca4b2:
	mov_s r15,0x0
L_8ca4b4:
	breq_s r14,0,L_8ca4ec
L_8ca4b6:
	breq r14,0x1,L_8ca4ea
L_8ca4ba:
	mov_s r0,blink
L_8ca4bc:
	mov_s r2,0x1008ab0
L_8ca4c2:
	mov_s r1,0x11c7
L_8ca4c8:
	bl.d L_8c82c0
L_8ca4cc:
	mov r3,0x250
L_8ca4d0:
	b_s L_8ca4ec
	.global L_8ca4d2
L_8ca4d2:
	mov_s r0,blink
L_8ca4d4:
	mov_s r2,0x1008ab0
L_8ca4da:
	mov_s r1,0x11c8
L_8ca4e0:
	bl.d L_8c82c0
L_8ca4e4:
	mov r3,0x244
L_8ca4e8:
	b_s L_8ca4b2
	.global L_8ca4ea
L_8ca4ea:
	mov_s r15,0x1
	.global L_8ca4ec
L_8ca4ec:
	/* asl_s r15,r15,0x4 */
	.byte 0x04,0xbf
L_8ca4ee:
	mov_s r0,0x800f0c
L_8ca4f4:
	add2_s r15,r15,r13
L_8ca4f6:
	ld_s r0,[r0,r15]
L_8ca4f8:
	mul64 r0,0x4c
L_8ca4fc:
	add r0,mlo,0x800ddc
L_8ca504:
	b L_8c032c
