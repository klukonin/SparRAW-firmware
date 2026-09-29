/* update_rf_xx_gains_tables @ 0x8ed9cc, 580 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   update_rf_xx_gains_tables(): rfc_idx=%d, rx_gain=%d, m_rf_rx_gain_index[rfc_idx]=%d,
 * Зовут его: calib_silent_rssi_sparrow__find_rf_gain
 * Зовёт сам: __ld_r24_to_r13_ret, __st_r24_to_r13, fw_log_emit3, fw_sysassert_fatal, hwm_analog__prepare_buf, marlon_r_if_class__rf_write_with_block_retries, memcpy_fw, u_schd__now
 * Глобалы (через gp): 0x800458, 0x80045c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global update_rf_xx_gains_tables
update_rf_xx_gains_tables:
	.global L_8ed9cc
L_8ed9cc:
	push_s blink
L_8ed9ce:
	bl L_8c01bc
L_8ed9d2:
	sub_s sp,sp,0x10
L_8ed9d4:
	mov_s r13,r0
L_8ed9d6:
	mov_s r16,r1
L_8ed9d8:
	mov_s r18,r2
L_8ed9da:
	mov_s r22,r3
L_8ed9dc:
	mov_s r1,0x1009410
L_8ed9e2:
	add_s r0,r0,0x20
L_8ed9e4:
	add r20,r0,r16
L_8ed9e8:
	ldb r4,[r20, 0x10]
L_8ed9ec:
	mov_s r0,0x26
L_8ed9ee:
	mov_s r2,r16
L_8ed9f0:
	bl.d L_8dcd00
L_8ed9f4:
	ldb r3,[r18]
L_8ed9f8:
	ldb r2,[r20, 0x10]
L_8ed9fc:
	ldb r1,[r18]
L_8eda00:
	ldb r0,[r13, 0xd0]
L_8eda04:
	cmp_s r1,r2
L_8eda06:
	cmp.eq r0,0x0
L_8eda0a:
	beq_s L_8edbba
L_8eda0c:
	breq_s r0,0,L_8eda16
L_8eda0e:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_8eda10:
	extb_s r0,r0
L_8eda12:
	stb r0,[r13, 0xd0]
	.global L_8eda16
L_8eda16:
	mov r17,0x8042c8
L_8eda1e:
	mov_s r1,r17
L_8eda20:
	add r1,r1,0x4f4
L_8eda24:
	mov_s r13,0x804adc
L_8eda2a:
	mov_s r0,r13
L_8eda2c:
	bl.d L_8c0380
L_8eda30:
	mov_s r2,0x80
L_8eda32:
	ldb r0,[r18]
L_8eda36:
	sub r19,r0,0x2
L_8eda3a:
	sexw.f r19,r19
L_8eda3e:
	beq_s L_8edad8
L_8eda40:
	ld r24,[r13, 0x7c]
L_8eda44:
	add r14,r19,0x1
L_8eda48:
	sexw_s r14,r14
L_8eda4a:
	rsub r21,r14,0x10
L_8eda4e:
	bl.d L_8e9524
L_8eda52:
	sexw r21,r21
L_8eda56:
	ldb r0,[r18]
L_8eda5a:
	mov_s r15,0x1
L_8eda5c:
	cmp_s r0,0x2
L_8eda5e:
	mov.ge r1,r15
L_8eda62:
	bge_s L_8eda80
L_8eda64:
	ld r24,[r13, 0xc]
L_8eda68:
	rsub r0,r19,0x0
L_8eda6c:
	sexw r19,r0
L_8eda70:
	mov_s r1,0xf
L_8eda72:
	rsub r21,r19,0xf
L_8eda76:
	sexw r21,r21
L_8eda7a:
	mov_s r14,r21
L_8eda7c:
	mov r15,-0x1
	.global L_8eda80
L_8eda80:
	brlt r21,0x1,L_8edab2
L_8eda84:
	mov_s r0,r21
	.global L_8eda86
L_8eda86:
	mov_s r21,r1
L_8eda88:
	mov_s r23,r0
L_8eda8a:
	cmp_s r14,0x10
L_8eda8c:
	cmp.cs r21,0x10
L_8eda90:
	bcc L_8edb28
	.global L_8eda94
L_8eda94:
	add3 r0,r13,r14
L_8eda98:
	ld_s r1,[r0,0x4]
L_8eda9a:
	add3 r0,r13,r21
L_8eda9e:
	st_s r1,[r0,0x4]
L_8edaa0:
	add_s r14,r14,r15
L_8edaa2:
	sexw_s r14,r14
L_8edaa4:
	sub r0,r23,0x1
L_8edaa8:
	add r1,r15,r21
L_8edaac:
	brhs.d r0,0x1,L_8eda86
L_8edab0:
	sexw_s r1,r1
	.global L_8edab2
L_8edab2:
	sub_s r14,r14,r15
L_8edab4:
	brlt.d r19,0x2,L_8edad8
L_8edab8:
	sexw_s r14,r14
L_8edaba:
	sub r0,r19,0x1
	.global L_8edabe
L_8edabe:
	sub_s r14,r14,r15
L_8edac0:
	sexw_s r14,r14
L_8edac2:
	brhs.d r14,0x10,L_8edb36
L_8edac6:
	mov_s r19,r0
	.global L_8edac8
L_8edac8:
	sub r0,r19,0x1
L_8edacc:
	add3 r1,r13,r14
L_8edad0:
	brhs.d r0,0x1,L_8edabe
L_8edad4:
	st r24,[r1, 0x4]
	.global L_8edad8
L_8edad8:
	ld.as r6,[gp,0xb5]
L_8edadc:
	mov_s r0,r17
L_8edade:
	mov_s r1,r16
L_8edae0:
	mov_s r2,r13
L_8edae2:
	mov_s r3,0x10
L_8edae4:
	mov_s r4,r3
L_8edae6:
	bl.d L_8e3418
L_8edaea:
	mov r5,0x5
L_8edaee:
	brne_s r0,0,L_8edb14
L_8edaf0:
	ld_s r0,[gp,0x2d8]
L_8edaf2:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8edaf4:
	st.as r0,[gp,0xb6]
L_8edaf8:
	bl.d L_8e2960
L_8edafc:
	mov_s r0,0x1
L_8edafe:
	mov_s r0,r17
L_8edb00:
	mov_s r1,r16
L_8edb02:
	mov_s r2,r13
L_8edb04:
	mov_s r3,0x10
L_8edb06:
	mov_s r4,r3
L_8edb08:
	mov r5,0x5
L_8edb0c:
	bl.d L_8e3418
L_8edb10:
	mov r6,0x1
	.global L_8edb14
L_8edb14:
	ldb r0,[r22]
L_8edb18:
	mov_s r1,r17
L_8edb1a:
	brlt.d r0,0x4,L_8edb44
L_8edb1e:
	add r1,r1,0x474
L_8edb22:
	/* sub_s r0,r0,0x3 */
	.byte 0x63,0xb8
