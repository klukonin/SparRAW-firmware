/* frame__build_addba_resp @ 0x8f4e30, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_sm__setup_result, wmi_rcp_addba_resp
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, bits__set8_s2_w4, frame__bits_set16_s6_w10, memset0_words
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global frame__build_addba_resp
frame__build_addba_resp:
	.global L_8f4e30
L_8f4e30:
	push_s blink
L_8f4e32:
	bl L_8c01d0
L_8f4e36:
	mov_s r13,r0
L_8f4e38:
	mov_s r14,r1
L_8f4e3a:
	mov_s r15,r2
L_8f4e3c:
	mov_s r16,r3
L_8f4e3e:
	mov r17,r4
L_8f4e42:
	mov r18,r5
L_8f4e46:
	mov r19,r6
L_8f4e4a:
	bl.d L_8c1cd8
L_8f4e4e:
	mov_s r1,0x9
L_8f4e50:
	mov_s r0,0x3
L_8f4e52:
	stb_s r0,[r13]
L_8f4e54:
	mov_s r0,0x1
L_8f4e56:
	stb_s r0,[r13,0x1]
L_8f4e58:
	stb_s r14,[r13,0x2]
L_8f4e5a:
	stb r18,[r13, 0x3]
L_8f4e5e:
	lsr r18,r18,0x8
L_8f4e62:
	ldb_s r0,[r13,0x5]
L_8f4e64:
	bmsk r1,r19,0x0
L_8f4e68:
	bclr_s r0,r0,0x0
L_8f4e6a:
	or_s r0,r0,r1
L_8f4e6c:
	bclr_s r0,r0,0x1
L_8f4e6e:
	stb_s r0,[r13,0x5]
L_8f4e70:
	bmsk r1,r16,0x3
L_8f4e74:
	add_s r0,r13,0x5
L_8f4e76:
	bl.d L_8ed268
L_8f4e7a:
	stb r18,[r13, 0x4]
L_8f4e7e:
	bmsk r1,r15,0x9
L_8f4e82:
	add_s r0,r13,0x5
L_8f4e84:
	bl L_8ed1cc
L_8f4e88:
	stb r17,[r13, 0x7]
L_8f4e8c:
	lsr r17,r17,0x8
L_8f4e90:
	stb r17,[r13, 0x8]
L_8f4e94:
	b.d L_8c022c
L_8f4e98:
	mov_s r0,0x9
L_8f4e9a:
	nop_s
