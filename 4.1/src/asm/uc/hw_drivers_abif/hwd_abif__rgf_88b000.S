/* hwd_abif__rgf_88b000 @ 0x926a10, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_abif.c
 * Зовут его: dma_mac_substep
 * Зовёт сам: uc_sysassert
 */
	.section .text.hwd_abif__rgf_88b000,"ax",@progbits
	.global hwd_abif__rgf_88b000
hwd_abif__rgf_88b000:
	.global L_926a10
L_926a10:
	st.a r13,[sp,-0x8]
L_926a14:
	mov_s r13,r0
L_926a16:
	bclr.f r0,r0,0x0
L_926a1a:
	st_s r14,[sp,0x4]
L_926a1c:
	bne.d L_926a40
L_926a20:
	mov r14,blink
	.global L_926a24
L_926a24:
	mov_s r2,0x88b000
L_926a2a:
	ld.as r1,[r2,-0x7e]
L_926a2e:
	mov_s blink,r14
L_926a30:
	bclr_s r1,r1,0x0
L_926a32:
	or_s r13,r13,r1
L_926a34:
	st.as r13,[r2,-0x7e]
L_926a38:
	ld_s r14,[sp,0x4]
L_926a3a:
	j_s.d [blink]
L_926a3c:
	ld.ab r13,[sp,0x8]
	.global L_926a40
L_926a40:
	mov_s r0,blink
L_926a42:
	mov_s r2,0x10039c8
L_926a48:
	mov r1,0xac
L_926a4c:
	bl.d L_925548
L_926a50:
	mov r3,0x1c4
L_926a54:
	b_s L_926a24
L_926a56:
	nop_s
