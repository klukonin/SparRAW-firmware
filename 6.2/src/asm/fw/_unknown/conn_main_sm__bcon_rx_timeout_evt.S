/* conn_main_sm__bcon_rx_timeout_evt @ 0x8c4804, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *    conn_main_sm::bcon_rx_timeout_evt m_omni_loop_index = %d
 *    conn_main_sm::bcon_rx_timeout_evt
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, basic_sm__handle_event, fw_log_emit0, fw_log_emit1, hw_sysapi_rx_omni_sector_set, u_schd__schedule
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global conn_main_sm__bcon_rx_timeout_evt
conn_main_sm__bcon_rx_timeout_evt:
	.global L_8c4804
L_8c4804:
	j_s [blink]
L_8c4806:
	nop_s
L_8c4808:
	push_s blink
L_8c480a:
	bl L_8c01e4
L_8c480e:
	mov_s r14,r0
L_8c4810:
	mov_s r1,0x1011b64
L_8c4816:
	add r13,r0,0x20
L_8c481a:
	mov_s r0,0x2b
L_8c481c:
	bl.d L_8dcc10
L_8c4820:
	ldb_s r2,[r13,0x1c]
L_8c4822:
	ldb_s r0,[r13,0x1c]
L_8c4824:
	mov_s r1,0x857720
L_8c482a:
	/* add_s r0,0x1 */
	.byte 0x01,0xe0
L_8c482c:
	extb_s r0,r0
L_8c482e:
	stb_s r0,[r13,0x1c]
L_8c4830:
	ldb_s r1,[r1,0x1c]
L_8c4832:
	brge.d r0,r1,L_8c4872
L_8c4836:
	mov_s r13,0x0
L_8c4838:
	ld_s r1,[r14,0x8]
L_8c483a:
	ldw_s r1,[r1,0xc]
L_8c483c:
	brne r1,0xffff,L_8c4872
L_8c4844:
	bl L_8ce40c
L_8c4848:
	ldb r1,[gp, 0xad]
L_8c484c:
	mov_s r0,0x4808
L_8c4852:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c4854:
	/* mul64 r1,0x493e0 */
	.byte 0x04,0x29,0x81,0x0f,0x04,0x00,0xe0,0x93
L_8c485c:
	mov_s r1,r14
L_8c485e:
	mov_s r2,r13
L_8c4860:
	mov_s r3,0x1
L_8c4862:
	mov r4,mlo
L_8c4866:
	mov_s r5,r13
L_8c4868:
	bl.d L_8e0c0c
L_8c486c:
	mov_s r6,r13
L_8c486e:
	st_s r0,[r14,0x2c]
L_8c4870:
	b_s L_8c488e
	.global L_8c4872
L_8c4872:
	mov_s r1,0x1011ba0
L_8c4878:
	bl.d L_8dcba8
L_8c487c:
	mov_s r0,0x1b
L_8c487e:
	st_s r13,[r14,0x2c]
L_8c4880:
	mov_s r0,r14
L_8c4882:
	mov_s r1,0x1
L_8c4884:
	mov_s r2,0x0
L_8c4886:
	mov_s r3,r2
L_8c4888:
	bl.d L_8d9b6c
L_8c488c:
	mov_s r4,r2
	.global L_8c488e
L_8c488e:
	b L_8c0254
L_8c4892:
	nop_s
