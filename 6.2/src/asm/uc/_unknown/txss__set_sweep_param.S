/* txss__set_sweep_param @ 0x9357ec, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bti_worker__bti_transmitter_beacon_sweep_flow, txss__program_tx_frame, ucode_cmd_0x0c_handler
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, memcpy_uc, ss_plan__next_sector, txss__order_known_sectors_first
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global txss__set_sweep_param
txss__set_sweep_param:
	.global L_9357ec
L_9357ec:
	push_s blink
L_9357ee:
	bl.d L_920228
L_9357f2:
	mov_s r6,r2
L_9357f4:
	mov_s r15,r0
L_9357f6:
	mov_s r13,r1
L_9357f8:
	mov_s r14,0x802e4c
L_9357fe:
	stb r4,[r14, 0x10]
L_935802:
	mov r16,0x0
L_935806:
	mov_s r2,0x857780
L_93580c:
	ld_s r2,[r2,0x30]
L_93580e:
	stb r16,[r14, 0x11]
L_935812:
	add1 r2,r2,r5
L_935816:
	ldb_s r0,[r2]
L_935818:
	mov_s r1,0x802eec
L_93581e:
	stb_s r0,[r14,0x14]
L_935820:
	stb r6,[r14, 0x13]
L_935824:
	ldw_s r2,[r15]
L_935826:
	ldw_s r0,[r15,0x4]
L_935828:
	mov r17,0x802e0c
L_935830:
	add_s r0,r0,r2
L_935832:
	mov_s r2,0x802dec
L_935838:
	st_s r0,[r2,0x68]
L_93583a:
	breq_s r3,0,L_93584a
L_93583c:
	add r0,r13,0x8
L_935840:
	bl.d L_938088
L_935844:
	sub r1,r1,0xd8
L_935848:
	b_s L_93585a
	.global L_93584a
L_93584a:
	sub3 r0,r1,0x1b
L_93584e:
	add r1,r13,0x8
L_935852:
	bl.d L_920330
L_935856:
	ldb r2,[r13, 0x48]
	.global L_93585a
L_93585a:
	ldb r0,[r13, 0x48]
L_93585e:
	cmp_s r0,0x40
L_935860:
	bge_s L_935868
L_935862:
	mov_s r2,0xff
L_935864:
	add_s r0,r0,r17
L_935866:
	stb_s r2,[r0,0x8]
	.global L_935868
L_935868:
	stb r16,[r14, 0x15]
L_93586c:
	mov_s r0,r15
L_93586e:
	bl.d L_935878
L_935872:
	mov_s r1,0x0
L_935874:
	b L_92028c
