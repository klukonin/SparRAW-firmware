/* mid__update_aw_ie @ 0x8c3a04, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   PCP AP Update AW IE - TBTT: %x. Current AW: %d, Next AW: %d
 * Зовут его: power_mngr__recalc_aw
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, add_bcon, fw_log_emit3, fw_sysassert_fatal, mac__tsf_lo_after_n_bi, mid__get_aw_len, mid__set_awake_window
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global mid__update_aw_ie
mid__update_aw_ie:
	.global L_8c3a04
L_8c3a04:
	push_s blink
L_8c3a06:
	bl L_8c01d8
L_8c3a0a:
	cmp r1,0x9d
L_8c3a0e:
	mov_s r13,r0
L_8c3a10:
	mov_s r16,r2
L_8c3a12:
	beq_s L_8c3a22
L_8c3a14:
	mov_s r0,blink
L_8c3a16:
	mov_s r1,0x1229
L_8c3a1c:
	bl L_8c9b28
L_8c3a20:
	b_s L_8c3a56
	.global L_8c3a22
L_8c3a22:
	bl.d L_8e9874
L_8c3a26:
	mov_s r0,0x0
L_8c3a28:
	mov_s r17,r0
L_8c3a2a:
	bl.d L_8cb914
L_8c3a2e:
	mov_s r0,r13
L_8c3a30:
	mov_s r3,r0
L_8c3a32:
	mov_s r1,0x100c43c
L_8c3a38:
	mov_s r0,0x2b
L_8c3a3a:
	mov_s r2,r17
L_8c3a3c:
	bl.d L_8dcd00
L_8c3a40:
	mov r4,r16
L_8c3a44:
	extw r1,r16
L_8c3a48:
	mov_s r0,r13
L_8c3a4a:
	bl.d L_8e62f0
L_8c3a4e:
	mov_s r2,r17
L_8c3a50:
	bl.d L_8c2778
L_8c3a54:
	ld_s r0,[r13]
	.global L_8c3a56
L_8c3a56:
	b L_8c023c
L_8c3a5a:
	nop_s
