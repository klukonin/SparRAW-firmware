/* connection__init @ 0x8ed290, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   connection.cpp
 * Зовут его: mid__add_connection, mid__link_acquisition_action, scan_mngr__prob_done
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, conn_msm__init, connection__reset_fields, connection__reset_metrics, fw_sysassert_fatal, memcpy_fw, mlme_sm__init
 */
	.section .text.connection__init,"ax",@progbits
	.global connection__init
connection__init:
	.global L_8ed290
L_8ed290:
	push_s blink
L_8ed292:
	bl L_8c02b8
L_8ed296:
	mov_s r14,r0
L_8ed298:
	add2 r15,r0,0x3f
L_8ed29c:
	ldb_s r0,[r15]
L_8ed29e:
	mov_s r17,r1
L_8ed2a0:
	mov_s r16,r2
L_8ed2a2:
	brne_s r0,0,L_8ed2f2
	.global L_8ed2a4
L_8ed2a4:
	mov_s r13,0x0
L_8ed2a6:
	stb_s r13,[r14,0xa]
L_8ed2a8:
	st r16,[r14, 0xc]
L_8ed2ac:
	add r0,r14,0x10
L_8ed2b0:
	mov_s r1,r17
L_8ed2b2:
	bl.d L_8c0460
L_8ed2b6:
	mov_s r2,0x6
L_8ed2b8:
	st_s r13,[r14,0x18]
L_8ed2ba:
	st_s r13,[r14,0x38]
L_8ed2bc:
	st_s r13,[r14,0x1c]
L_8ed2be:
	mov_s r0,0x1
L_8ed2c0:
	st.as r0,[r14,0x60]
L_8ed2c4:
	st_s r13,[r14,0x3c]
L_8ed2c6:
	st_s r13,[r14,0x20]
L_8ed2c8:
	stb r13,[r14, 0x40]
L_8ed2cc:
	add2 r0,r14,0x19
L_8ed2d0:
	bl.d L_8d6244
L_8ed2d4:
	mov_s r1,r14
L_8ed2d6:
	add3 r0,r14,0x16
L_8ed2da:
	bl.d L_8ed454
L_8ed2de:
	mov_s r1,r14
L_8ed2e0:
	mov_s r0,r15
L_8ed2e2:
	bl.d L_8d5b1c
L_8ed2e6:
	mov_s r1,r14
L_8ed2e8:
	bl.d L_8e23b4
L_8ed2ec:
	mov_s r0,r14
L_8ed2ee:
	b L_8c031c
	.global L_8ed2f2
L_8ed2f2:
	mov_s r0,blink
L_8ed2f4:
	mov_s r2,0x100e298
L_8ed2fa:
	mov_s r1,0x11bd
L_8ed300:
	bl.d L_8c82c0
L_8ed304:
	mov_s r3,0x2d
L_8ed306:
	b_s L_8ed2a4
