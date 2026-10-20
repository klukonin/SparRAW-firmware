/* grant_detect_step @ 0x92db88, 148 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l1_task__entry, rx__enter_listen_mode, rx_get_required_response, ucode_cmd_0x01_handler
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac__rf_switch_cmd1f, uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global grant_detect_step
grant_detect_step:
	.global L_92db88
L_92db88:
	push_s blink
L_92db8a:
	bl L_92022c
L_92db8e:
	mov_s r13,r0
L_92db90:
	mov_s r14,r1
L_92db92:
	mov_s r16,r2
L_92db94:
	bl.d L_9364c8
L_92db98:
	mov_s r15,0x0
L_92db9a:
	mov_s r1,0x80146c
L_92dba0:
	ld_s r2,[r1]
L_92dba2:
	bmsk r3,r2,0x1
L_92dba6:
	add_s r0,r0,r13
L_92dba8:
	brne r3,0x3,L_92dbb4
L_92dbac:
	ld_s r3,[r1,0x4]
L_92dbae:
	sub_s r0,r0,r3
L_92dbb0:
	bbit1 r0,0x1f,L_92dbcc
	.global L_92dbb4
L_92dbb4:
	mov_s r15,0x1
L_92dbb6:
	bbit0 r2,0x0,L_92dbcc
L_92dbba:
	bclr_s r2,r2,0x0
L_92dbbc:
	st_s r2,[r1]
L_92dbbe:
	mov r0,-0x1
L_92dbc2:
	st_s r0,[r1,0x8]
L_92dbc4:
	mov_s r0,0x0
L_92dbc6:
	st.as r0,[gp,-0x26]
L_92dbca:
	mov_s r14,r15
	.global L_92dbcc
L_92dbcc:
	cmp r16,0x0
L_92dbd0:
	cmp.ne r14,0x0
L_92dbd4:
	beq_s L_92dc08
L_92dbd6:
	lr r13,[0xa]
L_92dbda:
	bclr r0,r13,0x1
L_92dbde:
	flag r0
L_92dbe2:
	ld_s r0,[gp,-0xd4]
L_92dbe4:
	ld_s r1,[r1,0x8]
L_92dbe6:
	and_s r0,r0,r1
L_92dbe8:
	bset_s r0,r0,0x1b
L_92dbea:
	mov_s r32,r0
L_92dbec:
	st.ab r0,[r25,0x4]
L_92dbf0:
	bclr r25,r25,0xa
L_92dbf4:
	bl.d L_92c5e4
L_92dbf8:
	mov_s r0,0x1
L_92dbfa:
	lr r0,[0xa]
L_92dbfe:
	bic r13,r13,-0x3
L_92dc02:
	or_s r13,r13,r0
L_92dc04:
	flag r13
	.global L_92dc08
L_92dc08:
	brne_s r15,0,L_92dc16
L_92dc0a:
	mov_s r1,0x8022c8
L_92dc10:
	ld_s r0,[r1,0x28]
L_92dc12:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_92dc14:
	st_s r0,[r1,0x28]
	.global L_92dc16
L_92dc16:
	b.d L_920294
L_92dc1a:
	mov_s r0,r15
