/* bi_cfg__fill_slot_desc @ 0x92820c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_cfg__apply
 */
	.section .text.bi_cfg__fill_slot_desc,"ax",@progbits
	.global bi_cfg__fill_slot_desc
bi_cfg__fill_slot_desc:
	.global L_92820c
L_92820c:
	ldb_s r2,[r1,0x4]
L_92820e:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
L_928210:
	stb_s r2,[r0]
L_928212:
	mov_s r2,0x1
L_928214:
	stb_s r2,[r0,0x2]
L_928216:
	mov_s r2,0x0
L_928218:
	stb_s r2,[r0,0x3]
L_92821a:
	ldb_s r1,[r1,0x8]
L_92821c:
	breq_s r1,0,L_928224
L_92821e:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
L_928220:
	extb_s r1,r1
L_928222:
	b_s L_928226
	.global L_928224
L_928224:
	mov_s r1,0xf
	.global L_928226
L_928226:
	stb_s r1,[r0,0x5]
L_928228:
	j_s.d [blink]
L_92822a:
	stb_s r2,[r0,0x1]
