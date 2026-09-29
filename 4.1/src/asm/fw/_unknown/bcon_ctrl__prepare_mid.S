/* bcon_ctrl__prepare_mid @ 0x8f02d4, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_bcon_ctrl
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, l2mgr__config_security, mid__clear_flag_1c9, mid__set_default_dmg_params, mid_list__by_mid
 */
	.section .text.bcon_ctrl__prepare_mid,"ax",@progbits
	.global bcon_ctrl__prepare_mid
bcon_ctrl__prepare_mid:
	.global L_8f02d4
L_8f02d4:
	push_s blink
L_8f02d6:
	bl L_8c02c0
L_8f02da:
	mov_s r14,r1
L_8f02dc:
	bl.d L_8ca1b0
L_8f02e0:
	mov_s r15,r2
L_8f02e2:
	mov_s r13,r0
L_8f02e4:
	add_s r0,r0,0x28
L_8f02e6:
	st_s r14,[r0,0x14]
L_8f02e8:
	breq_s r14,0,L_8f0302
L_8f02ea:
	mov_s r1,0x2
L_8f02ec:
	mov_s r2,0x10
L_8f02ee:
	mov_s r3,0x20
L_8f02f0:
	mov r4,0x1
L_8f02f4:
	bl.d L_8ea510
L_8f02f8:
	mov_s r5,r15
L_8f02fa:
	bl.d L_8c9720
L_8f02fe:
	mov_s r0,r13
L_8f0300:
	b_s L_8f0318
	.global L_8f0302
L_8f0302:
	mov_s r1,0x1
L_8f0304:
	mov_s r2,r1
L_8f0306:
	mov_s r3,r1
L_8f0308:
	mov r4,0x3
L_8f030c:
	bl.d L_8ea510
L_8f0310:
	mov_s r5,r15
L_8f0312:
	bl.d L_8c5b88
L_8f0316:
	mov_s r0,r13
	.global L_8f0318
L_8f0318:
	b L_8c032c
