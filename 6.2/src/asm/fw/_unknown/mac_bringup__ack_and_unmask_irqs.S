/* mac_bringup__ack_and_unmask_irqs @ 0x8f6b0c, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mac_bringup__ack_and_unmask_irqs
mac_bringup__ack_and_unmask_irqs:
	.global L_8f6b0c
L_8f6b0c:
	mov_s r0,0x1f
L_8f6b0e:
	mov_s r1,0x886800
L_8f6b14:
	st.as r0,[r1,-0xf2]
L_8f6b18:
	st.as r0,[r1,-0xed]
L_8f6b1c:
	mov_s r2,0x886000
L_8f6b22:
	st.as 0xa3ff,[r2,0x84]
L_8f6b2a:
	st.as 0xa3ff,[r2,0x89]
L_8f6b32:
	mov_s r0,0x3
L_8f6b34:
	st.as r0,[r1,-0xbe]
L_8f6b38:
	st.as r0,[r1,-0xb9]
L_8f6b3c:
	mov_s r0,0x7
L_8f6b3e:
	st_s r0,[r1,0x40]
L_8f6b40:
	st_s r0,[r1,0x54]
L_8f6b42:
	mov r0,-0x78
L_8f6b46:
	st_s r0,[r2,0x28]
L_8f6b48:
	j_s [blink]
L_8f6b4a:
	nop_s
