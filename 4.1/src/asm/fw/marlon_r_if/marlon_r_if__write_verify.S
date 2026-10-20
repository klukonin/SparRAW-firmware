/* marlon_r_if__write_verify @ 0x8e8014, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   RF retry in write verify for add=0x%x retry=%d
 *        MARLON-R: discovered mismatch on address [0x%x]. Expected[0x%x], read[0x%x]
 *   marlon_r_if.cpp
 * Зовут его: marlon_r_if__write_reg
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit2, fw_log__emit3, sys__assert_no_error, tail_hwd_rfc_read_rgf, tail_rfc_field_write
 * Глобалы (через gp): 0x8003cc, 0x8003d0, 0x8003d4
 */
	.section .text.marlon_r_if__write_verify,"ax",@progbits
	.global marlon_r_if__write_verify
marlon_r_if__write_verify:
	.global L_8e8014
L_8e8014:
	push_s blink
L_8e8016:
	bl L_8c02b0
L_8e801a:
	mov_s r19,r0
L_8e801c:
	mov_s r18,r1
L_8e801e:
	mov_s r14,r2
L_8e8020:
	mov_s r17,r3
L_8e8022:
	mov_s r13,r4
L_8e8024:
	mov r16,0x0
L_8e8028:
	b_s L_8e802c
	.global L_8e802a
L_8e802a:
	mov_s r16,r0
	.global L_8e802c
L_8e802c:
	breq r16,0x0,L_8e8044
L_8e8030:
	mov_s r2,0x1004ff4
L_8e8036:
	mov_s r0,0x0
L_8e8038:
	mov_s r1,0x1
L_8e803a:
	mov_s r3,r14
L_8e803c:
	bl.d L_8edff8
L_8e8040:
	mov r4,r16
	.global L_8e8044
L_8e8044:
	mov_s r0,r19
L_8e8046:
	mov_s r1,r18
L_8e8048:
	mov_s r2,r14
L_8e804a:
	bl.d L_8e8008
L_8e804e:
	mov_s r3,r17
L_8e8050:
	mov_s r0,r19
L_8e8052:
	mov_s r1,r18
L_8e8054:
	bl.d L_8ddd74
L_8e8058:
	mov_s r2,r14
L_8e805a:
	mov_s r5,r0
L_8e805c:
	add r0,r16,0x1
L_8e8060:
	brhs r0,r13,L_8e8068
L_8e8064:
	brne r17,r5,L_8e802a
	.global L_8e8068
L_8e8068:
	ld_s r0,[gp,0x264]
L_8e806a:
	add_s r0,r0,r16
L_8e806c:
	st.as r0,[gp,0x99]
L_8e8070:
	breq r17,r5,L_8e80a6
L_8e8074:
	ld_s r0,[gp,0x260]
L_8e8076:
	st.as r14,[gp,0x97]
L_8e807a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8e807c:
	st.as r0,[gp,0x98]
L_8e8080:
	mov_s r2,0x1005024
L_8e8086:
	mov_s r0,0x0
L_8e8088:
	mov_s r1,r0
L_8e808a:
	mov_s r3,r14
L_8e808c:
	bl.d L_8ee034
L_8e8090:
	mov r4,r17
L_8e8094:
	mov_s r0,blink
L_8e8096:
	mov_s r2,0x1005078
L_8e809c:
	mov_s r1,0x44
L_8e809e:
	bset_s r1,r1,0xc
L_8e80a0:
	bl.d L_8c8208
L_8e80a4:
	mov_s r3,0x9e
	.global L_8e80a6
L_8e80a6:
	.byte 0x69,0x02
