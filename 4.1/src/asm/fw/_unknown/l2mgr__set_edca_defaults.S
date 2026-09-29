/* l2mgr__set_edca_defaults @ 0x8d6724, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr_mac_start_step
 * Зовёт сам: bf_w_s0_w4, edca__set_default_ac_params
 */
	.section .text.l2mgr__set_edca_defaults,"ax",@progbits
	.global l2mgr__set_edca_defaults
l2mgr__set_edca_defaults:
	.global L_8d6724
L_8d6724:
	push_s blink
L_8d6726:
	mov_s r2,r0
L_8d6728:
	mov_s r0,0xc
L_8d672a:
	stb_s r0,[r2,0x12]
L_8d672c:
	mov_s r0,0x12
L_8d672e:
	stb_s r0,[r2,0x13]
L_8d6730:
	mov_s r1,0x0
L_8d6732:
	add r0,r2,0x14
L_8d6736:
	bl L_8e8348
L_8d673a:
	ld_s r0,[r2,0x14]
L_8d673c:
	bic r0,r0,0x30
L_8d6740:
	bic r0,r0,0xc0
L_8d6744:
	st_s r0,[r2,0x14]
L_8d6746:
	stb_s r1,[r2,0x15]
L_8d6748:
	bl.d L_8e1684
L_8d674c:
	mov_s r0,r2
L_8d674e:
	pop_s blink
L_8d6750:
	j_s [blink]
L_8d6752:
	nop_s
