/* rx_macq__program_offload_desc @ 0x8df65c, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__data_port_open_and_keys, rx_macq__program_offload_desc_with_b4, rx_macq__setup
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ese__set_alloc_type, macq_desc__write
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rx_macq__program_offload_desc
rx_macq__program_offload_desc:
	.global L_8df65c
L_8df65c:
	push_s blink
L_8df65e:
	bl L_8c01e4
L_8df662:
	mov_s r13,r0
L_8df664:
	ld_s r3,[r0,0xc]
L_8df666:
	mov_s r14,0x847fc8
L_8df66c:
	cmp_s r3,0x1
L_8df66e:
	mov_s r3,0x1
L_8df670:
	sub_s.ne r3,r3,r3
L_8df672:
	ldb_s r1,[r13,0x1]
L_8df674:
	add r0,r14,0x10
L_8df678:
	bl.d L_8e4220
L_8df67c:
	ldb_s r2,[r13,0x4]
L_8df67e:
	add r0,r14,0x10
L_8df682:
	ldb_s r1,[r13]
L_8df684:
	mov_s r2,0x1
L_8df686:
	mov_s r3,0x0
L_8df688:
	mov_s r4,r3
L_8df68a:
	mov_s r5,r3
L_8df68c:
	mov_s r6,r2
L_8df68e:
	bl.d L_8c5010
L_8df692:
	mov_s r7,r2
L_8df694:
	b L_8c0254
