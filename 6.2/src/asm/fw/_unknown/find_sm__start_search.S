/* find_sm__start_search @ 0x8f9920, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2_mgr__scan_start_log
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, memcpy_fw, memset0_words, scan_mngr__start_scan, sort_scan_ch_list
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global find_sm__start_search
find_sm__start_search:
	.global L_8f9920
L_8f9920:
	push_s blink
L_8f9922:
	bl L_8c01d8
L_8f9926:
	mov_s r17,r0
L_8f9928:
	mov_s r14,r1
L_8f992a:
	mov_s r13,r0
L_8f992c:
	add r13,r13,0x200
L_8f9930:
	st_s r2,[r13,0xc]
L_8f9932:
	st_s r3,[r13,0x10]
L_8f9934:
	ldb_s r0,[r1,0x6]
L_8f9936:
	mov_s r16,r3
L_8f9938:
	stb r0,[r13, -0x2]
L_8f993c:
	ldw_s r0,[r14,0xa]
L_8f993e:
	ldw_s r1,[r14,0x8]
L_8f9940:
	asl_s r0,r0,0x10
L_8f9942:
	or_s r1,r1,r0
L_8f9944:
	st_s r1,[r13]
L_8f9946:
	ldw_s r0,[r14,0xe]
L_8f9948:
	ldw_s r1,[r14,0xc]
L_8f994a:
	asl_s r0,r0,0x10
L_8f994c:
	or_s r1,r1,r0
L_8f994e:
	st_s r1,[r13,0x4]
L_8f9950:
	ldb_s r0,[r14,0x10]
L_8f9952:
	mov_s r15,r2
L_8f9954:
	stb_s r0,[r13,0x8]
L_8f9956:
	ldb_s r0,[r14,0x11]
L_8f9958:
	mov_s r1,r14
L_8f995a:
	stb_s r0,[r13,0x9]
L_8f995c:
	sub r0,r13,0x8
L_8f9960:
	bl.d L_8c0380
L_8f9964:
	mov_s r2,0x6
L_8f9966:
	mov_s r0,0x0
L_8f9968:
	stb_s r0,[r13,0x14]
L_8f996a:
	mov_s r0,r17
L_8f996c:
	add r0,r0,0x1c4
L_8f9970:
	bl.d L_8c1cd8
L_8f9974:
	mov_s r1,0x4
L_8f9976:
	mov_s r1,r17
L_8f9978:
	add r1,r1,0x1e4
L_8f997c:
	bl.d L_8f91c8
L_8f9980:
	mov_s r0,r14
L_8f9982:
	mov_s r0,r17
L_8f9984:
	mov_s r1,r14
L_8f9986:
	mov_s r2,r15
L_8f9988:
	bl.d L_8f9780
L_8f998c:
	mov_s r3,r16
L_8f998e:
	b L_8c023c
L_8f9992:
	nop_s
