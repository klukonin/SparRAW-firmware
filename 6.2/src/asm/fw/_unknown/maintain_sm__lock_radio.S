/* maintain_sm__lock_radio @ 0x8e2904, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: link_stats__report, maintain_sm__action_8cab64, maintain_sm__action_8dcf84, maintain_sm__action_8f96c4
 * Зовёт сам: __ld_r13_to_r13_ret, l2_mgr__connect_args, maintain_sm__get_mid_idx
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global maintain_sm__lock_radio
maintain_sm__lock_radio:
	.global L_8e2904
L_8e2904:
	push_s blink
L_8e2906:
	push_s r13
L_8e2908:
	mov_s r13,r0
L_8e290a:
	ld_s r0,[r0,0x24]
L_8e290c:
	brne_s r0,0,L_8e2928
L_8e290e:
	bl.d L_8cc3d4
L_8e2912:
	ld_s r0,[r13,0x8]
L_8e2914:
	extb_s r2,r0
L_8e2916:
	mov_s r0,0x5e48
L_8e291c:
	bl.d L_8dca38
L_8e2920:
	mov_s r1,r13
L_8e2922:
	st_s r0,[r13,0x24]
L_8e2924:
	mov_s r0,0x0
L_8e2926:
	st_s r0,[r13,0x28]
	.global L_8e2928
L_8e2928:
	b L_8c025c
