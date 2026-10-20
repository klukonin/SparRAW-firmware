/* wmi_delete_cipher_key @ 0x8ec4bc, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI_DELETE_CIPHER_KEY_CMD >>>>>>>>>>>ADDR-%04X%08X
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_delete_cipher_key
wmi_delete_cipher_key:
	.global L_8ec4bc
L_8ec4bc:
	push_s blink
L_8ec4be:
	push_s r13
L_8ec4c0:
	ldb_s r3,[r0,0x6]
L_8ec4c2:
	ldb_s r2,[r0,0x5]
L_8ec4c4:
	asl_s r3,r3,0x8
L_8ec4c6:
	or_s r2,r2,r3
L_8ec4c8:
	ldb_s r13,[r0,0x2]
L_8ec4ca:
	ldb_s r3,[r0,0x1]
L_8ec4cc:
	asl_s r13,r13,0x8
L_8ec4ce:
	or_s r3,r3,r13
L_8ec4d0:
	ldb_s r13,[r0,0x3]
L_8ec4d2:
	mov_s r1,0x100b664
L_8ec4d8:
	asl_s r13,r13,0x10
L_8ec4da:
	or_s r3,r3,r13
L_8ec4dc:
	ldb_s r13,[r0,0x4]
L_8ec4de:
	asl_s r13,r13,0x18
L_8ec4e0:
	or_s r3,r3,r13
L_8ec4e2:
	bl.d L_8dcc80
L_8ec4e6:
	mov_s r0,0x20
L_8ec4e8:
	b L_8c025c
