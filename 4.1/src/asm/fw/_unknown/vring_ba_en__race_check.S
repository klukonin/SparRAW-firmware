/* vring_ba_en__race_check @ 0x8c3884, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FW-DRIVER race. WMI_VRING_BA_EN_CMD for vring: %d, after disconnect - ignoring
 * Зовут его: wmi_handler_vring_ba_en
 * Зовёт сам: __ld_r13_ret, fw_log__emit1, ul_stream__ba_sm_evt
 */
	.section .text.vring_ba_en__race_check,"ax",@progbits
	.global vring_ba_en__race_check
vring_ba_en__race_check:
	.global L_8c3884
L_8c3884:
	push_s blink
L_8c3886:
	push_s r13
L_8c3888:
	mov_s r13,r0
L_8c388a:
	mov_s r0,0x8485dc
L_8c3890:
	sub3 r0,r0,0x100
L_8c3894:
	add2_s r0,r0,r13
L_8c3896:
	ld r0,[r0,0x818]
L_8c389e:
	mov_s r5,r2
L_8c38a0:
	mov_s r6,r1
L_8c38a2:
	mov_s r4,r3
L_8c38a4:
	brne_s r0,0,L_8c38b8
L_8c38a6:
	mov_s r2,0x100e8f0
L_8c38ac:
	mov_s r0,0xb
L_8c38ae:
	mov_s r1,0x2
L_8c38b0:
	bl.d L_8edfcc
L_8c38b4:
	mov_s r3,r13
L_8c38b6:
	b_s L_8c38c8
	.global L_8c38b8
L_8c38b8:
	mov_s r1,0x1
L_8c38ba:
	st r1,[r0, 0xc0]
L_8c38be:
	mov_s r1,0x0
L_8c38c0:
	mov_s r2,r6
L_8c38c2:
	bl.d L_8d6afc
L_8c38c6:
	mov_s r3,r5
	.global L_8c38c8
L_8c38c8:
	b L_8c033c
