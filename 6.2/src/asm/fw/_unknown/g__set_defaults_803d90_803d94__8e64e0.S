/* g__set_defaults_803d90_803d94__8e64e0 @ 0x8e64e0, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_mngr__load_defaults, ps_cfg__apply_profile_0
 * Зовёт сам: __ld_r13_to_r13_ret, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global g__set_defaults_803d90_803d94__8e64e0
g__set_defaults_803d90_803d94__8e64e0:
	.global L_8e64e0
L_8e64e0:
	push_s blink
L_8e64e2:
	push_s r13
L_8e64e4:
	mov_s r13,0x803d5c
L_8e64ea:
	add r0,r13,0x34
L_8e64ee:
	bl.d L_8c1cd8
L_8e64f2:
	mov_s r1,0x10
L_8e64f4:
	add2 r0,r13,0x11
L_8e64f8:
	bl.d L_8c1cd8
L_8e64fc:
	mov_s r1,0x10
L_8e64fe:
	ld_s r0,[r13,0x44]
L_8e6500:
	or r0,r0,0x14
L_8e6504:
	bclr_s r0,r0,0x5
L_8e6506:
	and r0,r0,0xfffff53f
L_8e650e:
	or r0,r0,0x8e0
L_8e6516:
	st_s r0,[r13,0x44]
L_8e6518:
	ld_s r0,[r13,0x48]
L_8e651a:
	or r0,r0,0xd
L_8e651e:
	st_s r0,[r13,0x48]
L_8e6520:
	ld_s r0,[r13,0x50]
L_8e6522:
	or r0,r0,0x1f
L_8e6526:
	st_s r0,[r13,0x50]
L_8e6528:
	ld_s r0,[r13,0x34]
L_8e652a:
	or r0,r0,0x14
L_8e652e:
	bclr_s r0,r0,0x5
L_8e6530:
	and r0,r0,0xffffe2bf
L_8e6538:
	or r0,r0,0x1d60
L_8e6540:
	st_s r0,[r13,0x34]
L_8e6542:
	ld_s r0,[r13,0x38]
L_8e6544:
	or r0,r0,0xd
L_8e6548:
	st_s r0,[r13,0x38]
L_8e654a:
	ld_s r0,[r13,0x40]
L_8e654c:
	or r0,r0,0x1f
L_8e6550:
	b.d L_8c025c
L_8e6554:
	st_s r0,[r13,0x40]
L_8e6556:
	nop_s
