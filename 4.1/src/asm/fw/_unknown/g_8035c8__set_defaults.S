/* g_8035c8__set_defaults @ 0x8e173c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__load_defaults, ps_cfg__load_profile
 * Зовёт сам: __ld_r13_ret, memset0_words
 */
	.section .text.g_8035c8__set_defaults,"ax",@progbits
	.global g_8035c8__set_defaults
g_8035c8__set_defaults:
	.global L_8e173c
L_8e173c:
	push_s blink
L_8e173e:
	push_s r13
L_8e1740:
	mov_s r13,0x8035c8
L_8e1746:
	add r0,r13,0x34
L_8e174a:
	bl.d L_8c1a78
L_8e174e:
	mov_s r1,0x10
L_8e1750:
	add2 r0,r13,0x11
L_8e1754:
	bl.d L_8c1a78
L_8e1758:
	mov_s r1,0x10
L_8e175a:
	ld_s r0,[r13,0x44]
L_8e175c:
	or r0,r0,0x14
L_8e1760:
	bclr_s r0,r0,0x5
L_8e1762:
	and r0,r0,0xfffff53f
L_8e176a:
	or r0,r0,0x8e0
L_8e1772:
	st_s r0,[r13,0x44]
L_8e1774:
	ld_s r0,[r13,0x48]
L_8e1776:
	or r0,r0,0xd
L_8e177a:
	st_s r0,[r13,0x48]
L_8e177c:
	ld_s r0,[r13,0x50]
L_8e177e:
	or r0,r0,0x1f
L_8e1782:
	st_s r0,[r13,0x50]
L_8e1784:
	ld_s r0,[r13,0x34]
L_8e1786:
	or r0,r0,0x14
L_8e178a:
	bclr_s r0,r0,0x5
L_8e178c:
	and r0,r0,0xffffe2bf
L_8e1794:
	or r0,r0,0x1d60
L_8e179c:
	st_s r0,[r13,0x34]
L_8e179e:
	ld_s r0,[r13,0x38]
L_8e17a0:
	or r0,r0,0xd
L_8e17a4:
	st_s r0,[r13,0x38]
L_8e17a6:
	ld_s r0,[r13,0x40]
L_8e17a8:
	or r0,r0,0x1f
L_8e17ac:
	b.d L_8c033c
L_8e17b0:
	st_s r0,[r13,0x40]
L_8e17b2:
	nop_s
