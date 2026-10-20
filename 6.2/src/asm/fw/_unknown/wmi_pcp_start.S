/* wmi_pcp_start @ 0x8ec91c, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: wmi_pcp_start_cmd_handler
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_pcp_start
wmi_pcp_start:
	.global L_8ec91c
L_8ec91c:
	push_s blink
L_8ec91e:
	ldw_s r2,[r0]
L_8ec920:
	stw.a r2,[sp,-0x14]
L_8ec924:
	mov_s r2,0x0
L_8ec926:
	stw r2,[sp, 0x2]
L_8ec92a:
	st_s r2,[sp,0x4]
L_8ec92c:
	st_s r2,[sp,0x8]
L_8ec92e:
	ldb_s r2,[r0,0xc]
L_8ec930:
	stb_s r2,[sp,0xc]
L_8ec932:
	ldb_s r2,[r0,0x2]
L_8ec934:
	stb r2,[sp, 0xd]
L_8ec938:
	ldb_s r2,[r0,0x3]
L_8ec93a:
	stb_s r2,[sp,0x10]
L_8ec93c:
	ldb_s r2,[r0,0xe]
L_8ec93e:
	stb r2,[sp, 0xe]
L_8ec942:
	ldb_s r2,[r0,0xf]
L_8ec944:
	stb r2,[sp, 0xf]
L_8ec948:
	ldb_s r2,[r0,0x4]
L_8ec94a:
	stb r2,[sp, 0x11]
L_8ec94e:
	ldb_s r2,[r0,0xa]
L_8ec950:
	stb r2,[sp, 0x12]
L_8ec954:
	ldb_s r3,[r0,0xd]
L_8ec956:
	mov_s r2,0x803b80
L_8ec95c:
	st_s r3,[r2]
L_8ec95e:
	ldb_s r0,[r0,0xb]
L_8ec960:
	stb r0,[r2, 0xa8]
L_8ec964:
	bl.d L_8ec840
L_8ec968:
	mov_s r0,sp
L_8ec96a:
	add_s sp,sp,0x14
L_8ec96c:
	pop_s blink
L_8ec96e:
	j_s [blink]
