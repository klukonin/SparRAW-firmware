/* conn_tbl__slot_is_free @ 0x8da10c, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: scan_mngr__clean_all_lists
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_tbl__slot_is_free
conn_tbl__slot_is_free:
	.global L_8da10c
L_8da10c:
	ldb_s r1,[r0,0x8]
L_8da10e:
	mov_s r0,0x854080
L_8da114:
	add3_s r0,r0,r1
L_8da116:
	ld_s r0,[r0]
L_8da118:
	cmp_s r0,0x0
L_8da11a:
	mov_s r0,0x1
L_8da11c:
	j_s.d [blink]
L_8da11e:
	sub_s.ne r0,r0,r0
