/* bi__after_enter_dti @ 0x92b85c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_sm__action_935d0c
 * Зовёт сам: bi__dti_step, bi__state_from_g800600, uc_read_tsf_lo, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global bi__after_enter_dti
bi__after_enter_dti:
	.global L_92b85c
L_92b85c:
	st.a r13,[sp,-0x8]
L_92b860:
	st blink,[sp, 0x4]
L_92b864:
	bl.d L_9282b4
L_92b868:
	mov r13,r0
L_92b86c:
	brne.d r0,0x1,L_92b88c
L_92b870:
	st r0,[r13, 0x38]
	.global L_92b874
L_92b874:
	bl L_9364c8
L_92b878:
	bl.d L_935d5c
L_92b87c:
	add r0,r13,0x20
L_92b880:
	ld blink,[sp, 0x4]
L_92b884:
	j.d [blink]
L_92b888:
	ld.ab r13,[sp,0x8]
	.global L_92b88c
L_92b88c:
	mov r0,blink
L_92b890:
	bl.d L_926618
L_92b894:
	mov r1,0x62
L_92b898:
	b_s L_92b874
L_92b89a:
	nop_s
