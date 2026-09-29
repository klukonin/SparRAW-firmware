/* uc_res_vote__acquire @ 0x928d28, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: keep_alive__arm_slot
 * Зовёт сам: __ld_r13_ret_uc, mac__publish_masks
 * Глобалы (через gp): 0x800554
 */
	.section .text.uc_res_vote__acquire,"ax",@progbits
	.global uc_res_vote__acquire
uc_res_vote__acquire:
	.global L_928d28
L_928d28:
	push_s blink
L_928d2a:
	push_s r13
L_928d2c:
	mov_s r3,r0
L_928d2e:
	lr r13,[0xa]
L_928d32:
	bclr r0,r13,0x1
L_928d36:
	flag r0
L_928d3a:
	ld_s r0,[gp,0x2c]
L_928d3c:
	brne_s r0,0,L_928d4c
L_928d3e:
	ld_s r0,[gp,-0x74]
L_928d40:
	bic r0,r0,0x70
L_928d44:
	bl.d L_9373b0
L_928d48:
	st.as r0,[gp,-0x1d]
	.global L_928d4c
L_928d4c:
	ld_s r0,[gp,0x2c]
L_928d4e:
	bset r0,r0,r3
L_928d52:
	st.as r0,[gp,0xb]
L_928d56:
	mov_s r0,0x81
L_928d58:
	asl_s r0,r0,0x12
L_928d5a:
	mov_s r32,r0
L_928d5c:
	st.ab r0,[r25,0x4]
L_928d60:
	bclr r25,r25,0xa
L_928d64:
	lr r0,[0xa]
L_928d68:
	bic r13,r13,-0x3
L_928d6c:
	or_s r13,r13,r0
L_928d6e:
	flag r13
L_928d72:
	b L_92028c
L_928d76:
	nop_s
