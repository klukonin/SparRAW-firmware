/* periodic_service__run @ 0x8cdc18, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn__arm_detect_step
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, mac_read_tsf64, periodic_service__tick, u_schd__now
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global periodic_service__run
periodic_service__run:
	.global L_8cdc18
L_8cdc18:
	push_s blink
L_8cdc1a:
	bl L_8c01dc
L_8cdc1e:
	bl.d L_8e9524
L_8cdc22:
	mov_s r13,r0
L_8cdc24:
	mov_s r15,r0
L_8cdc26:
	ld_s r0,[r13,0x28]
L_8cdc28:
	brne_s r0,0,L_8cdc7c
L_8cdc2a:
	add r14,r13,0x20
L_8cdc2e:
	ldb_s r0,[r14,0x4]
L_8cdc30:
	cmp r0,0xfe
L_8cdc34:
	mov.ge r0,0x0
L_8cdc38:
	bge_s L_8cdc3e
L_8cdc3a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8cdc3c:
	extb_s r0,r0
	.global L_8cdc3e
L_8cdc3e:
	stb_s r0,[r14,0x4]
L_8cdc40:
	ld_s r0,[r13,0x14]
L_8cdc42:
	mov r16,-0x1
L_8cdc46:
	cmp_s r0,r16
L_8cdc48:
	bl.ne L_8e9524
L_8cdc4c:
	ld_s r0,[r13,0x18]
L_8cdc4e:
	cmp_s r0,r16
L_8cdc50:
	bl.ne L_8e9524
L_8cdc54:
	st_s r15,[r13,0x14]
L_8cdc56:
	ld_s r0,[r13,0x2c]
L_8cdc58:
	ld_s r2,[r0,0xc]
L_8cdc5a:
	mov_s r0,r13
L_8cdc5c:
	jl_s.d [r2]
L_8cdc5e:
	ldb_s r1,[r14,0x4]
L_8cdc60:
	bl L_8e9524
L_8cdc64:
	add r1,r13,0x1c
L_8cdc68:
	st_s r0,[r13,0x18]
L_8cdc6a:
	mov_s r0,0x0
L_8cdc6c:
	bl.d L_8e9900
L_8cdc70:
	mov_s r2,r0
L_8cdc72:
	mov_s r0,r13
L_8cdc74:
	bl.d L_8e4828
L_8cdc78:
	mov r1,-0x1
	.global L_8cdc7c
L_8cdc7c:
	b L_8c0244
