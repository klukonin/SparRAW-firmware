/* stream_mgr__on_delba @ 0x8c2944, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   stream_mgr.cpp
 * Зовут его: stream_mgr__rx_action
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_sysassert_fatal, stream_mgr__find_vring_by_cid, ul_stream__ba_sm_evt
 */
	.section .text.stream_mgr__on_delba,"ax",@progbits
	.global stream_mgr__on_delba
stream_mgr__on_delba:
	.global L_8c2944
L_8c2944:
	push_s blink
L_8c2946:
	bl L_8c02c4
L_8c294a:
	mov_s r14,r0
L_8c294c:
	ldb_s r0,[r0,0x5]
L_8c294e:
	lsr_s r0,r0,0x2
L_8c2950:
	bl.d L_8cab10
L_8c2954:
	bmsk_s r0,r0,0x3
L_8c2956:
	mov.f r13,r0
L_8c295a:
	beq_s L_8c296e
	.global L_8c295c
L_8c295c:
	mov_s r0,r13
L_8c295e:
	mov_s r1,0x4
L_8c2960:
	mov_s r2,r14
L_8c2962:
	mov_s r3,0x0
L_8c2964:
	bl.d L_8d6afc
L_8c2968:
	mov_s r4,r3
L_8c296a:
	b L_8c0334
	.global L_8c296e
L_8c296e:
	mov_s r0,blink
L_8c2970:
	mov_s r2,0x100e398
L_8c2976:
	mov_s r1,0x1294
L_8c297c:
	bl.d L_8c82c0
L_8c2980:
	mov r3,0x197
