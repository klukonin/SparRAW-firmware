/* vring_schd__fill_vring_cfg @ 0x8e78cc, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: STREAM_MGR__ADD
 * Зовёт сам: __ld_r18_to_r13_ret, __st_r18_to_r13, fw_sysassert_fatal, vring__ack_and_unmask_irq, vring__get_pring_id
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring_schd__fill_vring_cfg
vring_schd__fill_vring_cfg:
	.global L_8e78cc
L_8e78cc:
	push_s blink
L_8e78ce:
	bl L_8c01d4
L_8e78d2:
	mov_s r14,r0
L_8e78d4:
	mov_s r13,r1
L_8e78d6:
	mov_s r16,r2
L_8e78d8:
	mov_s r15,r3
L_8e78da:
	mov r17,r4
L_8e78de:
	mov r18,r5
L_8e78e2:
	brne r5,0x1,L_8e78ec
L_8e78e6:
	breq_s r15,0,L_8e791c
	.global L_8e78e8
L_8e78e8:
	ld_s r0,[r14,0x24]
L_8e78ea:
	brne_s r0,0,L_8e792a
	.global L_8e78ec
L_8e78ec:
	ldb_s r0,[r13,0x6]
L_8e78ee:
	stb_s r0,[r14,0x8]
L_8e78f0:
	ldb_s r0,[r13,0x7]
L_8e78f2:
	stb_s r0,[r14,0x9]
L_8e78f4:
	bl.d L_8cbed8
L_8e78f8:
	mov_s r0,r13
L_8e78fa:
	stb_s r0,[r14,0xa]
L_8e78fc:
	stb r16,[r14, 0xb]
L_8e7900:
	stw_s r15,[r14,0xc]
L_8e7902:
	st r17,[r14, 0x10]
L_8e7906:
	mov_s r0,0x0
L_8e7908:
	st_s r0,[r14,0x14]
L_8e790a:
	st_s r0,[r14,0x18]
L_8e790c:
	st_s r0,[r14,0x1c]
L_8e790e:
	st r18,[r14, 0x20]
L_8e7912:
	bl.d L_8d85d4
L_8e7916:
	mov_s r0,r14
L_8e7918:
	b L_8c0234
	.global L_8e791c
L_8e791c:
	mov_s r0,blink
L_8e791e:
	mov_s r1,0x12b2
L_8e7924:
	bl L_8c9b28
L_8e7928:
	b_s L_8e78e8
	.global L_8e792a
L_8e792a:
	mov_s r0,blink
L_8e792c:
	mov_s r1,0x12b3
L_8e7932:
	bl L_8c9b28
L_8e7936:
	b_s L_8e78ec
