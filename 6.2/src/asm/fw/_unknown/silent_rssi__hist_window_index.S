/* silent_rssi__hist_window_index @ 0x8dde0c, 292 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: calib_silent_rssi_sparrow__find_agc_start, calib_silent_rssi_sparrow__find_rf_gain
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, hwd_abif__rx_table_index_force_mode, memset0_words, rf_comm_test
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global silent_rssi__hist_window_index
silent_rssi__hist_window_index:
	.global L_8dde0c
L_8dde0c:
	push_s blink
L_8dde0e:
	bl L_8c01e0
L_8dde12:
	mov_s r14,r0
L_8dde14:
	mov_s r13,r1
L_8dde16:
	add_s r0,r0,0x74
L_8dde18:
	bl.d L_8c1cd8
L_8dde1c:
	mov_s r1,0x40
L_8dde1e:
	extb_s r13,r13
L_8dde20:
	mov_s r15,0x0
L_8dde22:
	mov_s r0,r15
L_8dde24:
	bl.d L_8cf5a8
L_8dde28:
	mov_s r1,r13
L_8dde2a:
	mov_s r0,0x1
L_8dde2c:
	bl.d L_8cf5a8
L_8dde30:
	mov_s r1,r13
L_8dde32:
	ldw r0,[r14, 0xbe]
L_8dde36:
	add3 r13,r14,0x8
L_8dde3a:
	bbit0 r0,0x0,L_8ddec8
L_8dde3e:
	b_s L_8dde6a
	.global L_8dde40
L_8dde40:
	mov_s r0,0x14
L_8dde42:
	mov lp_count,r0
L_8dde46:
	nop_s
L_8dde48:
	lp L_8dde50
L_8dde4c:
	nop_s
L_8dde4e:
	nop_s
	.global L_8dde50
L_8dde50:
	mov_s r0,0x883700
L_8dde56:
	ld_s r0,[r0]
L_8dde58:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8dde5a:
	cmp_s r0,0x1f
L_8dde5c:
	mov.cc r0,0x1f
L_8dde60:
	add1_s r13,r13,r0
L_8dde62:
	ldw_s r0,[r13,0x34]
L_8dde64:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8dde66:
	extw_s r0,r0
L_8dde68:
	stw_s r0,[r13,0x34]
	.global L_8dde6a
L_8dde6a:
	ldw r0,[r14, 0xc0]
L_8dde6e:
	brlt.d r15,r0,L_8dde40
L_8dde72:
	add3 r13,r14,0x8
L_8dde76:
	b_s L_8dded2
	.global L_8dde78
L_8dde78:
	mov_s r2,0x883700
L_8dde7e:
	ld_s r3,[r2]
L_8dde80:
	ld_s r0,[r2]
L_8dde82:
	ld_s r1,[r2]
L_8dde84:
	min r3,r3,0x1f
L_8dde88:
	ld_s r2,[r2]
L_8dde8a:
	min r4,r0,0x1f
L_8dde8e:
	add1 r0,r13,r3
L_8dde92:
	ldw_s r3,[r0,0x34]
L_8dde94:
	min r2,r2,0x1f
L_8dde98:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8dde9a:
	extw_s r3,r3
L_8dde9c:
	stw_s r3,[r0,0x34]
L_8dde9e:
	add1 r0,r13,r4
L_8ddea2:
	ldw_s r3,[r0,0x34]
L_8ddea4:
	min r1,r1,0x1f
L_8ddea8:
	/* add_s r3,0x1 */
	.byte 0x01,0xe3
L_8ddeaa:
	extw_s r3,r3
L_8ddeac:
	stw_s r3,[r0,0x34]
L_8ddeae:
	add1 r0,r13,r1
L_8ddeb2:
	ldw_s r1,[r0,0x34]
L_8ddeb4:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8ddeb6:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8ddeb8:
	extw_s r1,r1
L_8ddeba:
	stw_s r1,[r0,0x34]
L_8ddebc:
	add1 r1,r13,r2
L_8ddec0:
	ldw_s r0,[r1,0x34]
L_8ddec2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8ddec4:
	extw_s r0,r0
L_8ddec6:
	stw_s r0,[r1,0x34]
	.global L_8ddec8
L_8ddec8:
	ldw r0,[r14, 0xc0]
L_8ddecc:
	/* asr_s r0,r0,0x2 */
	.byte 0x42,0xb8
L_8ddece:
	brlt r15,r0,L_8dde78
	.global L_8dded2
L_8dded2:
	ldw_s r1,[r13,0x34]
L_8dded4:
	ldw r0,[r14, 0xc2]
L_8dded8:
	brge.d r0,r1,L_8ddeec
L_8ddedc:
	add r15,r13,0x34
L_8ddee0:
	mov_s r0,0x8042c8
L_8ddee6:
	bl.d L_8c6a40
L_8ddeea:
	ldb_s r1,[r0]
	.global L_8ddeec
L_8ddeec:
	mov_s r0,0x0
L_8ddeee:
	mov_s r1,r0
L_8ddef0:
	b_s L_8ddef4
	.global L_8ddef2
L_8ddef2:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
	.global L_8ddef4
L_8ddef4:
	brge r1,0x20,L_8ddf28
L_8ddef8:
	ldb r2,[r14, 0xb6]
L_8ddefc:
	brlt r1,r2,L_8ddf0a
L_8ddf00:
	sub r3,r1,r2
L_8ddf04:
	ldw.as r3,[r15,r3]
L_8ddf08:
	sub_s r0,r0,r3
	.global L_8ddf0a
L_8ddf0a:
	ldw.as r3,[r15,r1]
L_8ddf0e:
	add_s r0,r0,r3
L_8ddf10:
	ldw r3,[r14, 0xc2]
L_8ddf14:
	brge r3,r0,L_8ddef2
L_8ddf18:
	sub_s r1,r1,r2
L_8ddf1a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8ddf1c:
	ldb r0,[r14, 0xb7]
L_8ddf20:
	cmp_s r1,0x0
L_8ddf22:
	add.ge r0,r0,r1
L_8ddf26:
	b_s L_8ddf2a
	.global L_8ddf28
L_8ddf28:
	mov_s r0,0x0
	.global L_8ddf2a
L_8ddf2a:
	b L_8c024c
L_8ddf2e:
	nop_s