L_8edb24:
	extb_s r0,r0
L_8edb26:
	b_s L_8edb46
	.global L_8edb28
L_8edb28:
	mov_s r0,blink
L_8edb2a:
	mov_s r1,0x1488
L_8edb30:
	bl L_8c9b28
L_8edb34:
	b_s L_8eda94
	.global L_8edb36
L_8edb36:
	mov_s r0,blink
L_8edb38:
	mov_s r1,0x1582
L_8edb3e:
	bl L_8c9b28
L_8edb42:
	b_s L_8edac8
	.global L_8edb44
L_8edb44:
	mov_s r0,0x1
	.global L_8edb46
L_8edb46:
	ld_s r2,[r1,0x20]
L_8edb48:
	ld.as r6,[gp,0xb5]
L_8edb4c:
	st_s r2,[sp,0x0]
L_8edb4e:
	ldb r2,[r22]
L_8edb52:
	add3 r3,r1,r2
L_8edb56:
	ld_s r2,[r3,0x4]
L_8edb58:
	st_s r2,[sp,0x4]
L_8edb5a:
	ld_s r2,[r1,0x8]
L_8edb5c:
	mov_s r3,0x2
L_8edb5e:
	st_s r2,[sp,0x8]
L_8edb60:
	add3_s r1,r1,r0
