/* ucode_cmd_0x18_handler @ 0x93ad54, 156 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, memcpy_uc, uc_send_evt__sta_update_field_rsp, uc_sysassert
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x18_handler
ucode_cmd_0x18_handler:
	.global L_93ad54
L_93ad54:
	push_s blink
L_93ad56:
	bl L_920234
L_93ad5a:
	mov_s r13,r0
L_93ad5c:
	ld_s r0,[r0]
L_93ad5e:
	ld_s r14,[r13,0x8]
L_93ad60:
	/* asl_s r0,r0,0x4 */
	.byte 0x04,0xb8
L_93ad62:
	add2_s r0,r0,r0
L_93ad64:
	add_s r0,r0,0x801104
L_93ad6a:
	add_s r14,r14,r0
L_93ad6c:
	ld_s r0,[r13,0xc]
L_93ad6e:
	brhs r0,0x11,L_93ad8e
	.global L_93ad72
L_93ad72:
	mov_s r0,r14
L_93ad74:
	add r1,r13,0x10
L_93ad78:
	bl.d L_920330
L_93ad7c:
	ld_s r2,[r13,0xc]
L_93ad7e:
	ld_s r1,[r13,0x4]
L_93ad80:
	ld_s r0,[r13]
L_93ad82:
	cmp_s r1,0x0
L_93ad84:
	cmp.ne r1,0x4
L_93ad88:
	bne_s L_93ada8
L_93ad8a:
	mov_s r13,0x1
L_93ad8c:
	b_s L_93ad98
	.global L_93ad8e
L_93ad8e:
	mov_s r0,blink
L_93ad90:
	bl.d L_926618
L_93ad94:
	mov_s r1,0x81
L_93ad96:
	b_s L_93ad72
	.global L_93ad98
L_93ad98:
	asl_s r2,r0,0x4
L_93ad9a:
	add2_s r2,r2,r2
L_93ad9c:
	add r3,r2,0x80114f
L_93ada4:
	stb_s r13,[r3]
L_93ada6:
	b_s L_93ade6
	.global L_93ada8
L_93ada8:
	cmp_s r1,0x1
L_93adaa:
	mov.eq r13,0x0
L_93adae:
	beq_s L_93ad98
L_93adb0:
	brne r1,0x8,L_93ade6
L_93adb4:
	asl_s r2,r0,0x4
L_93adb6:
	mov_s r3,0x801151
L_93adbc:
	add2_s r2,r2,r2
L_93adbe:
	ldb_s r2,[r3,r2]
L_93adc0:
	mov_s r3,0x857280
L_93adc6:
	/* mulu64 r2,0xa40 */
	.byte 0x05,0x2a,0x82,0x0f,0x00,0x00,0x40,0x0a
L_93adce:
	mov_s r2,mlo
L_93add0:
	ldb_s r3,[r3,0xc]
L_93add2:
	add r2,r2,0x528
L_93add6:
	mulu64 r3,r2
L_93adda:
	mov_s r2,0x8020c4
L_93ade0:
	add2_s r2,r2,r0
L_93ade2:
	st mlo,[r2]
	.global L_93ade6
L_93ade6:
	bl L_927810
L_93adea:
	b L_9202a4
L_93adee:
	nop_s
