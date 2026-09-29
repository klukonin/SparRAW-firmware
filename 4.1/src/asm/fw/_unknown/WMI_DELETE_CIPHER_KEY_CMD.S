/* WMI_DELETE_CIPHER_KEY_CMD @ 0x8e77b0, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   WMI_DELETE_CIPHER_KEY_CMD >>>>>>>>>>>ADDR-%04X%08X
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: fw_log__emit2
 */
	.section .text.WMI_DELETE_CIPHER_KEY_CMD,"ax",@progbits
	.global WMI_DELETE_CIPHER_KEY_CMD
WMI_DELETE_CIPHER_KEY_CMD:
	.global L_8e77b0
L_8e77b0:
	ldb_s r1,[r0,0x6]
L_8e77b2:
	ldb_s r3,[r0,0x5]
L_8e77b4:
	asl_s r1,r1,0x8
L_8e77b6:
	or_s r3,r3,r1
L_8e77b8:
	ldb_s r1,[r0,0x2]
L_8e77ba:
	ldb r4,[r0, 0x1]
L_8e77be:
	asl_s r1,r1,0x8
L_8e77c0:
	or r4,r4,r1
L_8e77c4:
	ldb_s r1,[r0,0x3]
L_8e77c6:
	mov_s r2,0x100a0b8
L_8e77cc:
	asl_s r1,r1,0x10
L_8e77ce:
	or r4,r4,r1
L_8e77d2:
	ldb_s r1,[r0,0x4]
L_8e77d4:
	mov_s r0,0x0
L_8e77d6:
	asl_s r1,r1,0x18
L_8e77d8:
	or r4,r4,r1
L_8e77dc:
	b.d L_8edff8
L_8e77e0:
	mov_s r1,0x2
L_8e77e2:
	nop_s
