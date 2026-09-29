/* mid__set_default_dmg_params @ 0x8cb728, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_ctrl__prepare_mid_fw, l2_mgr__connect_setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bits__set32_s2_w2, bits__set32_s4_w2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__set_default_dmg_params
mid__set_default_dmg_params:
	.global L_8cb728
L_8cb728:
	push_s blink
L_8cb72a:
	bl.d L_8c01e4
L_8cb72e:
	add3 r3,r0,0x39
L_8cb732:
	mov_s r0,0x30
L_8cb734:
	stb_s r0,[r3]
L_8cb736:
	mov_s r0,0x14
L_8cb738:
	stb_s r0,[r3,0x1]
L_8cb73a:
	mov_s r13,0x1
L_8cb73c:
	stw_s r13,[r3,0x2]
L_8cb73e:
	mov_s r1,0x0
L_8cb740:
	stb_s r1,[r3,0x4]
L_8cb742:
	mov_s r2,0xf
L_8cb744:
	stb_s r2,[r3,0x5]
L_8cb746:
	mov_s r0,0xac
L_8cb748:
	stb_s r0,[r3,0x6]
L_8cb74a:
	mov_s r14,0x8
L_8cb74c:
	stb_s r14,[r3,0x7]
L_8cb74e:
	stw_s r13,[r3,0x8]
L_8cb750:
	stb_s r1,[r3,0xa]
L_8cb752:
	stb_s r2,[r3,0xb]
L_8cb754:
	stb_s r0,[r3,0xc]
L_8cb756:
	stb_s r14,[r3,0xd]
L_8cb758:
	stw_s r13,[r3,0xe]
L_8cb75a:
	stb_s r0,[r3,0x12]
L_8cb75c:
	mov_s r0,0x2
L_8cb75e:
	stb_s r0,[r3,0x13]
L_8cb760:
	ldb_s r0,[r3,0x15]
L_8cb762:
	stb_s r1,[r3,0x10]
L_8cb764:
	bclr_s r0,r0,0x5
L_8cb766:
	stb_s r0,[r3,0x15]
L_8cb768:
	add r0,r3,0x14
L_8cb76c:
	bl.d L_8ed4fc
L_8cb770:
	stb_s r2,[r3,0x11]
L_8cb772:
	ldb_s r2,[r3,0x15]
L_8cb774:
	bclr_s r2,r2,0x0
L_8cb776:
	stb_s r2,[r3,0x15]
L_8cb778:
	ld_s r2,[r3,0x14]
L_8cb77a:
	bic r2,r2,0xc0
L_8cb77e:
	bclr_s r2,r2,0x1
L_8cb780:
	st_s r2,[r3,0x14]
L_8cb782:
	ldb_s r2,[r3,0x15]
L_8cb784:
	bic r2,r2,0x12
L_8cb788:
	stb_s r2,[r3,0x15]
L_8cb78a:
	ld_s r2,[r3,0x14]
L_8cb78c:
	bclr_s r2,r2,0x0
L_8cb78e:
	bl.d L_8ed4cc
L_8cb792:
	st_s r2,[r3,0x14]
L_8cb794:
	ldb_s r0,[r3,0x15]
L_8cb796:
	bic r0,r0,0xc
L_8cb79a:
	b.d L_8c0254
L_8cb79e:
	stb_s r0,[r3,0x15]
