/* low_sme__send_evt2sw @ 0x8e08c8, 188 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SMID %d is not secured - fake key installation
 *   low_sme::send_evt2sw type = 0x%x (continue2sw = %d)
 * Зовёт сам: __ld_r20_to_r13_ret, __st_r20_to_r13, basic_if__post_event, basic_if__send_msg, conn_mgr__by_cid, fw_log__emit0, fw_log__emit2, l2mgr__notify_key_ready, mid__conn_state_ne_1, u_schd__add
 */
	.section .text.low_sme__send_evt2sw,"ax",@progbits
	.global low_sme__send_evt2sw
low_sme__send_evt2sw:
L_8e08c8:
	/* b_s 0x008e089a */
	.byte 0xe9,0xf1
	.global fwlog_low_sme_send_evt2sw_type_0x_x_continue2s
fwlog_low_sme_send_evt2sw_type_0x_x_continue2s:
L_8e08ca:
	nop_s
L_8e08cc:
	push_s blink
L_8e08ce:
	bl L_8c02ac
L_8e08d2:
	mov_s r14,r0
L_8e08d4:
	mov_s r13,r1
L_8e08d6:
	mov_s r20,r2
L_8e08d8:
	mov_s r19,r3
L_8e08da:
	mov r18,r4
L_8e08de:
	mov r17,r5
L_8e08e2:
	ld.as r16,[gp,-0x54]
L_8e08e6:
	breq r1,0x15,L_8e0930
L_8e08ea:
	breq r13,0x1002,L_8e090c
L_8e08f2:
	brne r13,0x100a,L_8e093a
L_8e08fa:
	mov_s r0,0x28860
L_8e0900:
	mov_s r1,0x0
L_8e0902:
	mov_s r2,r1
L_8e0904:
	bl.d L_8c2ac8
L_8e0908:
	mov_s r3,0x1
L_8e090a:
	b_s L_8e093a
	.global L_8e090c
L_8e090c:
	bl.d L_8c9e44
L_8e0910:
	ldb_s r0,[r14,0x13]
L_8e0912:
	bl.d L_8ed820
L_8e0916:
	mov_s r15,r0
L_8e0918:
	brne_s r0,0,L_8e093a
L_8e091a:
	mov_s r2,0x100a480
L_8e0920:
	mov_s r0,0xe
L_8e0922:
	bl.d L_8edfb0
L_8e0926:
	mov_s r1,0x2
L_8e0928:
	bl.d L_8ed5d4
L_8e092c:
	mov_s r0,r15
L_8e092e:
	b_s L_8e093a
	.global L_8e0930
L_8e0930:
	bl.d L_8c9e44
L_8e0934:
	ldb_s r0,[r14,0x9]
L_8e0936:
	bl L_8ed5d4
	.global L_8e093a
L_8e093a:
	mov_s r2,0x100a4b0
L_8e0940:
	mov_s r0,0x0
L_8e0942:
	mov_s r1,0x2
L_8e0944:
	mov_s r3,r13
L_8e0946:
	bl.d L_8edff8
L_8e094a:
	mov r4,r16
L_8e094e:
	mov_s r0,0x8043d4
L_8e0954:
	ld_s r0,[r0,0x2c]
L_8e0956:
	mov_s r1,r14
L_8e0958:
	breq r16,0x0,L_8e0976
L_8e095c:
	mov_s r2,0x0
L_8e095e:
	mov_s r3,r13
L_8e0960:
	mov r4,r20
L_8e0964:
	mov r5,r19
L_8e0968:
	mov r6,r18
L_8e096c:
	bl.d L_8e0460
L_8e0970:
	mov r7,r17
L_8e0974:
	b_s L_8e097e
	.global L_8e0976
L_8e0976:
	mov_s r2,r18
L_8e0978:
	bl.d L_8c9598
L_8e097c:
	mov_s r3,r17
	.global L_8e097e
L_8e097e:
	b L_8c0304
L_8e0982:
	nop_s
