/* memcmp_fw @ 0x8ddf4c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__find_by_mac, discovery__ssid_matches, mid_list__find_by, verify_ssid
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global memcmp_fw
memcmp_fw:
	.global L_8ddf4c
L_8ddf4c:
	push_s r13
L_8ddf4e:
	b_s L_8ddf5c
	.global L_8ddf50
L_8ddf50:
	ldb.ab r3,[r1,0x1]
L_8ddf54:
	ldb.ab r13,[r0,0x1]
L_8ddf58:
	brne r13,r3,L_8ddf68
	.global L_8ddf5c
L_8ddf5c:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_8ddf5e:
	cmp r2,-0x1
L_8ddf62:
	bne_s L_8ddf50
L_8ddf64:
	mov_s r0,0x0
L_8ddf66:
	b_s L_8ddf7e
	.global L_8ddf68
L_8ddf68:
	ldb r2,[r0, -0x1]
L_8ddf6c:
	ldb r0,[r1, -0x1]
L_8ddf70:
	mov_s r1,0x1
L_8ddf72:
	cmp_s r2,r0
L_8ddf74:
	mov r0,-0x1
L_8ddf78:
	sub.lt r1,r1,r1
L_8ddf7c:
	add1_s r0,r0,r1
	.global L_8ddf7e
L_8ddf7e:
	j_s.d [blink]
L_8ddf80:
	pop_s r13
L_8ddf82:
	nop_s
