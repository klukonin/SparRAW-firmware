/* calib_cfg__get_scheme @ 0x8cc6bc, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_engine__on_calib_done, calib_mngr__restart_scheme
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global calib_cfg__get_scheme
calib_cfg__get_scheme:
	.global L_8cc6bc
L_8cc6bc:
	push_s blink
L_8cc6be:
	bl L_8c01e0
L_8cc6c2:
	mov_s r14,r0
L_8cc6c4:
	brhs.d r1,0x5,L_8cc6e0
L_8cc6c8:
	mov_s r13,r1
	.global L_8cc6ca
L_8cc6ca:
	mov_s r15,0x0
L_8cc6cc:
	breq_s r14,0,L_8cc6f0
L_8cc6ce:
	breq r14,0x1,L_8cc6ee
L_8cc6d2:
	mov_s r0,blink
L_8cc6d4:
	mov_s r1,0x11c7
L_8cc6da:
	bl L_8c9b28
L_8cc6de:
	b_s L_8cc6f0
	.global L_8cc6e0
L_8cc6e0:
	mov_s r0,blink
L_8cc6e2:
	mov_s r1,0x11c8
L_8cc6e8:
	bl L_8c9b28
L_8cc6ec:
	b_s L_8cc6ca
	.global L_8cc6ee
L_8cc6ee:
	mov_s r15,0x1
	.global L_8cc6f0
L_8cc6f0:
	asl_s r0,r15,0x2
L_8cc6f2:
	add2_s r0,r0,r0
L_8cc6f4:
	add2_s r0,r0,r13
L_8cc6f6:
	mov_s r1,0x800fa8
L_8cc6fc:
	ld_s r0,[r1,r0]
L_8cc6fe:
	mul64 r0,0x4c
L_8cc702:
	add r0,mlo,0x800e2c
L_8cc70a:
	b L_8c024c
L_8cc70e:
	nop_s
