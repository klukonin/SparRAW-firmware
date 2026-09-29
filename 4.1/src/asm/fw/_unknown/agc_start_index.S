/* agc_start_index @ 0x8c8978, 532 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SR silent RSSI calib --> Decreasing rf_gain_index to %d
 *   SR silent RSSI calib --> Increasing rf_gain_index to %d
 *   agc_start_index is smaller then %d. Clipping to it
 *   agc_start_index > %d (MAX index). Setting to MAX index
 *   RF gain calibration: agc_start_index changed to %d
 *   Silent RSSI calib did not converge. Setting value to edge %d.
 *   Silent RSSI calib did not converge. Setting value to initial value %d.
 * Зовут его: calib_silent_rssi__vt1c
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, agc_tbl__unpack_field16, agc_tbl__unpack_field8, calib_silent_rssi_sparrow, fw_log__emit1, measure_rssi_using_histogram, rf__check_state
 * Глобалы (через gp): 0x800229, 0x80022b, 0x80022c
 */
	.section .text.agc_start_index,"ax",@progbits
	.global agc_start_index
agc_start_index:
	.global L_8c8978
L_8c8978:
	push_s blink
L_8c897a:
	bl L_8c02ac
L_8c897e:
	mov_s r20,r0
L_8c8980:
	mov_s r0,0x883100
L_8c8986:
	ld_s r0,[r0,0x38]
L_8c8988:
	ldb.x r13,[gp, 0xbd]
L_8c898c:
	bmsk r16,r0,0x5
L_8c8990:
	ldb_s r0,[gp,0xbb]
L_8c8992:
	stb r0,[gp, 0xbc]
L_8c8996:
	ldb_s r0,[gp,0xb9]
L_8c8998:
	stb r0,[gp, 0xba]
L_8c899c:
	mov_s r0,0x8004d8
L_8c89a2:
	ldb_s r0,[r0]
L_8c89a4:
	add_s r13,r13,r0
L_8c89a6:
	mov_s r0,0x800d08
L_8c89ac:
	extb_s r13,r13
L_8c89ae:
	mov_s r19,r0
L_8c89b0:
	stb_s r13,[r0,0x7]
L_8c89b2:
	mov r18,0x0
L_8c89b6:
	breq_s r1,0,L_8c89c2
L_8c89b8:
	bl L_8e154c
L_8c89bc:
	ld_s r0,[gp,-0x16c]
L_8c89be:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c89c0:
	b_s L_8c89c8
	.global L_8c89c2
L_8c89c2:
	bl L_8e21a4
L_8c89c6:
	mov_s r0,r18
	.global L_8c89c8
L_8c89c8:
	st.as r0,[gp,-0x5b]
L_8c89cc:
	mov r17,0x800494
L_8c89d4:
	ldw r0,[r17]
L_8c89d8:
	bbit1 r0,0x1,L_8c89e6
L_8c89dc:
	mov_s r0,0x9
L_8c89de:
	stb r0,[gp, 0xbb]
L_8c89e2:
	stb r0,[gp, 0xc5]
	.global L_8c89e6
L_8c89e6:
	mov_s r0,r20
L_8c89e8:
	bl.d L_8c5ec4
L_8c89ec:
	mov_s r1,0x0
L_8c89ee:
	mov_s r0,r20
L_8c89f0:
	bl.d L_8d9ed0
L_8c89f4:
	mov_s r1,r13
L_8c89f6:
	ldb r1,[r19]
L_8c89fa:
	sub r15,r0,r1
L_8c89fe:
	sexb_s r15,r15
L_8c8a00:
	b_s L_8c8a08
	.global L_8c8a02
L_8c8a02:
	add r18,r18,0x1
L_8c8a06:
	mov_s r15,r14
	.global L_8c8a08
L_8c8a08:
	ldb r1,[r17, 0x1]
L_8c8a0c:
	brge.d r18,r1,L_8c8a32
L_8c8a10:
	ldb_s r0,[gp,0xbb]
L_8c8a12:
	brlt r15,0x1,L_8c8a36
L_8c8a16:
	add_s r1,r0,0x1
L_8c8a18:
	min r14,r1,0xf
L_8c8a1c:
	rsub.f r0,r0,r14
L_8c8a20:
	mov.ne r0,0x1
L_8c8a24:
	extb.f 0x0,r0
L_8c8a28:
	beq_s L_8c8a32
L_8c8a2a:
	mov_s r2,0x10088c0
L_8c8a30:
	b_s L_8c8a54
	.global L_8c8a32
L_8c8a32:
	mov_s r14,r15
L_8c8a34:
	b_s L_8c8ab0
	.global L_8c8a36
L_8c8a36:
	brge r15,0x0,L_8c8a32
L_8c8a3a:
	sub_s r1,r0,0x1
L_8c8a3c:
	max r14,r1,0x1
L_8c8a40:
	rsub.f r0,r0,r14
L_8c8a44:
	mov.ne r0,0x1
L_8c8a48:
	extb.f 0x0,r0
L_8c8a4c:
	beq_s L_8c8a32
L_8c8a4e:
	mov_s r2,0x10088f8
	.global L_8c8a54
L_8c8a54:
	mov_s r0,0x6
L_8c8a56:
	mov_s r1,0x2
L_8c8a58:
	bl.d L_8edfcc
L_8c8a5c:
	mov_s r3,r14
L_8c8a5e:
	ldb_s r0,[gp,0xbb]
L_8c8a60:
	stb r14,[gp, 0xbb]
L_8c8a64:
	stb r0,[gp, 0xbc]
L_8c8a68:
	mov_s r0,r20
L_8c8a6a:
	bl.d L_8c5ec4
L_8c8a6e:
	mov_s r1,0x0
