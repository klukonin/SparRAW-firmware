/* ucode_cmd_0x2d_handler @ 0x926ab4, 384 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, bits__set_u8_s3_w5_uc, uc_sysassert, ucode_cmd_2d__set_bit
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x2d_handler
ucode_cmd_0x2d_handler:
	.global L_926ab4
L_926ab4:
	push_s blink
L_926ab6:
	bl L_920230
L_926aba:
	ld_s r1,[r0]
L_926abc:
	cmp_s r1,0x4
L_926abe:
	bhi.d L_926c24
L_926ac2:
	mov_s r13,r0
L_926ac4:
	ldb r1,[0x801a74,r1]
L_926acc:
	add r0,pcl,0x8
L_926ad0:
	add1_s r0,r0,r1
L_926ad2:
	j_s [r0]
L_926ad4:
	mov_s r1,0x4
L_926ad6:
	mov_s r3,0x8577b8
L_926adc:
	stb_s r1,[r3]
L_926ade:
	mov_s r0,0x21
L_926ae0:
	stb_s r0,[r3,0x1]
L_926ae2:
	stw 0x2514,[r3, 0x10]
L_926aea:
	stw 0x2716,[r3, 0x12]
L_926af2:
	mov_s r0,0xff
L_926af4:
	stb_s r0,[r3,0x14]
L_926af6:
	mov_s r0,0x9
L_926af8:
	stb_s r0,[r3,0x16]
L_926afa:
	stb_s r1,[r3,0x15]
L_926afc:
	mov_s r1,0x12345678
L_926b02:
	stb_s r1,[r3,0x17]
L_926b04:
	lsr_s r1,r1,0x8
L_926b06:
	stb_s r1,[r3,0x18]
L_926b08:
	lsr_s r1,r1,0x8
L_926b0a:
	stb_s r1,[r3,0x19]
L_926b0c:
	lsr_s r1,r1,0x8
L_926b0e:
	stb_s r1,[r3,0x1a]
L_926b10:
	mov_s r14,0x27
L_926b12:
	stb_s r14,[r3,0x1c]
L_926b14:
	mov_s r15,0x1f
L_926b16:
	ldb_s r0,[r3,0x1f]
L_926b18:
	mov_s r1,0x0
L_926b1a:
	bic r0,r0,0x7
L_926b1e:
	stb_s r0,[r3,0x1f]
L_926b20:
	add r0,r3,0x1f
L_926b24:
	bl.d L_93e36c
L_926b28:
	stb_s r15,[r3,0x1d]
L_926b2a:
	mov_s r0,0x5
L_926b2c:
	stb_s r0,[r3,0x1e]
L_926b2e:
	mov_s r0,0x8
L_926b30:
	stb r0,[r3, 0x20]
L_926b34:
	mov_s r2,0x8577f8
L_926b3a:
	ldb r0,[r3, 0x43]
L_926b3e:
	stb_s r14,[r2]
L_926b40:
	bic r0,r0,0x7
L_926b44:
	stb r0,[r3, 0x43]
L_926b48:
	mov_s r0,r3
L_926b4a:
	add_s r0,r0,0x43
L_926b4c:
	bl.d L_93e36c
L_926b50:
	stb_s r15,[r2,0x1]
L_926b52:
	mov_s r0,0x3
L_926b54:
	stb_s r0,[r2,0x2]
L_926b56:
	mov_s r0,0xb
L_926b58:
	stb_s r0,[r2,0x4]
L_926b5a:
	ldw_s r2,[r13,0x8]
L_926b5c:
	mov_s r0,0x1
L_926b5e:
	/* asl_s r2,r2,0x2 */
	.byte 0x02,0xba
L_926b60:
	add2_s r2,r2,r2
L_926b62:
	add_s r2,r2,0x802354
L_926b68:
	stb_s r0,[r2,0x13]
L_926b6a:
	ld_s r0,[r13,0x4]
L_926b6c:
	bmsk_s r0,r0,0x0
L_926b6e:
	stb_s r0,[r2,0xc]
L_926b70:
	ld_s r0,[r13,0x4]
L_926b72:
	lsr_s r0,r0
L_926b74:
	bmsk_s r0,r0,0x0
L_926b76:
	stb_s r0,[r2,0xd]
