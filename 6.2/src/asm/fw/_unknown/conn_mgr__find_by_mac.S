/* conn_mgr__find_by_mac @ 0x8cbf2c, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: get_connection_by_addr
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, memcmp_fw
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__find_by_mac
conn_mgr__find_by_mac:
	.global L_8cbf2c
L_8cbf2c:
	push_s blink
L_8cbf2e:
	bl L_8c01e0
L_8cbf32:
	mov_s r15,r0
L_8cbf34:
	mov_s r14,0x0
L_8cbf36:
	b_s L_8cbf3c
	.global L_8cbf38
L_8cbf38:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8cbf3a:
	extb_s r14,r14
	.global L_8cbf3c
L_8cbf3c:
	brhs r14,0x8,L_8cbf5c
L_8cbf40:
	mov_s r0,0x854080
L_8cbf46:
	add3_s r0,r0,r14
L_8cbf48:
	ld_s r13,[r0,0x4]
L_8cbf4a:
	breq_s r13,0,L_8cbf38
L_8cbf4c:
	add r1,r13,0x1c
L_8cbf50:
	mov_s r0,r15
L_8cbf52:
	bl.d L_8ddf4c
L_8cbf56:
	mov_s r2,0x6
L_8cbf58:
	brne_s r0,0,L_8cbf38
L_8cbf5a:
	b_s L_8cbf5e
	.global L_8cbf5c
L_8cbf5c:
	mov_s r13,0x0
	.global L_8cbf5e
L_8cbf5e:
	b.d L_8c024c
L_8cbf62:
	mov_s r0,r13
