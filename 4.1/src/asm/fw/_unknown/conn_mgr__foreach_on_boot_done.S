/* conn_mgr__foreach_on_boot_done @ 0x8cb4c0, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__system_state_evt_handler
 * Зовёт сам: __ld_r13_ret, conn__feed_bcons_info, conn_mgr__by_cid, mid__state_is_2_or_3
 */
	.section .text.conn_mgr__foreach_on_boot_done,"ax",@progbits
	.global conn_mgr__foreach_on_boot_done
conn_mgr__foreach_on_boot_done:
	.global L_8cb4c0
L_8cb4c0:
	push_s blink
L_8cb4c2:
	push_s r13
L_8cb4c4:
	mov_s r13,0x0
L_8cb4c6:
	bl.d L_8d73c4
L_8cb4ca:
	mov_s r0,r13
L_8cb4cc:
	brne_s r0,0,L_8cb4e8
L_8cb4ce:
	b_s L_8cb4e4
	.global L_8cb4d0
L_8cb4d0:
	bl.d L_8c9e44
L_8cb4d4:
	mov_s r0,r13
L_8cb4d6:
	breq_s r0,0,L_8cb4e2
L_8cb4d8:
	ldb r1,[r0, 0xb0]
L_8cb4dc:
	cmp_s r1,0x2
L_8cb4de:
	bl.eq L_8cb4a4
	.global L_8cb4e2
L_8cb4e2:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8cb4e4
L_8cb4e4:
	brlo r13,0x8,L_8cb4d0
	.global L_8cb4e8
L_8cb4e8:
	mov_s r0,0x854e00
L_8cb4ee:
	ldb_s r1,[r0,0x1d]
L_8cb4f0:
	mov_s r0,0x857260
L_8cb4f6:
	b.d L_8c033c
L_8cb4fa:
	stb_s r1,[r0,0x8]
