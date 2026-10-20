/* fill_statistics_to_host @ 0x8c88d4, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   fill_statistics_to_host() reported rssi value %d
 * Зовут его: host_if__timestamp_sync, l2mgr__send_notify_req_done
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, frag_8ca810, frag_8caca8, fw_log__emit1, link_stats__calc_throughput_mbps
 */
	.section .text.fill_statistics_to_host,"ax",@progbits
	.global fill_statistics_to_host
fill_statistics_to_host:
	.global L_8c88d4
L_8c88d4:
	push_s blink
L_8c88d6:
	bl L_8c02c4
L_8c88da:
	mov_s r13,r0
L_8c88dc:
	ld_s r0,[r0,0x18]
L_8c88de:
	mov_s r14,r1
L_8c88e0:
	st_s r0,[r1]
L_8c88e2:
	mov_s r1,0x886e80
L_8c88e8:
	ld_s r0,[r1,0x3c]
L_8c88ea:
	st_s r0,[r14,0x8]
L_8c88ec:
	ld_s r0,[r1,0x38]
L_8c88ee:
	st_s r0,[r14,0x4]
L_8c88f0:
	mov_s r0,0x0
L_8c88f2:
	stw_s r0,[r14,0x26]
L_8c88f4:
	ld_s r1,[r13,0x18]
L_8c88f6:
	cmp_s r1,0x0
L_8c88f8:
	cmp.ne r1,0x2
L_8c88fc:
	bne_s L_8c8912
L_8c88fe:
	stb_s r0,[r14,0xc]
L_8c8900:
	st_s r0,[r14,0x10]
L_8c8902:
	st_s r0,[r14,0x14]
L_8c8904:
	st_s r0,[r14,0x18]
L_8c8906:
	stw_s r0,[r14,0x1c]
L_8c8908:
	mov_s r0,0xff
L_8c890a:
	stw_s r0,[r14,0x1e]
L_8c890c:
	stw_s r0,[r14,0x20]
L_8c890e:
	stw_s r0,[r14,0x22]
L_8c8910:
	b_s L_8c8950
	.global L_8c8912
L_8c8912:
	ld_s r0,[r13,0xc]
L_8c8914:
	sub r0,r0,0x48
L_8c8918:
	stb_s r0,[r14,0xc]
L_8c891a:
	ldb r0,[r13, 0x2c]
L_8c891e:
	ldb r1,[r13, 0x30]
L_8c8922:
	bl.d L_8c4a00
L_8c8926:
	ldb r2,[r13, 0x39]
L_8c892a:
	st_s r0,[r14,0x10]
L_8c892c:
	bl.d L_8caca8
L_8c8930:
	ld_s r0,[r13]
L_8c8932:
	st_s r0,[r14,0x14]
L_8c8934:
	bl.d L_8ca810
L_8c8938:
	ld_s r0,[r13]
L_8c893a:
	st_s r0,[r14,0x18]
L_8c893c:
	ldb r0,[r13, 0x39]
L_8c8940:
	stw_s r0,[r14,0x1c]
L_8c8942:
	ldb_s r0,[r13,0x11]
L_8c8944:
	stw_s r0,[r14,0x1e]
L_8c8946:
	ldb_s r0,[r13,0x12]
L_8c8948:
	stw_s r0,[r14,0x20]
L_8c894a:
	ldb_s r0,[r13,0x13]
L_8c894c:
	stw_s r0,[r14,0x22]
L_8c894e:
	ldb_s r0,[r13,0x14]
	.global L_8c8950
L_8c8950:
	stw_s r0,[r14,0x24]
L_8c8952:
	mov_s r2,0x1010e70
L_8c8958:
	mov_s r0,0xb
L_8c895a:
	mov_s r1,0x2
L_8c895c:
	bl.d L_8edfcc
L_8c8960:
	ldb.x r3,[r14, 0xc]
L_8c8964:
	ld_s r0,[r13,0x4]
L_8c8966:
	ldb r0,[r0,0x185]
L_8c896e:
	b.d L_8c0334
L_8c8972:
	stb r0,[r14, 0x28]
L_8c8976:
	nop_s
