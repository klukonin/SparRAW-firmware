/* conn_mgr__bi_evt_all_conns @ 0x8cd8f4, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__system_state_evt_handler
 * Зовёт сам: __ld_r13_to_r13_ret, bad_beacons__on_bi_evt, conn_mgr__by_cid, mid__state_is_2_or_3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_mgr__bi_evt_all_conns
conn_mgr__bi_evt_all_conns:
	.global L_8cd8f4
L_8cd8f4:
	push_s blink
L_8cd8f6:
	push_s r13
L_8cd8f8:
	mov_s r13,0x0
L_8cd8fa:
	bl.d L_8da488
L_8cd8fe:
	mov_s r0,r13
L_8cd900:
	brne_s r0,0,L_8cd91c
L_8cd902:
	b_s L_8cd918
	.global L_8cd904
L_8cd904:
	bl.d L_8cbffc
L_8cd908:
	mov_s r0,r13
L_8cd90a:
	breq_s r0,0,L_8cd916
L_8cd90c:
	ldb r1,[r0, 0xf0]
L_8cd910:
	cmp_s r1,0x2
L_8cd912:
	bl.eq L_8cd880
	.global L_8cd916
L_8cd916:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
	.global L_8cd918
L_8cd918:
	brlo r13,0x8,L_8cd904
	.global L_8cd91c
L_8cd91c:
	mov_s r1,0x803c00
L_8cd922:
	ld_s r0,[r1,0xc]
L_8cd924:
	brne_s r0,0,L_8cd93a
L_8cd926:
	ld_s r0,[r1,0x10]
L_8cd928:
	brne_s r0,0,L_8cd93a
L_8cd92a:
	mov_s r0,0x853960
L_8cd930:
	ldb_s r1,[r0,0x1d]
L_8cd932:
	mov_s r0,0x857260
L_8cd938:
	stb_s r1,[r0]
	.global L_8cd93a
L_8cd93a:
	b L_8c025c
L_8cd93e:
	nop_s
