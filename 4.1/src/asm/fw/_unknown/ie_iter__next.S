/* ie_iter__next @ 0x8db160, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: app_ie__print_ies, app_ie__remove_tlv, find_main_sm__probe_req, find_main_sm__probe_req_in_search, ies_block__find_ie, ies_block__merge
 */
	.section .text.ie_iter__next,"ax",@progbits
	.global ie_iter__next
ie_iter__next:
	.global L_8db160
L_8db160:
	ld_s r1,[r0,0x4]
L_8db162:
	breq_s r1,0,L_8db182
L_8db164:
	ldb_s r3,[r1,0x1]
L_8db166:
	ldw_s r2,[r0,0x8]
L_8db168:
	/* add_s r3,0x2 */
	.byte 0x02,0xe3
L_8db16a:
	add_s r2,r2,r3
L_8db16c:
	extw_s r2,r2
L_8db16e:
	ld_s r3,[r0]
L_8db170:
	stw_s r2,[r0,0x8]
L_8db172:
	ldw_s r3,[r3,0x4]
L_8db174:
	cmp_s r2,r3
L_8db176:
	mov_s r2,0x0
L_8db178:
	bge_s L_8db180
L_8db17a:
	ldb_s r2,[r1,0x1]
L_8db17c:
	add_s r2,r2,r1
L_8db17e:
	/* add_s r2,0x2 */
	.byte 0x02,0xe2
	.global L_8db180
L_8db180:
	st_s r2,[r0,0x4]
	.global L_8db182
L_8db182:
	j_s.d [blink]
L_8db184:
	mov_s r0,r1
L_8db186:
	nop_s
