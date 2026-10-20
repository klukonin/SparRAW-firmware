/* irq_safe__deref_field_04 @ 0x920d4c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_evt__send_20, uc_evt__send_21, uc_evt__send_22, uc_evt__send_23, uc_evt__send_24, uc_evt__send_25, uc_evt__send_26, uc_evt__send_29_sync, uc_evt__send_2b, uc_evt__send_2c_tsf
 * Зовёт сам: uc_list__head_field4, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global irq_safe__deref_field_04
irq_safe__deref_field_04:
	.global L_920d4c
L_920d4c:
	st.a r13,[sp,-0xc]
L_920d50:
	st blink,[sp, 0x4]
L_920d54:
	st r14,[sp, 0x8]
L_920d58:
	lr r13,[0xa]
L_920d5c:
	bclr r2,r13,0x1
L_920d60:
	flag r2
L_920d64:
	bl.d L_920da4
L_920d68:
	add r0,r0,0x4
L_920d6c:
	mov_s r14,r0
L_920d6e:
	lr r1,[0xa]
L_920d72:
	bic r13,r13,-0x3
L_920d76:
	or_s r13,r13,r1
L_920d78:
	flag r13
L_920d7c:
	cmp r0,0x0
L_920d80:
	bne.d L_920d94
L_920d84:
	add.ne r14,r14,0x10
L_920d88:
	mov r0,blink
L_920d8c:
	bl.d L_926618
L_920d90:
	mov r1,0xc1
	.global L_920d94
L_920d94:
	ld blink,[sp, 0x4]
L_920d98:
	mov_s r0,r14
L_920d9a:
	ld_s r14,[sp,0x8]
L_920d9c:
	j.d [blink]
L_920da0:
	ld.ab r13,[sp,0xc]
