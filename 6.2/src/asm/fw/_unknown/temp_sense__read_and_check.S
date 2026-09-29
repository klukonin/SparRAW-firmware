/* temp_sense__read_and_check @ 0x8e7828, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: temp_sense__on_system_state
 * Зовёт сам: __ld_r13_to_r13_ret, channels_switch__check_g80017c, platform__is_asic, u_schd__now
 * Глобалы (через gp): 0x8002c8
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global temp_sense__read_and_check
temp_sense__read_and_check:
	.global L_8e7828
L_8e7828:
	push_s blink
L_8e782a:
	bl.d L_8da61c
L_8e782e:
	push_s r13
L_8e7830:
	breq_s r0,0,L_8e7876
L_8e7832:
	ld_s r0,[gp,0x144]
L_8e7834:
	brne_s r0,0,L_8e7876
L_8e7836:
	mov_s r0,0x0
L_8e7838:
	bl.d L_8e9524
L_8e783c:
	st.as r0,[gp,-0xd]
L_8e7840:
	ld.as r2,[gp,-0x24]
L_8e7844:
	ld.as r13,[gp,-0x59]
L_8e7848:
	sub_s r0,r0,r2
L_8e784a:
	asl_s r1,r0,0x4
L_8e784c:
	ld_s r0,[gp,-0x158]
L_8e784e:
	sub r3,r13,r1
L_8e7852:
	brne r0,0x3,L_8e785c
L_8e7856:
	mov_s r0,0x1
L_8e7858:
	st.as r0,[gp,-0x57]
	.global L_8e785c
L_8e785c:
	cmp r2,-0x1
L_8e7860:
	ld_s r0,[gp,-0x160]
L_8e7862:
	beq_s L_8e7872
L_8e7864:
	brhs r1,r13,L_8e7872
L_8e7868:
	brlo r3,0x11,L_8e7872
L_8e786c:
	cmp_s r0,r3
L_8e786e:
	mov.ls r0,r3
	.global L_8e7872
L_8e7872:
	bl L_8e494c
	.global L_8e7876
L_8e7876:
	b L_8c025c
L_8e787a:
	nop_s