L_8c8a70:
	mov_s r0,r20
L_8c8a72:
	bl.d L_8d9ed0
L_8c8a76:
	mov_s r1,r13
L_8c8a78:
	ldb r1,[r19]
L_8c8a7c:
	sub r14,r0,r1
L_8c8a80:
	sexb_s r14,r14
L_8c8a82:
	brge r14,0x0,L_8c8a8a
L_8c8a86:
	brge r15,0x1,L_8c8a98
	.global L_8c8a8a
L_8c8a8a:
	brlt r14,0x1,L_8c8a92
L_8c8a8e:
	brlt r15,0x0,L_8c8a98
	.global L_8c8a92
L_8c8a92:
	brne r14,0x0,L_8c8a02
L_8c8a96:
	b_s L_8c8ab0
	.global L_8c8a98
L_8c8a98:
	abs_s r1,r15
L_8c8a9a:
	abs_s r0,r14
L_8c8a9c:
	brge r1,r0,L_8c8ab0
L_8c8aa0:
	ldb_s r0,[gp,0xbc]
L_8c8aa2:
	stb r0,[gp, 0xbb]
L_8c8aa6:
	mov_s r0,r20
L_8c8aa8:
	bl.d L_8c5ec4
L_8c8aac:
	mov_s r1,0x0
L_8c8aae:
	b_s L_8c8a32
	.global L_8c8ab0
L_8c8ab0:
	ldb_s r0,[gp,0xbb]
L_8c8ab2:
	cmp_s r0,0x1
L_8c8ab4:
	cmp.ne r0,0xf
L_8c8ab8:
	bne_s L_8c8b2c
L_8c8aba:
	ldb r0,[r17, 0x1]
L_8c8abe:
	brlt.d r0,0x1,L_8c8b2a
L_8c8ac2:
	mov_s r15,0x0
	.global L_8c8ac4
L_8c8ac4:
	abs_s r0,r14
L_8c8ac6:
	brlt r0,0x2,L_8c8b2a
L_8c8aca:
	ldb r3,[r19, 0x8]
L_8c8ace:
	add_s r13,r13,r14
L_8c8ad0:
	brge r13,r3,L_8c8ae8
L_8c8ad4:
	mov_s r2,0x1008930
L_8c8ada:
	mov_s r0,0x6
L_8c8adc:
	bl.d L_8edfcc
L_8c8ae0:
	mov_s r1,0x1
L_8c8ae2:
	ldb r13,[r19, 0x8]
L_8c8ae6:
	b_s L_8c8afe
	.global L_8c8ae8
L_8c8ae8:
	brhs r16,r13,L_8c8afe
L_8c8aec:
	mov_s r2,0x1008964
L_8c8af2:
	mov_s r0,0x6
L_8c8af4:
	mov_s r1,0x1
L_8c8af6:
	mov_s r3,r16
L_8c8af8:
	bl.d L_8edfcc
L_8c8afc:
	mov_s r13,r16
	.global L_8c8afe
L_8c8afe:
	mov_s r0,r20
L_8c8b00:
	bl.d L_8d9ed0
L_8c8b04:
	mov_s r1,r13
L_8c8b06:
	ldb r1,[r19]
L_8c8b0a:
	mov_s r2,0x100899c
L_8c8b10:
	sub r14,r0,r1
L_8c8b14:
	mov_s r0,0x6
L_8c8b16:
	mov_s r1,0x2
L_8c8b18:
	bl.d L_8edfcc
L_8c8b1c:
	mov_s r3,r13
L_8c8b1e:
	ldb r0,[r17, 0x1]
L_8c8b22:
	/* add_s r15,0x1 */
	.byte 0x01,0xe7
L_8c8b24:
	brlt.d r15,r0,L_8c8ac4
L_8c8b28:
	sexb_s r14,r14
	.global L_8c8b2a
L_8c8b2a:
	mov_s r18,r15
	.global L_8c8b2c
L_8c8b2c:
	ldb r0,[r17, 0x1]
L_8c8b30:
	brne r0,r18,L_8c8b64
L_8c8b34:
	ldb r0,[r19, 0x8]
L_8c8b38:
	cmp_s r13,r0
L_8c8b3a:
	cmp.ne r13,r16
L_8c8b3e:
	bne_s L_8c8b4c
L_8c8b40:
	mov_s r2,0x10089d0
L_8c8b46:
	mov_s r0,0x6
L_8c8b48:
	mov_s r1,0x1
L_8c8b4a:
	b_s L_8c8b5a
	.global L_8c8b4c
L_8c8b4c:
	ldb r13,[r19, 0x7]
L_8c8b50:
	mov_s r2,0x1008a10
L_8c8b56:
	mov_s r0,0x6
L_8c8b58:
	mov_s r1,0x0
	.global L_8c8b5a
L_8c8b5a:
	bl.d L_8edfcc
L_8c8b5e:
	mov_s r3,r13
L_8c8b60:
	bl L_8c64bc
	.global L_8c8b64
L_8c8b64:
	ldb.x r0,[gp, 0xbf]
L_8c8b68:
	ldb r1,[gp, 0xbb]
L_8c8b6c:
	add_s r0,r0,r1
L_8c8b6e:
	sexb_s r0,r0
L_8c8b70:
	max r0,r0,0x1
L_8c8b74:
	min r0,r0,0xf
L_8c8b78:
	stb r0,[gp, 0xc5]
L_8c8b7c:
	mov_s r0,r20
L_8c8b7e:
	bl.d L_8c5ec4
L_8c8b82:
	mov_s r1,0x0
L_8c8b84:
	b.d L_8c0304
L_8c8b88:
	stb r13,[gp, 0xb9]
