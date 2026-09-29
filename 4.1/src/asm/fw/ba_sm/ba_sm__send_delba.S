/* ba_sm__send_delba @ 0x8e07b8, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   ba_sm.cpp
 * Зовут его: ba_td_subsm__on_ready_to_run
 * Зовёт сам: TX_API__alloc_tx_payload, __ld_r17_to_r13_ret, __st_r17_to_r13, frame__build_delba, fw_sysassert_fatal, mgmt_tx__begin_frame, mid_list__first_of_field8, tx_api__send_mgmt
 */
	.section .text.ba_sm__send_delba,"ax",@progbits
	.global ba_sm__send_delba
ba_sm__send_delba:
	.global L_8e07b8
L_8e07b8:
	push_s blink
L_8e07ba:
	bl L_8c02b8
L_8e07be:
	sub_s sp,sp,0x4
L_8e07c0:
	mov_s r13,r0
L_8e07c2:
	bl.d L_8c2c80
L_8e07c6:
	mov_s r17,r1
L_8e07c8:
	mov_s r14,r0
L_8e07ca:
	add r13,r13,0x80
L_8e07ce:
	bl.d L_8ca1f0
L_8e07d2:
	ld_s r0,[r13,0x2c]
L_8e07d4:
	mov.f r15,r0
L_8e07d8:
	beq_s L_8e082c
	.global L_8e07da
L_8e07da:
	mov_s r0,0x0
L_8e07dc:
	mov_s r16,r0
L_8e07de:
	st_s r0,[sp,0x0]
L_8e07e0:
	ld_s r3,[r13,0x2c]
L_8e07e2:
	mov_s r1,sp
L_8e07e4:
	ld_s r3,[r3]
L_8e07e6:
	mov_s r0,r14
L_8e07e8:
	mov_s r2,r15
L_8e07ea:
	bl.d L_8e4be4
L_8e07ee:
	mov r4,0xd
L_8e07f2:
	ld_s r0,[sp,0x0]
L_8e07f4:
	ld_s r2,[r13,0x2c]
L_8e07f6:
	add_s r0,r0,r14
L_8e07f8:
	ldb_s r2,[r2,0x4]
L_8e07fa:
	mov_s r1,0x1
L_8e07fc:
	bl.d L_8ec860
L_8e0800:
	mov_s r3,r17
L_8e0802:
	ld_s r15,[sp,0x0]
L_8e0804:
	mov r5,0x76bc
L_8e080c:
	add_s r15,r15,r0
L_8e080e:
	st_s r15,[sp,0x0]
L_8e0810:
	ld_s r0,[r13,0x2c]
L_8e0812:
	extw r4,r15
L_8e0816:
	ld_s r0,[r0]
L_8e0818:
	mov_s r1,r16
L_8e081a:
	mov_s r2,0x1
L_8e081c:
	mov_s r3,r14
L_8e081e:
	bl.d L_8e0c44
L_8e0822:
	mov r6,r16
L_8e0826:
	b.d L_8c031c
L_8e082a:
	add_s sp,sp,0x4
	.global L_8e082c
L_8e082c:
	mov_s r0,blink
L_8e082e:
	mov_s r2,0x10101f0
L_8e0834:
	mov_s r1,0x1282
L_8e083a:
	bl.d L_8c82c0
L_8e083e:
	mov r3,0x131
L_8e0842:
	b_s L_8e07da
