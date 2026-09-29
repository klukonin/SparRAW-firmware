/* connection__init @ 0x8f54a4, 136 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mid__link_acquisition_action, pbss__alloc_sta_entry, scan_mngr__prob_done
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, connection__init_fields, connection__store_ptr, fw_sysassert_fatal, memcpy_fw, obj_vt802458__ctor, obj_vt802744__ctor, obj_vt803424__ctor
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global connection__init
connection__init:
	.global L_8f54a4
L_8f54a4:
	push_s blink
L_8f54a6:
	bl L_8c01d8
L_8f54aa:
	mov_s r14,r0
L_8f54ac:
	mov_s r15,r0
L_8f54ae:
	add r15,r15,0x124
L_8f54b2:
	ldb_s r0,[r15]
L_8f54b4:
	mov_s r17,r1
L_8f54b6:
	mov_s r16,r2
L_8f54b8:
	brne_s r0,0,L_8f551c
	.global L_8f54ba
L_8f54ba:
	mov_s r13,0x0
L_8f54bc:
	stb_s r13,[r14,0xa]
L_8f54be:
	st r16,[r14, 0x18]
L_8f54c2:
	add r0,r14,0x1c
L_8f54c6:
	mov_s r1,r17
L_8f54c8:
	bl.d L_8c0380
L_8f54cc:
	mov_s r2,0x6
L_8f54ce:
	st_s r13,[r14,0x24]
L_8f54d0:
	st_s r13,[r14,0x44]
L_8f54d2:
	st_s r13,[r14,0x28]
L_8f54d4:
	mov_s r0,0x1
L_8f54d6:
	st.as r0,[r14,0x61]
L_8f54da:
	st_s r13,[r14,0x48]
L_8f54dc:
	st_s r13,[r14,0x2c]
L_8f54de:
	stb r13,[r14, 0x4c]
L_8f54e2:
	add3 r0,r14,0xe
L_8f54e6:
	bl.d L_8d9264
L_8f54ea:
	mov_s r1,r14
L_8f54ec:
	add3 r0,r14,0x1e
L_8f54f0:
	bl.d L_8f5688
L_8f54f4:
	mov_s r1,r14
L_8f54f6:
	mov_s r0,r15
L_8f54f8:
	bl.d L_8d8d30
L_8f54fc:
	mov_s r1,r14
L_8f54fe:
	mov_s r0,r14
L_8f5500:
	add r0,r0,0x164
L_8f5504:
	bl.d L_8f53b8
L_8f5508:
	mov_s r1,r14
L_8f550a:
	bl.d L_8e7574
L_8f550e:
	mov_s r0,r14
L_8f5510:
	stw 0xffff,[r14, 0xc]
L_8f5518:
	b L_8c023c
	.global L_8f551c
L_8f551c:
	mov_s r0,blink
L_8f551e:
	mov_s r1,0x11bd
L_8f5524:
	bl L_8c9b28
L_8f5528:
	b_s L_8f54ba
L_8f552a:
	nop_s
