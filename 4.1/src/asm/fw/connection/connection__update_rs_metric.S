/* connection__update_rs_metric @ 0x8c4938, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   connection.cpp
 * Зовут его: lmac_if__rs_done_evt
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, conn__metric_average, conn__push_metric_sample, conn__threshold_to_offset, fw_sysassert_fatal
 */
	.section .text.connection__update_rs_metric,"ax",@progbits
	.global connection__update_rs_metric
connection__update_rs_metric:
	.global L_8c4938
L_8c4938:
	push_s blink
L_8c493a:
	bl L_8c02bc
L_8c493e:
	mov_s r13,r0
L_8c4940:
	mov_s r14,r1
L_8c4942:
	mov_s r1,0x800fa0
L_8c4948:
	bl.d L_8c653c
L_8c494c:
	mov_s r2,r14
L_8c494e:
	mov_s r16,r0
L_8c4950:
	breq_s r14,0,L_8c4978
	.global L_8c4952
L_8c4952:
	mov_s r0,r13
L_8c4954:
	bl.d L_8e23e0
L_8c4958:
	mov_s r1,r16
L_8c495a:
	bl.d L_8e2428
L_8c495e:
	mov_s r0,r13
L_8c4960:
	add r13,r13,0x185
L_8c4964:
	ld.as r1,[gp,-0x56]
L_8c4968:
	stb_s r0,[r13]
L_8c496a:
	/* add_s r1,0x1 */
	.byte 0x01,0xe1
L_8c496c:
	st.as r1,[gp,-0x56]
L_8c4970:
	b.d L_8c0324
L_8c4974:
	stb r0,[gp, 0xbe]
	.global L_8c4978
L_8c4978:
	mov_s r0,blink
L_8c497a:
	mov_s r2,0x100e298
L_8c4980:
	mov_s r1,0x11be
L_8c4986:
	bl.d L_8c82c0
L_8c498a:
	mov r3,0x16d
L_8c498e:
	b_s L_8c4952
