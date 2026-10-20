/* sort_scan_ch_list @ 0x8f0e04, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr.cpp
 *   sort_scan_ch_list() current chan %d - channel[0] %d -->%d
 *   [NNL]  channel[1] %d channel[2] %d channel[3] %d
 * Зовут его: scan_mngr__start_scan
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit3, fw_sysassert_fatal, get_g_800140_8c9f8c
 */
	.section .text.sort_scan_ch_list,"ax",@progbits
	.global sort_scan_ch_list
sort_scan_ch_list:
	.global L_8f0e04
L_8f0e04:
	push_s blink
L_8f0e06:
	bl L_8c02c4
L_8f0e0a:
	sub_s sp,sp,0x4
L_8f0e0c:
	mov_s r14,r0
L_8f0e0e:
	mov_s r13,r1
L_8f0e10:
	bl.d L_8c9f8c
L_8f0e14:
	mov_s r0,sp
L_8f0e16:
	ldb_s r0,[r14,0x11]
L_8f0e18:
	brhs r0,0x5,L_8f0e3e
	.global L_8f0e1c
L_8f0e1c:
	ldb_s r0,[r14,0x11]
L_8f0e1e:
	ld_s r3,[sp,0x0]
L_8f0e20:
	sub_s r1,r0,0x1
L_8f0e22:
	cmp_s r1,0x0
L_8f0e24:
	mov.ge lp_count,r0
L_8f0e28:
	mov.ge r2,r1
L_8f0e2c:
	lpge L_8f0e60
L_8f0e30:
	add1 r0,r14,r2
L_8f0e34:
	ldb_s r0,[r0,0x12]
L_8f0e36:
	brne r0,r3,L_8f0e54
L_8f0e3a:
	st_s r3,[r13]
L_8f0e3c:
	b_s L_8f0e5c
	.global L_8f0e3e
L_8f0e3e:
	mov_s r0,blink
L_8f0e40:
	mov_s r2,0x1012bb8
L_8f0e46:
	mov_s r1,0x1470
L_8f0e4c:
	bl.d L_8c82c0
L_8f0e50:
	mov_s r3,0x80
L_8f0e52:
	b_s L_8f0e1c
	.global L_8f0e54
L_8f0e54:
	add2 r12,r13,r1
L_8f0e58:
	st_s r0,[r12]
L_8f0e5a:
	/* sub_s r1,r1,0x1 */
	.byte 0x61,0xb9
	.global L_8f0e5c
L_8f0e5c:
	ld_s r3,[sp,0x0]
L_8f0e5e:
	/* sub_s r2,r2,0x1 */
	.byte 0x61,0xba
	.global L_8f0e60
L_8f0e60:
	ld r4,[r13]
L_8f0e64:
	mov_s r2,0x1012bc8
L_8f0e6a:
	ldb r5,[r14, 0x11]
L_8f0e6e:
	mov_s r0,0x9
L_8f0e70:
	bl.d L_8ee034
L_8f0e74:
	mov_s r1,0x2
L_8f0e76:
	ld r4,[r13, 0x8]
L_8f0e7a:
	mov_s r2,0x1012c04
L_8f0e80:
	ld r5,[r13, 0xc]
L_8f0e84:
	mov_s r0,0x9
L_8f0e86:
	mov_s r1,0x2
L_8f0e88:
	bl.d L_8ee034
L_8f0e8c:
	ld_s r3,[r13,0x4]
L_8f0e8e:
	b.d L_8c0334
L_8f0e92:
	add_s sp,sp,0x4
