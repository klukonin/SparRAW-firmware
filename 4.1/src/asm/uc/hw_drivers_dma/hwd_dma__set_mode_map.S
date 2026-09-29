/* hwd_dma__set_mode_map @ 0x926bc0, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_dma.c
 * Зовут его: dma_mac_setup_step
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_dma__set_mode_map,"ax",@progbits
	.global hwd_dma__set_mode_map
hwd_dma__set_mode_map:
	.global L_926bc0
L_926bc0:
	st.a r13,[sp,-0x8]
L_926bc4:
	st_s r14,[sp,0x4]
L_926bc6:
	mov_s r14,blink
L_926bc8:
	mov.f r13,r0
L_926bcc:
	cmp.ne r13,0x1
L_926bd0:
	cmp.ne r13,0x2
L_926bd4:
	beq L_926be0
L_926bd8:
	breq r13,0x3,L_926c38
L_926bdc:
	brne r13,0x4,L_926c38
	.global L_926be0
L_926be0:
	asl r6,r13,0x4
L_926be4:
	or r6,r6,r13
L_926be8:
	asl r5,r13,0x8
L_926bec:
	or r5,r5,r6
L_926bf0:
	asl r4,r13,0xc
L_926bf4:
	or r4,r4,r5
L_926bf8:
	asl r3,r13,0x10
L_926bfc:
	or r3,r3,r4
L_926c00:
	asl r2,r13,0x14
L_926c04:
	or_s r2,r2,r3
L_926c06:
	asl r1,r13,0x18
L_926c0a:
	or_s r1,r1,r2
L_926c0c:
	asl_s r13,r13,0x1c
L_926c0e:
	or_s r1,r1,r13
L_926c10:
	mov r8,0x880800
L_926c18:
	st.as r1,[r8,0xfa]
L_926c1c:
	extb r7,r1
L_926c20:
	st.as r7,[r8,0xfb]
L_926c24:
	bmsk_s r1,r1,0x1b
L_926c26:
	st r1,[0x880c0c]
L_926c2e:
	mov_s blink,r14
L_926c30:
	ld_s r14,[sp,0x4]
L_926c32:
	j_s.d [blink]
L_926c34:
	ld.ab r13,[sp,0x8]
	.global L_926c38
L_926c38:
	mov_s r0,blink
L_926c3a:
	mov_s r2,0x100381c
L_926c40:
	mov r1,0x12dc
L_926c48:
	bl.d L_925548
L_926c4c:
	mov r3,0x1f
L_926c50:
	b_s L_926be0
L_926c52:
	nop_s
