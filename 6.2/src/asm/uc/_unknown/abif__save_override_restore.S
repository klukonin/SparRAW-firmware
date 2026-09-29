/* abif__save_override_restore @ 0x929d20, 392 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: internal_tx__flow_sm4, l1_task__check_ready, rx_funcs__rx_flow
 * Зовёт сам: uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global abif__save_override_restore
abif__save_override_restore:
	.global L_929d20
L_929d20:
	st.a r13,[sp,-0x14]
L_929d24:
	st blink,[sp, 0x4]
L_929d28:
	st_s r14,[sp,0x8]
L_929d2a:
	st_s r15,[sp,0xc]
L_929d2c:
	st r16,[sp, 0x10]
L_929d30:
	mov_s r16,r3
L_929d32:
	mov r5,0x80071c
L_929d3a:
	mov_s r14,0x883000
L_929d40:
	mov r13,0x88b000
L_929d48:
	breq.d r0,0x0,L_929e1c
L_929d4c:
	mov_s r15,r4
L_929d4e:
	ld r4,[r5]
L_929d52:
	add r4,r4,0x1
L_929d56:
	st r4,[r5]
L_929d5a:
	ld.as r0,[r14,0x5f]
L_929d5e:
	st_s r0,[r1]
L_929d60:
	ld.as r10,[r13,-0x67]
L_929d64:
	st r10,[r1, 0x4]
L_929d68:
	ld.as r9,[r13,-0x69]
L_929d6c:
	st r9,[r1, 0x8]
L_929d70:
	ld.as r8,[r13,-0x66]
L_929d74:
	st r8,[r1, 0xc]
L_929d78:
	ld.as r7,[r13,-0x7b]
L_929d7c:
	st r7,[r1, 0x10]
L_929d80:
	ld.as r6,[r13,-0x7c]
L_929d84:
	add r7,r1,0x14
L_929d88:
	st r6,[r7]
L_929d8c:
	ld.as r5,[r13,-0x7a]
L_929d90:
	brne.d r2,0x7,L_929e0c
L_929d94:
	st r5,[r1, 0x18]
	.global L_929d98
L_929d98:
	mov r9,0x1
L_929d9c:
	st.as r9,[r14,0x5f]
L_929da0:
	st.as 0x3cfc,[r13,-0x67]
L_929da8:
	st.as 0x3cfc,[r13,-0x69]
L_929db0:
	st.as 0x38fc,[r13,-0x66]
L_929db8:
	st.as 0x1f87,[r13,-0x7b]
L_929dc0:
	st.as 0x1f87,[r13,-0x7c]
L_929dc8:
	st.as 0x1f7f,[r13,-0x7a]
L_929dd0:
	mov_s r1,0x889800
L_929dd6:
	st.as r16,[r1,-0xae]
L_929dda:
	st.as r15,[r1,-0xac]
L_929dde:
	st.as 0x20001,[r1,-0xb6]
L_929de6:
	st.as 0x10100,[r1,-0xb4]
L_929dee:
	nop_s
L_929df0:
	nop_s
L_929df2:
	mov r8,0x0
L_929df6:
	st.as r8,[r1,-0xb4]
L_929dfa:
	ld blink,[sp, 0x4]
L_929dfe:
	ld_s r14,[sp,0x8]
L_929e00:
	ld_s r15,[sp,0xc]
L_929e02:
	ld r16,[sp, 0x10]
L_929e06:
	j_s.d [blink]
L_929e08:
	ld.ab r13,[sp,0x14]
	.global L_929e0c
L_929e0c:
	mov_s r0,blink
L_929e0e:
	mov_s r1,0x144c
L_929e14:
	bl L_926618
L_929e18:
	b L_929d98
	.global L_929e1c
L_929e1c:
	ld r3,[r5, 0x4]
L_929e20:
	mov r7,0x889800
L_929e28:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_929e2a:
	st r3,[r5, 0x4]
L_929e2e:
	st.as 0x20000,[r7,-0xb6]
L_929e36:
	ld r11,[r1]
L_929e3a:
	add r0,r1,0x14
L_929e3e:
	st.as r11,[r14,0x5f]
L_929e42:
	ld r5,[r1, 0x4]
L_929e46:
	st.as r5,[r13,-0x67]
L_929e4a:
	ld r6,[r1, 0x8]
L_929e4e:
	st.as r6,[r13,-0x69]
L_929e52:
	ld r10,[r1, 0xc]
L_929e56:
	st.as r10,[r13,-0x66]
L_929e5a:
	ld r11,[r1, 0x10]
L_929e5e:
	st.as r11,[r13,-0x7b]
L_929e62:
	ld_s r3,[r0]
L_929e64:
	st.as r3,[r13,-0x7c]
L_929e68:
	ld r4,[r1, 0x18]
L_929e6c:
	st.as r4,[r13,-0x7a]
L_929e70:
	brne r2,0x7,L_929e88
L_929e74:
	ld blink,[sp, 0x4]
L_929e78:
	ld_s r14,[sp,0x8]
L_929e7a:
	ld_s r15,[sp,0xc]
L_929e7c:
	ld r16,[sp, 0x10]
L_929e80:
	j.d [blink]
L_929e84:
	ld.ab r13,[sp,0x14]
	.global L_929e88
L_929e88:
	mov_s r0,blink
L_929e8a:
	mov_s r1,0x144d
L_929e90:
	bl L_926618
L_929e94:
	ld blink,[sp, 0x4]
L_929e98:
	ld_s r14,[sp,0x8]
L_929e9a:
	ld_s r15,[sp,0xc]
L_929e9c:
	ld r16,[sp, 0x10]
L_929ea0:
	j.d [blink]
L_929ea4:
	ld.ab r13,[sp,0x14]
