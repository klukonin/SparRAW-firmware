/* uc_res_vote__acquire @ 0x92bac8, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: keep_alive__arm_slot, ps__hold_awake_for_sta, ucode_cmd_2d__set_bit
 * Зовёт сам: __ld_r13_to_r13_ret, mac__publish_masks
 * Глобалы (через gp): 0x800550
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_res_vote__acquire
uc_res_vote__acquire:
	.global L_92bac8
L_92bac8:
	push_s blink
L_92baca:
	push_s r13
L_92bacc:
	mov_s r3,r0
L_92bace:
	lr r13,[0xa]
L_92bad2:
	bclr r0,r13,0x1
L_92bad6:
	flag r0
L_92bada:
	ld_s r0,[gp,0x28]
L_92badc:
	brne_s r0,0,L_92baec
L_92bade:
	ld_s r0,[gp,-0x7c]
L_92bae0:
	bic r0,r0,0x70
L_92bae4:
	bl.d L_93d0ac
L_92bae8:
	st.as r0,[gp,-0x1f]
	.global L_92baec
L_92baec:
	ld_s r0,[gp,0x28]
L_92baee:
	bset r0,r0,r3
L_92baf2:
	st.as r0,[gp,0xa]
L_92baf6:
	mov_s r0,0x81
L_92baf8:
	asl_s r0,r0,0x12
L_92bafa:
	mov_s r32,r0
L_92bafc:
	st.ab r0,[r25,0x4]
L_92bb00:
	bclr r25,r25,0xa
L_92bb04:
	lr r0,[0xa]
L_92bb08:
	bic r13,r13,-0x3
L_92bb0c:
	or_s r13,r13,r0
L_92bb0e:
	flag r13
L_92bb12:
	b L_9202ac
L_92bb16:
	nop_s
