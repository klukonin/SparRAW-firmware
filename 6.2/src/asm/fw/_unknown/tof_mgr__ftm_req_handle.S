/* tof_mgr__ftm_req_handle @ 0x8c38e8, 72 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   [TOF] Handle AOA measurment request id %d, # of destination %d
 *   [TOF] tof_mgr::ftm_req_handle() No tof sessions in the list
 * Зовут его: wmi_aoa_meas
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit0, fw_log_emit2, tof__find_session_by_addr, tof__next_request, tof_mgr__alloc_entry
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global tof_mgr__ftm_req_handle
tof_mgr__ftm_req_handle:
	.global L_8c38e8
L_8c38e8:
	push_s blink
L_8c38ea:
	bl L_8c01e0
L_8c38ee:
	mov_s r14,r0
L_8c38f0:
	mov_s r13,r1
L_8c38f2:
	mov_s r15,r2
L_8c38f4:
	ld_s r2,[r13]
L_8c38f6:
	mov_s r1,0x101986c
L_8c38fc:
	mov_s r0,0x2b
L_8c38fe:
	bl.d L_8dcc80
L_8c3902:
	ldw_s r3,[r13,0x6]
L_8c3904:
	mov_s r0,r14
L_8c3906:
	mov_s r1,r13
L_8c3908:
	bl.d L_8e1df8
L_8c390c:
	mov_s r2,r15
L_8c390e:
	bl.d L_8e0b58
L_8c3912:
	mov_s r0,r14
L_8c3914:
	brne_s r0,0,L_8c392a
L_8c3916:
	mov_s r1,0x1019830
L_8c391c:
	bl.d L_8dcba8
L_8c3920:
	mov_s r0,0xb
L_8c3922:
	mov_s r0,r14
L_8c3924:
	bl.d L_8cb380
L_8c3928:
	ld_s r1,[r13]
	.global L_8c392a
L_8c392a:
	b L_8c024c
L_8c392e:
	nop_s
