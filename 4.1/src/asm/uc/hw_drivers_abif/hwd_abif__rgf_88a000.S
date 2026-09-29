/* hwd_abif__rgf_88a000 @ 0x926a58, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: dma_mac_substep
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_abif__rgf_88a000,"ax",@progbits
	.global hwd_abif__rgf_88a000
hwd_abif__rgf_88a000:
	.global L_926a58
L_926a58:
	st.a r13,[sp,-0xc]
L_926a5c:
	st_s r14,[sp,0x8]
L_926a5e:
	mov_s r14,r0
L_926a60:
	bclr.f r0,r0,0x0
L_926a64:
	st blink,[sp, 0x4]
L_926a68:
	bne.d L_926aa0
L_926a6c:
	mov r13,r1
	.global L_926a70
L_926a70:
	bic.f 0x0,r13,0x3f
L_926a74:
	bne L_926ab8
	.global L_926a78
L_926a78:
	mov_s r2,0x88a000
L_926a7e:
	ld.as r1,[r2,0x81]
L_926a82:
	asl_s r13,r13
L_926a84:
	bclr_s r1,r1,0x0
L_926a86:
	or_s r1,r1,r14
L_926a88:
	bic r1,r1,0x7e
L_926a8c:
	or_s r13,r13,r1
L_926a8e:
	st.as r13,[r2,0x81]
L_926a92:
	ld blink,[sp, 0x4]
L_926a96:
	ld_s r14,[sp,0x8]
L_926a98:
	j.d [blink]
L_926a9c:
	ld.ab r13,[sp,0xc]
	.global L_926aa0
L_926aa0:
	mov_s r0,blink
L_926aa2:
	mov_s r2,0x10039c8
L_926aa8:
	mov r1,0xad
L_926aac:
	bl.d L_925548
L_926ab0:
	mov r3,0x254
L_926ab4:
	b L_926a70
	.global L_926ab8
L_926ab8:
	mov_s r0,blink
L_926aba:
	mov_s r2,0x10039c8
L_926ac0:
	mov r1,0xae
L_926ac4:
	bl.d L_925548
L_926ac8:
	mov r3,0x254
L_926acc:
	b_s L_926a78
L_926ace:
	nop_s
