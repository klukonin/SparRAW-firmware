/* uc_res_886f00__acquire @ 0x928f2c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: aw_worker__begin_window, bf__enter_mode3, bf_substate_sm__step, keep_alive__arm_slot
 * Зовёт сам: __ld_r14_to_r13_ret_uc, __st_r14_to_r13_uc, mac__enable_qset_bit7
 */
	.section .text.uc_res_886f00__acquire,"ax",@progbits
	.global uc_res_886f00__acquire
uc_res_886f00__acquire:
	.global L_928f2c
L_928f2c:
	push_s blink
L_928f2e:
	bl L_920214
L_928f32:
	mov_s r14,r0
L_928f34:
	lr r3,[0xa]
L_928f38:
	bclr r0,r3,0x1
L_928f3c:
	flag r0
L_928f40:
	mov_s r13,0x800674
L_928f46:
	ld_s r0,[r13]
L_928f48:
	brne_s r0,0,L_928f52
L_928f4a:
	ld_s r0,[r13,0x4]
L_928f4c:
	cmp_s r0,0x0
L_928f4e:
	bl.eq L_928e38
	.global L_928f52
L_928f52:
	ld_s r0,[r13]
L_928f54:
	bic r3,r3,-0x3
L_928f58:
	bset r0,r0,r14
L_928f5c:
	st_s r0,[r13]
L_928f5e:
	lr r0,[0xa]
L_928f62:
	or_s r3,r3,r0
L_928f64:
	flag r3
L_928f68:
	b L_920284
