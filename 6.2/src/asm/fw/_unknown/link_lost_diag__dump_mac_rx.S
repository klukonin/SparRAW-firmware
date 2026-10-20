/* link_lost_diag__dump_mac_rx @ 0x8c8568, 208 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   DEBUG MAC RX: CRC_OK=%d CRC_ERR= %d
 *   DEBUG MAC RX: PPDU Report 1: 0x%08x
 *   DEBUG MAC RX: PPDU Report 2: 0x%08x
 *   DEBUG MAC RX: PPDU Report 3: 0x%08x
 *   DEBUG MAC RX: PPDU Report 4: 0x%08x
 *   DEBUG MAC RX: UCODE 1st buffer Backdoor dump beginning at 0x%x:
 *   				0x%08x
 *   DEBUG MAC RX: UCODE 2nd buffer Backdoor dump beginning at 0x%x:
 * Зовут его: link_lost_diag__dump_all
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_log_emit1, fw_log_emit2, mac_rx_cnt__get_crc_err, mac_rx_cnt__get_crc_ok
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global link_lost_diag__dump_mac_rx
link_lost_diag__dump_mac_rx:
	.global L_8c8568
L_8c8568:
	push_s blink
L_8c856a:
	bl L_8c01dc
L_8c856e:
	bl L_8dd8b0
L_8c8572:
	bl.d L_8dd8a8
L_8c8576:
	mov_s r16,r0
L_8c8578:
	mov_s r3,r0
L_8c857a:
	mov_s r1,0x1001138
L_8c8580:
	mov_s r0,0x20
L_8c8582:
	bl.d L_8dcc80
L_8c8586:
	mov_s r2,r16
L_8c8588:
	mov_s r13,0x886e00
L_8c858e:
	ld_s r2,[r13,0x58]
L_8c8590:
	mov_s r1,0x100115c
L_8c8596:
	mov_s r15,0x887000
L_8c859c:
	bl.d L_8dcc10
L_8c85a0:
	mov_s r0,0x20
L_8c85a2:
	ld_s r2,[r13,0x5c]
L_8c85a4:
	mov_s r1,0x1001180
L_8c85aa:
	bl.d L_8dcc10
L_8c85ae:
	mov_s r0,0x20
L_8c85b0:
	ld_s r2,[r13,0x60]
L_8c85b2:
	mov_s r1,0x10011a4
L_8c85b8:
	bl.d L_8dcc10
L_8c85bc:
	mov_s r0,0x20
L_8c85be:
	ld_s r2,[r13,0x64]
L_8c85c0:
	mov_s r1,0x10011c8
L_8c85c6:
	bl.d L_8dcc10
L_8c85ca:
	mov_s r0,0x20
L_8c85cc:
	mov_s r14,0x944000
L_8c85d2:
	st.as 0x32000000,[r15,-0x8e]
L_8c85da:
	mov_s r1,0x10011ec
L_8c85e0:
	mov_s r0,0x20
L_8c85e2:
	bl.d L_8dcc10
L_8c85e6:
	mov_s r2,r14
L_8c85e8:
	mov_s r13,0x18
	.global L_8c85ea
L_8c85ea:
	ld.ab r2,[r14,0x4]
L_8c85ee:
	mov_s r1,0x100122c
L_8c85f4:
	bl.d L_8dcc10
L_8c85f8:
	mov_s r0,0x20
L_8c85fa:
	/* sub_s r13,r13,0x1 */
	.byte 0x61,0xbd
L_8c85fc:
	brhs r13,0x1,L_8c85ea
L_8c8600:
	mov_s r13,0x944000
L_8c8606:
	st.as 0x32000001,[r15,-0x8e]
L_8c860e:
	mov_s r1,0x1001238
L_8c8614:
	mov_s r0,0x20
L_8c8616:
	bl.d L_8dcc10
L_8c861a:
	mov_s r2,r13
L_8c861c:
	mov_s r14,0x18
	.global L_8c861e
L_8c861e:
	ld.ab r2,[r13,0x4]
L_8c8622:
	mov_s r1,0x100122c
L_8c8628:
	bl.d L_8dcc10
L_8c862c:
	mov_s r0,0x20
L_8c862e:
	/* sub_s r14,r14,0x1 */
	.byte 0x61,0xbe
L_8c8630:
	brhs r14,0x1,L_8c861e
L_8c8634:
	b L_8c0244