L_926b78:
	ldb_s r0,[r13,0x5]
L_926b7a:
	stb_s r0,[r2,0xf]
L_926b7c:
	ldw_s r0,[r13,0x6]
L_926b7e:
	stw_s r0,[r2,0x8]
L_926b80:
	ldb_s r0,[r13,0xa]
L_926b82:
	stb_s r0,[r2,0x10]
L_926b84:
	ldb_s r0,[r13,0xa]
L_926b86:
	/* sub_s r0,r0,0x1 */
	.byte 0x61,0xb8
L_926b88:
	stb_s r0,[r2,0x11]
L_926b8a:
	stb_s r1,[r2,0x12]
L_926b8c:
	ld_s r0,[r13,0x4]
L_926b8e:
	add r3,r2,0x8
L_926b92:
	bbit0 r0,0x2,L_926b9a
L_926b96:
	mov_s r1,0x2
L_926b98:
	stb_s r1,[r2,0x12]
	.global L_926b9a
L_926b9a:
	ld_s r0,[r13,0x4]
L_926b9c:
	bbit0 r0,0x3,L_926ba8
L_926ba0:
	bset r0,r1,0x2
L_926ba4:
	extb_s r1,r0
L_926ba6:
	stb_s r0,[r3,0xa]
	.global L_926ba8
L_926ba8:
	ld_s r0,[r13,0x4]
L_926baa:
	bbit0 r0,0x4,L_926bb2
L_926bae:
	bset_s r1,r1,0x3
L_926bb0:
	stb_s r1,[r3,0xa]
	.global L_926bb2
L_926bb2:
	ldb_s r1,[r13,0x5]
L_926bb4:
	mov_s r0,0x0
L_926bb6:
	breq_s r1,0,L_926bc0
L_926bb8:
	ldw_s r1,[r13,0x6]
L_926bba:
	cmp_s r1,0x0
L_926bbc:
	mov.ne r0,0x1
	.global L_926bc0
L_926bc0:
	extb_s r0,r0
L_926bc2:
	brne r0,0x1,L_926bce
	.global L_926bc6
L_926bc6:
	bl.d L_9272c0
L_926bca:
	ldw_s r0,[r13,0x8]
L_926bcc:
	b_s L_926c30
	.global L_926bce
L_926bce:
	mov_s r0,blink
L_926bd0:
	mov_s r1,0x15
L_926bd2:
	bl.d L_926618
L_926bd6:
	asl_s r1,r1,0x8
L_926bd8:
	b_s L_926bc6
L_926bda:
	ldw_s r0,[r13,0x8]
L_926bdc:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_926bde:
	add2_s r0,r0,r0
L_926be0:
	ldw_s r2,[r13,0xc]
L_926be2:
	add r1,r0,0x80235e
L_926bea:
	stw_s r2,[r1]
L_926bec:
	b_s L_926c30
L_926bee:
	ldw_s r0,[r13,0x8]
L_926bf0:
	mov_s r2,0x1
L_926bf2:
	/* asl_s r0,r0,0x2 */
	.byte 0x02,0xb8
L_926bf4:
	add2_s r0,r0,r0
L_926bf6:
	add r1,r0,0x802361
L_926bfe:
	stb_s r2,[r1]
L_926c00:
	b_s L_926c30
L_926c02:
	ldw_s r1,[r13,0x8]
L_926c04:
	mov_s r3,0x1
L_926c06:
	mov_s r0,0x802367
L_926c0c:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_926c0e:
	add2_s r1,r1,r1
L_926c10:
	sub_s r2,r0,0x6
L_926c12:
	add_s r2,r2,r1
L_926c14:
	stb_s r3,[r2]
L_926c16:
	ldw_s r1,[r13,0x8]
L_926c18:
	mov_s r2,0x7
L_926c1a:
	/* asl_s r1,r1,0x2 */
	.byte 0x02,0xb9
L_926c1c:
	add2_s r1,r1,r1
L_926c1e:
	add_s r0,r0,r1
L_926c20:
	stb_s r2,[r0]
L_926c22:
	b_s L_926c30
	.global L_926c24
L_926c24:
	mov_s r0,blink
L_926c26:
	mov_s r1,0x144e
L_926c2c:
	bl L_926618
	.global L_926c30
L_926c30:
	b L_92029c
