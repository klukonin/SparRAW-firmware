/* obj_vt801adc__ctor @ 0x92aeb4, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_sm__init
 * Зовёт сам: basic_sm__bind_descriptor_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global obj_vt801adc__ctor
obj_vt801adc__ctor:
	.global L_92aeb4
L_92aeb4:
	st.a r13,[sp,-0x8]
L_92aeb8:
	st_s r14,[sp,0x4]
L_92aeba:
	mov_s r14,blink
L_92aebc:
	mov r1,0x801adc
L_92aec4:
	bl.d L_92af0c
L_92aec8:
	mov r13,r0
L_92aecc:
	mov_s r0,0x1
L_92aece:
	stb_s r0,[r13,0x3]
L_92aed0:
	mov_s blink,r14
L_92aed2:
	ld_s r14,[sp,0x4]
L_92aed4:
	j.d [blink]
L_92aed8:
	ld.ab r13,[sp,0x8]
