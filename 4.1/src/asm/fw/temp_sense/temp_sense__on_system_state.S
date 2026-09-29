/* temp_sense__on_system_state @ 0x8e38fc, 80 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   temp_sense.cpp
 * Зовут его: L2MGR__system_state_evt_handler
 * Зовёт сам: fw_sysassert_fatal, temp_sense__sample_if_due, temp_sense__stop
 */
	.section .text.temp_sense__on_system_state,"ax",@progbits
	.global temp_sense__on_system_state
temp_sense__on_system_state:
	.global L_8e38fc
L_8e38fc:
	brhs r0,0x17,L_8e3934
L_8e3900:
	ldb.x r0,[0x802240,r0]
L_8e3908:
	add r3,pcl,0x8
L_8e390c:
	add1_s r3,r3,r0
L_8e390e:
	j_s [r3]
L_8e3910:
	cmp_s r2,0x0
L_8e3912:
	cmp.eq r1,0x1
L_8e3916:
	bne_s L_8e3920
L_8e3918:
	mov_s r0,0x0
L_8e391a:
	st.as r0,[gp,-0x1]
L_8e391e:
	b_s L_8e3930
	.global L_8e3920
L_8e3920:
	mov_s r0,0x1
L_8e3922:
	st.as r0,[gp,-0x1]
L_8e3926:
	b_s L_8e392c
L_8e3928:
	ld_s r0,[gp,-0x4]
L_8e392a:
	breq_s r0,0,L_8e3930
	.global L_8e392c
L_8e392c:
	b L_8e25dc
	.global L_8e3930
L_8e3930:
	b L_8e2d9c
	.global L_8e3934
L_8e3934:
	mov_s r0,blink
L_8e3936:
	mov_s r2,0x100fbe4
L_8e393c:
	mov_s r1,0x3001
L_8e3942:
	b.d L_8c82c0
L_8e3946:
	mov_s r3,0xa4
L_8e3948:
	j_s [blink]
L_8e394a:
	nop_s
