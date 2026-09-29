/* bi_window_timing_update @ 0x921ce8, 300 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_ap_mon_if__trigger_aw_to_dti, bi_ap_mon_if__trigger_bhi
 * Зовёт сам: bi__tsf_delta64, uc_get_half_0x10, uc_read_tsf64
 */
	.section .text.bi_window_timing_update,"ax",@progbits
	.global bi_window_timing_update
bi_window_timing_update:
	.global L_921ce8
L_921ce8:
	st.a r13,[sp,-0x8]
L_921cec:
	st_s r14,[sp,0x4]
L_921cee:
	mov_s r13,0x801de8
L_921cf4:
	brne.d r0,0x0,L_921d64
L_921cf8:
	mov r14,blink
L_921cfc:
	bl.d L_930cb0
L_921d00:
	add3 r0,r13,0xd
L_921d04:
	ld r0,[r13, 0x44]
L_921d08:
	bl.d L_924544
L_921d0c:
	ld r1,[r13, 0x48]
L_921d10:
	mov r4,0x80088c
L_921d18:
	ldb r2,[r4, 0x50]
L_921d1c:
	ld.as r3,[gp,-0x11]
L_921d20:
	/* asl_s r2,r2,0x3 */
	.byte 0x03,0xba
L_921d22:
	add2_s r2,r2,r2
L_921d24:
	add r4,r4,0x10
L_921d28:
	add_s r2,r2,r4
L_921d2a:
	st_s r0,[r2]
L_921d2c:
	and r3,r3,0xffff0fff
L_921d34:
	bset r0,r3,0xe
L_921d38:
	st.as r0,[gp,-0x11]
L_921d3c:
	or r3,r3,0x1d004000
L_921d44:
	mov r32,r3
L_921d48:
	st.ab r3,[r25,0x4]
L_921d4c:
	bclr r25,r25,0xa
L_921d50:
	nop_s
L_921d52:
	nop_s
L_921d54:
	mov 0x0,0x0
L_921d58:
	bmsk r4,r40,0x19
L_921d5c:
	b.d L_921e08
L_921d60:
	st r4,[r13, 0x7c]
	.global L_921d64
L_921d64:
	ld r0,[r13, 0x68]
L_921d68:
	bl.d L_924544
L_921d6c:
	ld r1,[r13, 0x6c]
L_921d70:
	st_s r0,[r13,0x70]
L_921d72:
	mov_s r0,0x801eb8
L_921d78:
	bl L_926164
L_921d7c:
	ld r10,[r13, 0x70]
L_921d80:
	add3 r0,r0,0x3e8
L_921d84:
	brhs r0,r10,L_921d94
L_921d88:
	ld r5,[r13, 0x74]
L_921d8c:
	add r5,r5,0x1
L_921d90:
	st r5,[r13, 0x74]
	.global L_921d94
L_921d94:
	ld r4,[r13, 0x78]
L_921d98:
	ld_s r1,[r13,0x68]
L_921d9a:
	cmp r4,r10
L_921d9e:
	mov.ls r8,r10
L_921da2:
	mov.hi r8,r4
L_921da6:
	st r8,[r13, 0x78]
L_921daa:
	ld r6,[r13, 0x6c]
L_921dae:
	mov r9,0x80088c
L_921db6:
	st r6,[r9, 0x84]
L_921dba:
	ldb r3,[r9, 0x50]
L_921dbe:
	st r10,[r9, 0x88]
L_921dc2:
	/* asl_s r3,r3,0x3 */
	.byte 0x03,0xbb
L_921dc4:
	add2 r3,r3,r3
L_921dc8:
	add r7,r9,0x10
L_921dcc:
	ld r5,[r7,r3]
L_921dd0:
	ld r6,[r13, 0x4c]
L_921dd4:
	st r1,[r9, 0x80]
L_921dd8:
	sub r6,r6,r5
L_921ddc:
	sub r6,r6,r10
L_921de0:
	st r6,[r9, 0x9c]
L_921de4:
	ld r6,[r13, 0x44]
L_921de8:
	mov r4,0x0
L_921dec:
	ld r11,[r13, 0x48]
L_921df0:
	add.f r5,r5,r6
L_921df4:
	adc r11,r11,r4
L_921df8:
	add.f r10,r10,r5
L_921dfc:
	adc r11,r11,r4
L_921e00:
	st r10,[r9, 0x94]
L_921e04:
	st r11,[r9, 0x98]
	.global L_921e08
L_921e08:
	mov_s blink,r14
L_921e0a:
	ld_s r14,[sp,0x4]
L_921e0c:
	j.d [blink]
L_921e10:
	ld.ab r13,[sp,0x8]
