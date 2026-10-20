/* mid__set_default_dmg_params @ 0x8c9720, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bcon_ctrl__prepare_mid, l2_mgr__connect_setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, bf_w_s2_w2, bf_w_s4_w2
 */
	.section .text.mid__set_default_dmg_params,"ax",@progbits
	.global mid__set_default_dmg_params
mid__set_default_dmg_params:
	.global L_8c9720
L_8c9720:
	push_s blink
L_8c9722:
	bl.d L_8c02c4
L_8c9726:
	add3 r3,r0,0x39
L_8c972a:
	mov_s r0,0x30
L_8c972c:
	stb_s r0,[r3]
L_8c972e:
	mov_s r0,0x14
L_8c9730:
	stb_s r0,[r3,0x1]
L_8c9732:
	mov_s r13,0x1
L_8c9734:
	stw_s r13,[r3,0x2]
L_8c9736:
	mov_s r1,0x0
L_8c9738:
	stb_s r1,[r3,0x4]
L_8c973a:
	mov_s r2,0xf
L_8c973c:
	stb_s r2,[r3,0x5]
L_8c973e:
	mov_s r0,0xac
L_8c9740:
	stb_s r0,[r3,0x6]
L_8c9742:
	mov_s r14,0x8
L_8c9744:
	stb_s r14,[r3,0x7]
L_8c9746:
	stw_s r13,[r3,0x8]
L_8c9748:
	stb_s r1,[r3,0xa]
L_8c974a:
	stb_s r2,[r3,0xb]
L_8c974c:
	stb_s r0,[r3,0xc]
L_8c974e:
	stb_s r14,[r3,0xd]
L_8c9750:
	stw_s r13,[r3,0xe]
L_8c9752:
	stb_s r0,[r3,0x12]
L_8c9754:
	mov_s r0,0x2
L_8c9756:
	stb_s r0,[r3,0x13]
L_8c9758:
	ldb_s r0,[r3,0x15]
L_8c975a:
	stb_s r1,[r3,0x10]
L_8c975c:
	bclr_s r0,r0,0x5
L_8c975e:
	stb_s r0,[r3,0x15]
L_8c9760:
	add r0,r3,0x14
L_8c9764:
	bl.d L_8e84d4
L_8c9768:
	stb_s r2,[r3,0x11]
L_8c976a:
	ldb_s r2,[r3,0x15]
L_8c976c:
	bclr_s r2,r2,0x0
L_8c976e:
	stb_s r2,[r3,0x15]
L_8c9770:
	ld_s r2,[r3,0x14]
L_8c9772:
	bic r2,r2,0xc0
L_8c9776:
	bclr_s r2,r2,0x1
L_8c9778:
	st_s r2,[r3,0x14]
L_8c977a:
	ldb_s r2,[r3,0x15]
L_8c977c:
	bic r2,r2,0x12
L_8c9780:
	stb_s r2,[r3,0x15]
L_8c9782:
	ld_s r2,[r3,0x14]
L_8c9784:
	bclr_s r2,r2,0x0
L_8c9786:
	bl.d L_8e84a4
L_8c978a:
	st_s r2,[r3,0x14]
L_8c978c:
	ldb_s r0,[r3,0x15]
L_8c978e:
	bic r0,r0,0xc
L_8c9792:
	b.d L_8c0334
L_8c9796:
	stb_s r0,[r3,0x15]
