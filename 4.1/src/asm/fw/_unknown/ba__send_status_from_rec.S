/* ba__send_status_from_rec @ 0x8c38cc, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: l2mgr__send_ba_status_evt
 */
	.section .text.ba__send_status_from_rec,"ax",@progbits
	.global ba__send_status_from_rec
ba__send_status_from_rec:
L_8c38cc:
	mov_s r2,r1
L_8c38ce:
	ldb_s r1,[r0,0x7]
L_8c38d0:
	mov_s r3,0x0
L_8c38d2:
	mov_s r4,r3
L_8c38d4:
	b.d L_8e061c
L_8c38d8:
	mov_s r5,r3
L_8c38da:
	nop_s
