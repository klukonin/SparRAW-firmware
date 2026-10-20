/* sort_scan_ch_list @ 0x8f91c8, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   sort_scan_ch_list() current chan %d - channel[0] %d -->%d
 *   [NNL]  channel[1] %d channel[2] %d channel[3] %d
 * Зовут его: find_sm__start_search
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit3, fw_sysassert_fatal, radio_mgr__get_current_channel
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global sort_scan_ch_list
sort_scan_ch_list:
	.global L_8f91c8
L_8f91c8:
	push_s blink
L_8f91ca:
	bl L_8c01e4
L_8f91ce:
	sub_s sp,sp,0x4
L_8f91d0:
	mov_s r14,r0
L_8f91d2:
	mov_s r13,r1
L_8f91d4:
	bl.d L_8cc130
L_8f91d8:
	mov_s r0,sp
L_8f91da:
	ldb_s r0,[r14,0x11]
L_8f91dc:
	brhs r0,0x5,L_8f9202
	.global L_8f91e0
L_8f91e0:
	ldb_s r0,[r14,0x11]
L_8f91e2:
	ld_s r2,[sp,0x0]
L_8f91e4:
	sub_s r1,r0,0x1
L_8f91e6:
	cmp_s r1,0x0
L_8f91e8:
	mov.ge lp_count,r0
L_8f91ec:
	mov.ge r3,r1
L_8f91f0:
	lpge L_8f921c
L_8f91f4:
	add1 r0,r14,r3
L_8f91f8:
	ldb_s r0,[r0,0x12]
L_8f91fa:
	brne r0,r2,L_8f9210
L_8f91fe:
	st_s r2,[r13]
L_8f9200:
	b_s L_8f9218
	.global L_8f9202
L_8f9202:
	mov_s r0,blink
L_8f9204:
	mov_s r1,0x1470
L_8f920a:
	bl L_8c9b28
L_8f920e:
	b_s L_8f91e0
	.global L_8f9210
L_8f9210:
	add2 r12,r13,r1
L_8f9214:
	st_s r0,[r12]
L_8f9216:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
	.global L_8f9218
L_8f9218:
	ld_s r2,[sp,0x0]
L_8f921a:
	/* sub_s r3,r3,0x1 */
	.byte 0x61,0xbb
	.global L_8f921c
L_8f921c:
	mov_s r1,0x101508c
L_8f9222:
	ldb r4,[r14, 0x11]
L_8f9226:
	mov_s r0,0x29
L_8f9228:
	bl.d L_8dcd00
L_8f922c:
	ld_s r3,[r13]
L_8f922e:
	mov_s r1,0x10150c8
L_8f9234:
	ld r4,[r13, 0xc]
L_8f9238:
	mov_s r0,0x29
L_8f923a:
	ld_s r2,[r13,0x4]
L_8f923c:
	bl.d L_8dcd00
L_8f9240:
	ld_s r3,[r13,0x8]
L_8f9242:
	b.d L_8c0254
L_8f9246:
	add_s sp,sp,0x4
