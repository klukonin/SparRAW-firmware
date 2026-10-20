/* bad_beacons_detector__init @ 0x8d90a8, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_loss_detectors__init
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bad_beacons__check_counter, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bad_beacons_detector__init
bad_beacons_detector__init:
	.global L_8d90a8
L_8d90a8:
	push_s blink
L_8d90aa:
	bl L_8c01e0
L_8d90ae:
	mov_s r14,r0
L_8d90b0:
	mov_s r13,r1
L_8d90b2:
	brge.d r1,0x8,L_8d90ca
L_8d90b6:
	mov_s r15,r2
	.global L_8d90b8
L_8d90b8:
	stb_s r13,[r14]
L_8d90ba:
	st_s r15,[r14,0x4]
L_8d90bc:
	mov_s r0,0x0
L_8d90be:
	st_s r0,[r14,0x8]
L_8d90c0:
	bl.d L_8c67bc
L_8d90c4:
	mov_s r0,r14
L_8d90c6:
	b L_8c024c
	.global L_8d90ca
L_8d90ca:
	mov_s r0,blink
L_8d90cc:
	mov_s r1,0x147b
L_8d90d2:
	bl L_8c9b28
L_8d90d6:
	b_s L_8d90b8
