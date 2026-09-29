/* aw__start_window @ 0x935ae4, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__after_enter_aw
 * Зовёт сам: aw__open_event_mask, aw_worker__collect_awake_peers, internal_tx__check_idle, sxd_hal__write_qset_field
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global aw__start_window
aw__start_window:
	.global L_935ae4
L_935ae4:
	st.a r13,[sp,-0x10]
L_935ae8:
	st blink,[sp, 0x4]
L_935aec:
	mov_s r13,r0
L_935aee:
	ldb r0,[0x857264]
L_935af6:
	st_s r15,[sp,0xc]
L_935af8:
	st r14,[sp, 0x8]
L_935afc:
	breq.d r0,0x0,L_935b10
L_935b00:
	mov_s r15,r1
L_935b02:
	mov_s r1,0x5a
L_935b04:
	asl_s r1,r1,0x18
L_935b06:
	mov_s r32,r1
L_935b08:
	st.ab r1,[r25,0x4]
L_935b0c:
	bclr r25,r25,0xa
	.global L_935b10
L_935b10:
	mov r14,0x0
L_935b14:
	bl.d L_92bd30
L_935b18:
	mov r0,r14
L_935b1c:
	mov r0,r14
L_935b20:
	bl.d L_934f54
L_935b24:
	ld r1,[r13, 0xc]
L_935b28:
	bl L_921450
L_935b2c:
	stb_s r14,[r13,0x4]
L_935b2e:
	stb_s r14,[r13,0x5]
L_935b30:
	mov r0,r13
L_935b34:
	bl.d L_927a44
L_935b38:
	mov r1,r15
L_935b3c:
	ld blink,[sp, 0x4]
L_935b40:
	st_s r14,[r13,0x8]
L_935b42:
	ld_s r14,[sp,0x8]
L_935b44:
	ld_s r15,[sp,0xc]
L_935b46:
	j_s.d [blink]
L_935b48:
	ld.ab r13,[sp,0x10]
