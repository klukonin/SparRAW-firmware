/* bad_beacons__on_bi_evt @ 0x8cd880, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   curr TSF: 0x%08x%08x
 *   BTI start time: 0x%08x%08x
 *   AP RESET -> TFS RESET -> DISCONNECT
 * Зовут его: conn_mgr__bi_evt_all_conns
 * Зовёт сам: __ld_r13_to_r13_ret, bad_beacons_detector__handle_bcons_info, fw_log_emit0, fw_log_emit2, mac_read_tsf64
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global bad_beacons__on_bi_evt
bad_beacons__on_bi_evt:
	.global L_8cd880
L_8cd880:
	b.d L_8cd888
L_8cd884:
	add_s r0,r0,0x70
L_8cd886:
	nop_s
	.global L_8cd888
L_8cd888:
	push_s blink
L_8cd88a:
	push_s r13
L_8cd88c:
	sub_s sp,sp,0x8
L_8cd88e:
	mov_s r13,r0
L_8cd890:
	mov_s r1,sp
L_8cd892:
	mov_s r0,0x0
L_8cd894:
	bl.d L_8e9900
L_8cd898:
	mov_s r2,r0
L_8cd89a:
	ld_s r0,[r13,0x7c]
L_8cd89c:
	cmp_s r0,0x0
L_8cd89e:
	bl.ne.d L_8cd1e8
L_8cd8a2:
	add3.ne r0,r0,0x13
L_8cd8a6:
	mov_s r0,0x853a00
L_8cd8ac:
	ld r1,[r0, -0xb4]
L_8cd8b0:
	ld r0,[r0, -0xb0]
L_8cd8b4:
	ld_s r2,[sp,0x4]
L_8cd8b6:
	ld_s r3,[sp,0x0]
L_8cd8b8:
	cmp_s r0,r2
L_8cd8ba:
	cmp.eq r1,r3
L_8cd8be:
	bls_s L_8cd8ee
L_8cd8c0:
	mov_s r1,0x1014374
L_8cd8c6:
	bl.d L_8dcc80
L_8cd8ca:
	mov_s r0,0x1b
L_8cd8cc:
	mov_s r3,0x853900
L_8cd8d2:
	ld_s r2,[r3,0x50]
L_8cd8d4:
	mov_s r1,0x101438c
L_8cd8da:
	mov_s r0,0x1b
L_8cd8dc:
	bl.d L_8dcc80
L_8cd8e0:
	ld_s r3,[r3,0x4c]
L_8cd8e2:
	mov_s r1,0x10143a8
L_8cd8e8:
	bl.d L_8dcba8
L_8cd8ec:
	mov_s r0,0x1b
	.global L_8cd8ee
L_8cd8ee:
	b.d L_8c025c
L_8cd8f2:
	add_s sp,sp,0x8
