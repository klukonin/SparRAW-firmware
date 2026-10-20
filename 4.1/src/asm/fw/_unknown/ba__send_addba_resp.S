/* ba__send_addba_resp @ 0x8c38dc, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ADDBA RESP send: tid %d , token %d, STATUS REFUSED
 * Зовут его: stream_mgr__rx_action
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r16_to_r13_ret, __st_r16_to_r13, frame__build_addba_resp, fw_log__emit2, mgmt_tx__begin_frame, tx_api__send_mgmt
 */
	.section .text.ba__send_addba_resp,"ax",@progbits
	.global ba__send_addba_resp
ba__send_addba_resp:
	.global L_8c38dc
L_8c38dc:
	push_s blink
L_8c38de:
	bl L_8c02bc
L_8c38e2:
	mov_s r13,r0
L_8c38e4:
	mov_s r14,r1
L_8c38e6:
	mov_s r15,0x0
L_8c38e8:
	bl.d L_8c2c80
L_8c38ec:
	push_s r15
L_8c38ee:
	mov_s r16,r0
L_8c38f0:
	mov_s r1,sp
L_8c38f2:
	ld_s r2,[r14,0xc]
L_8c38f4:
	mov_s r3,r14
L_8c38f6:
	bl.d L_8e4be4
L_8c38fa:
	mov r4,0xd
L_8c38fe:
	ld_s r0,[sp,0x0]
L_8c3900:
	ldb_s r3,[r13,0x3]
L_8c3902:
	add_s r0,r0,r16
L_8c3904:
	lsr_s r3,r3,0x2
L_8c3906:
	ldb_s r1,[r13,0x2]
L_8c3908:
	mov_s r2,r15
L_8c390a:
	bmsk_s r3,r3,0x3
L_8c390c:
	mov_s r4,r15
L_8c390e:
	mov r5,0x1
L_8c3912:
	bl.d L_8ec664
L_8c3916:
	mov_s r6,r15
L_8c3918:
	ld_s r1,[sp,0x0]
L_8c391a:
	mov_s r2,0x1
L_8c391c:
	add_s r0,r0,r1
L_8c391e:
	st_s r0,[sp,0x0]
L_8c3920:
	extw r4,r0
L_8c3924:
	mov_s r0,r14
L_8c3926:
	mov_s r1,r15
L_8c3928:
	mov_s r3,r16
L_8c392a:
	mov_s r5,r15
L_8c392c:
	bl.d L_8e0c44
L_8c3930:
	mov_s r6,r15
L_8c3932:
	ldb_s r3,[r13,0x3]
L_8c3934:
	mov_s r2,0x100e4e8
L_8c393a:
	lsr_s r3,r3,0x2
L_8c393c:
	ldb r4,[r13, 0x2]
L_8c3940:
	mov_s r0,0xb
L_8c3942:
	mov_s r1,0x2
L_8c3944:
	bl.d L_8edff8
L_8c3948:
	bmsk_s r3,r3,0x3
L_8c394a:
	b.d L_8c0324
L_8c394e:
	add_s sp,sp,0x4
