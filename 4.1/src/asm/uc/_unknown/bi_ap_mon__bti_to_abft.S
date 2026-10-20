/* bi_ap_mon__bti_to_abft @ 0x931014, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 */
	.section .text.bi_ap_mon__bti_to_abft,"ax",@progbits
	.global bi_ap_mon__bti_to_abft
bi_ap_mon__bti_to_abft:
L_931014:
	st.a r13,[sp,-0x8]
L_931018:
	st_s r14,[sp,0x4]
L_93101a:
	mov_s r14,blink
L_93101c:
	ldb_s r1,[r0]
L_93101e:
	mov_s r13,r0
L_931020:
	bmsk_s r1,r1,0x3
L_931022:
	or r1,r1,0xcaf000
L_93102a:
	mov_s r32,r1
L_93102c:
	st.ab r1,[r25,0x4]
L_931030:
	bclr r25,r25,0xa
L_931034:
	ldb_s r2,[r13]
L_931036:
	mov_s r1,0x801e14
L_93103c:
	ldw_s r0,[r1,0x6]
L_93103e:
	stb_s r2,[r1,0x12]
L_931040:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_931042:
	stw_s r0,[r1,0x6]
L_931044:
	mov_s blink,r14
L_931046:
	ld_s r14,[sp,0x4]
L_931048:
	j.d [blink]
L_93104c:
	ld.ab r13,[sp,0x8]