L_8edb62:
	ld_s r0,[r1,0x4]
L_8edb64:
	mov_s r2,sp
L_8edb66:
	st_s r0,[sp,0xc]
L_8edb68:
	mov_s r0,r17
L_8edb6a:
	mov_s r1,r16
L_8edb6c:
	mov_s r4,r3
L_8edb6e:
	bl.d L_8e3418
L_8edb72:
	mov r5,0x5
L_8edb76:
	brne_s r0,0,L_8edb9c
L_8edb78:
	ld_s r0,[gp,0x2d8]
L_8edb7a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8edb7c:
	st.as r0,[gp,0xb6]
L_8edb80:
	bl.d L_8e2960
L_8edb84:
	mov_s r0,0x1
L_8edb86:
	mov_s r0,r17
L_8edb88:
	mov_s r1,r16
L_8edb8a:
	mov_s r2,r13
L_8edb8c:
	mov_s r3,0x10
L_8edb8e:
	mov_s r4,r3
L_8edb90:
	mov r5,0x5
L_8edb94:
	bl.d L_8e3418
L_8edb98:
	mov r6,0x1
	.global L_8edb9c
L_8edb9c:
	ldb r1,[r18]
L_8edba0:
	stb r1,[r20, 0x10]
L_8edba4:
	ldb r1,[r22]
L_8edba8:
	stb r1,[r20, 0x8]
L_8edbac:
	mov_s r1,0x2
L_8edbae:
	stb r1,[r18]
L_8edbb2:
	mov_s r1,0x4
L_8edbb4:
	stb r1,[r22]
L_8edbb8:
	b_s L_8edc0a
	.global L_8edbba
L_8edbba:
	mov_s r13,0x8042c8
L_8edbc0:
	mov_s r1,r13
L_8edbc2:
	add r1,r1,0x56c
L_8edbc6:
	ld_s r0,[r1]
L_8edbc8:
	mov_s r14,sp
L_8edbca:
	st_s r0,[sp,0x0]
L_8edbcc:
	ld_s r0,[r1,0x4]
L_8edbce:
	ld.as r6,[gp,0xb5]
L_8edbd2:
	st_s r0,[sp,0x4]
L_8edbd4:
	mov_s r0,r13
L_8edbd6:
	mov_s r1,0x0
L_8edbd8:
	mov_s r2,r14
L_8edbda:
	mov_s r3,0x1
L_8edbdc:
	mov_s r4,r3
L_8edbde:
	bl.d L_8e3418
L_8edbe2:
	mov r5,0x5
L_8edbe6:
	brne_s r0,0,L_8edc0a
L_8edbe8:
	ld_s r0,[gp,0x2d8]
L_8edbea:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8edbec:
	st.as r0,[gp,0xb6]
L_8edbf0:
	bl.d L_8e2960
L_8edbf4:
	mov_s r0,0x1
L_8edbf6:
	mov_s r0,r13
L_8edbf8:
	mov_s r1,0x0
L_8edbfa:
	mov_s r2,r14
L_8edbfc:
	mov_s r3,0x1
L_8edbfe:
	mov_s r4,r3
L_8edc00:
	mov r5,0x5
L_8edc04:
	bl.d L_8e3418
L_8edc08:
	mov_s r6,r3
	.global L_8edc0a
L_8edc0a:
	b.d L_8c0204
L_8edc0e:
	add_s sp,sp,0x10
