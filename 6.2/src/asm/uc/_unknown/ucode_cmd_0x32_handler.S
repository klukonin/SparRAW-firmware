/* ucode_cmd_0x32_handler @ 0x923940, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, bits__set_u8_s0_w6_uc, bits__set_u8_s6_w2_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global ucode_cmd_0x32_handler
ucode_cmd_0x32_handler:
	.global L_923940
L_923940:
	push_s blink
L_923942:
	push_s r13
L_923944:
	mov_s r3,r0
L_923946:
	ldb_s r1,[r0,0x1]
L_923948:
	ldb_s r13,[r0]
L_92394a:
	bmsk_s r1,r1,0x1
L_92394c:
	mov_s r2,0x80066c
L_923952:
	add_s r13,r13,r2
L_923954:
	add r0,r13,0xc
L_923958:
	bl L_93e378
L_92395c:
	ldb_s r1,[r3,0x2]
L_92395e:
	ldb_s r0,[r3]
L_923960:
	bmsk_s r1,r1,0x5
L_923962:
	add_s r2,r2,r0
L_923964:
	add r0,r2,0xc
L_923968:
	bl L_93e354
L_92396c:
	b L_9202ac
