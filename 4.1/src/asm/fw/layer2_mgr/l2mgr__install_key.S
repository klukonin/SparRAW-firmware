/* l2mgr__install_key @ 0x8ed778, 164 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   install_key_handle failed, CID: %d is NULL
 *   Sent KEY API to UCODE
 *   layer2_mgr.cpp
 *   install_key_handle failed, trigger disconnect for MID %d
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, conn_mgr__by_cid, fw_log__emit0, fw_log__emit1, fw_sysassert_fatal, install_key_index_stub, l2mgr__disconnect_sta, l2mgr__vring_drained, log_hexdump, mid__conn_state_ne_1, mid_list__by_mid
 */
	.section .text.l2mgr__install_key,"ax",@progbits
	.global l2mgr__install_key
l2mgr__install_key:
L_8ed778:
	push_s blink
L_8ed77a:
	bl L_8c02b8
L_8ed77e:
	mov_s r17,r0
L_8ed780:
	bl.d L_8ca1b0
L_8ed784:
	mov_s r16,r1
L_8ed786:
	mov_s r15,r0
L_8ed788:
	bl.d L_8c9e44
L_8ed78c:
	mov_s r0,r16
L_8ed78e:
	mov.f r13,r0
L_8ed792:
	bne_s L_8ed7a6
L_8ed794:
	mov_s r2,0x100d6f0
L_8ed79a:
	mov_s r0,0x0
L_8ed79c:
	mov_s r1,0x1
L_8ed79e:
	bl.d L_8edfcc
L_8ed7a2:
	mov_s r3,r16
L_8ed7a4:
	b_s L_8ed81a
	.global L_8ed7a6
L_8ed7a6:
	bl L_8ed820
L_8ed7aa:
	breq_s r0,0,L_8ed7e8
	.global L_8ed7ac
L_8ed7ac:
	ld r0,[r13, 0xe0]
L_8ed7b0:
	add r16,r13,0x10
L_8ed7b4:
	add r14,r13,0x24
L_8ed7b8:
	breq_s r0,0,L_8ed800
L_8ed7ba:
	bl.d L_8e7240
L_8ed7be:
	mov_s r0,r13
L_8ed7c0:
	breq_s r0,0,L_8ed800
L_8ed7c2:
	mov_s r0,r14
L_8ed7c4:
	bl.d L_8c7f90
L_8ed7c8:
	mov_s r1,0x10
L_8ed7ca:
	ldb_s r0,[r13,0x8]
L_8ed7cc:
	mov_s r1,0x0
L_8ed7ce:
	ldb_s r3,[r14,0x10]
L_8ed7d0:
	mov_s r2,r14
L_8ed7d2:
	bl.d L_8e9440
L_8ed7d6:
	mov_s r4,r1
L_8ed7d8:
	mov_s r2,0x100d71c
L_8ed7de:
	mov_s r0,0x0
L_8ed7e0:
	bl.d L_8edfb0
L_8ed7e4:
	mov_s r1,0x2
L_8ed7e6:
	b_s L_8ed81a
	.global L_8ed7e8
L_8ed7e8:
	mov_s r0,blink
L_8ed7ea:
	mov_s r2,0x100c474
L_8ed7f0:
	mov_s r1,0x141e
L_8ed7f6:
	bl.d L_8c82c0
L_8ed7fa:
	mov r3,0x7d0
L_8ed7fe:
	b_s L_8ed7ac
	.global L_8ed800
L_8ed800:
	mov_s r2,0x100d734
L_8ed806:
	mov_s r0,0x0
L_8ed808:
	mov_s r1,0x1
L_8ed80a:
	bl.d L_8edfcc
L_8ed80e:
	mov_s r3,r17
L_8ed810:
	ldb_s r0,[r15,0x10]
L_8ed812:
	mov_s r1,r16
L_8ed814:
	bl.d L_8eb494
L_8ed818:
	mov_s r2,0x1
	.global L_8ed81a
L_8ed81a:
	.byte 0x05,0x03
