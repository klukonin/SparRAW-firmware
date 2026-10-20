/* temp_sense__on_system_state @ 0x8e890c, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sys_state__broadcast
 * Зовёт сам: fw_sysassert_fatal, temp_sense__read_and_check, temp_sense__stop
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global temp_sense__on_system_state
temp_sense__on_system_state:
	.global L_8e890c
L_8e890c:
	brhs r0,0x17,L_8e8944
L_8e8910:
	ldb.x r0,[0x8027b4,r0]
L_8e8918:
	add r3,pcl,0x8
L_8e891c:
	add1_s r3,r3,r0
L_8e891e:
	j_s [r3]
L_8e8920:
	cmp_s r2,0x0
L_8e8922:
	cmp.eq r1,0x1
L_8e8926:
	bne_s L_8e8930
L_8e8928:
	mov_s r0,0x0
L_8e892a:
	st.as r0,[gp,-0x4]
L_8e892e:
	b_s L_8e8940
	.global L_8e8930
L_8e8930:
	mov_s r0,0x1
L_8e8932:
	st.as r0,[gp,-0x4]
L_8e8936:
	b_s L_8e893c
L_8e8938:
	ld_s r0,[gp,-0x10]
L_8e893a:
	breq_s r0,0,L_8e8940
	.global L_8e893c
L_8e893c:
	b L_8e7828
	.global L_8e8940
L_8e8940:
	b L_8e7ea4
	.global L_8e8944
L_8e8944:
	mov_s r0,blink
L_8e8946:
	mov_s r1,0x3001
L_8e894c:
	b L_8c9b28
L_8e8950:
	j_s [blink]
L_8e8952:
	nop_s
