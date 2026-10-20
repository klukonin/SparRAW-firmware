/* arc_action_point__arm @ 0x8c3af0, 96 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: arc_action_point__install_default, arc_protect_addr
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global arc_action_point__arm
arc_action_point__arm:
	.global L_8c3af0
L_8c3af0:
	push_s blink
L_8c3af2:
	push_s r13
L_8c3af4:
	mov_s r13,r0
L_8c3af6:
	mov_s r0,0x0
L_8c3af8:
	bset_s r0,r0,0x18
L_8c3afa:
	sr r0,[0x5]
L_8c3afe:
	ld_s r0,[r13]
L_8c3b00:
	brhs r0,0x2,L_8c3b46
	.global L_8c3b04
L_8c3b04:
	ld_s r1,[r13,0x10]
L_8c3b06:
	ld_s r2,[r13,0xc]
L_8c3b08:
	/* asl_s r1,r1,0x4 */
	.byte 0x04,0xb9
L_8c3b0a:
	or_s r2,r2,r1
L_8c3b0c:
	ld_s r1,[r13,0x14]
L_8c3b0e:
	ld_s r0,[r13]
L_8c3b10:
	/* asl_s r1,r1,0x6 */
	.byte 0x06,0xb9
L_8c3b12:
	or_s r2,r2,r1
L_8c3b14:
	ld_s r1,[r13,0x18]
L_8c3b16:
	ld_s r3,[r13,0x4]
L_8c3b18:
	/* asl_s r1,r1,0x7 */
	.byte 0x07,0xb9
L_8c3b1a:
	or_s r2,r2,r1
L_8c3b1c:
	ld_s r1,[r13,0x1c]
L_8c3b1e:
	add1_s r0,r0,r0
L_8c3b20:
	asl_s r1,r1,0x8
L_8c3b22:
	or_s r1,r1,r2
L_8c3b24:
	mov_s r2,r0
L_8c3b26:
	add r2,r2,0x220
L_8c3b2a:
	sr r3,[r2]
L_8c3b2e:
	ld_s r3,[r13,0x8]
L_8c3b30:
	mov_s r2,r0
L_8c3b32:
	add r2,r2,0x221
L_8c3b36:
	sr r3,[r2]
L_8c3b3a:
	add r0,r0,0x222
L_8c3b3e:
	b.d L_8c025c
L_8c3b42:
	sr r1,[r0]
	.global L_8c3b46
L_8c3b46:
	mov_s r0,blink
L_8c3b48:
	bl.d L_8c9b28
L_8c3b4c:
	mov_s r1,0xf6
L_8c3b4e:
	b_s L_8c3b04
