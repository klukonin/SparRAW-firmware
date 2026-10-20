/* mid__type_of @ 0x8cabe4, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   mid.cpp
 * Зовут его: l2mgr__publish_assoc_done, mid__setup_bcast_vring, wmi_handler_bcast_vring_cfg
 * Зовёт сам: fw_sysassert_fatal
 */
	.section .text.mid__type_of,"ax",@progbits
	.global mid__type_of
mid__type_of:
	.global L_8cabe4
L_8cabe4:
	push_s blink
L_8cabe6:
	ld_s r0,[r0,0x14]
L_8cabe8:
	cmp_s r0,0x4
L_8cabea:
	beq_s L_8cac16
L_8cabec:
	bgt_s L_8cabf8
L_8cabee:
	breq r0,0x1,L_8cac1c
L_8cabf2:
	breq r0,0x2,L_8cac16
L_8cabf6:
	b_s L_8cac00
	.global L_8cabf8
L_8cabf8:
	breq r0,0x10,L_8cac20
L_8cabfc:
	breq r0,0x20,L_8cac16
	.global L_8cac00
L_8cac00:
	mov_s r0,blink
L_8cac02:
	mov_s r2,0x100aedc
L_8cac08:
	mov_s r1,0x11f5
L_8cac0e:
	bl.d L_8c82c0
L_8cac12:
	mov r3,0x197
	.global L_8cac16
L_8cac16:
	mov_s r0,0x0
	.global L_8cac18
L_8cac18:
	pop_s blink
L_8cac1a:
	j_s [blink]
	.global L_8cac1c
L_8cac1c:
	mov_s r0,0x1
L_8cac1e:
	b_s L_8cac18
	.global L_8cac20
L_8cac20:
	mov_s r0,0x2
L_8cac22:
	b_s L_8cac18
