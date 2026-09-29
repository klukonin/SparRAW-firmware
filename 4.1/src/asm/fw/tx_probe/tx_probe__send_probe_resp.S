/* tx_probe__send_probe_resp @ 0x8f0908, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   Sending probe rsp. len %d (%x --> %x)
 *   tx_probe.cpp
 * Зовут его: discovery_handle_probe_req
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit3, fw_sysassert_fatal, mgmt_tx__build_probe_resp, tx_api__send_mgmt
 */
	.section .text.tx_probe__send_probe_resp,"ax",@progbits
	.global tx_probe__send_probe_resp
tx_probe__send_probe_resp:
	.global L_8f0908
L_8f0908:
	push_s blink
L_8f090a:
	bl.d L_8c02b0
L_8f090e:
	mov_s r5,r1
L_8f0910:
	mov_s r16,r0
L_8f0912:
	mov_s r17,r2
L_8f0914:
	mov_s r19,r3
L_8f0916:
	mov r18,r4
L_8f091a:
	mov_s r0,0x0
L_8f091c:
	push_s r0
L_8f091e:
	mov_s r1,sp
L_8f0920:
	mov_s r0,r16
L_8f0922:
	mov_s r2,r5
L_8f0924:
	mov_s r3,r17
L_8f0926:
	bl.d L_8f1f50
L_8f092a:
	mov r4,0x0
L_8f092e:
	ld_s r0,[sp,0x0]
L_8f0930:
	breq_s r0,0,L_8f096a
	.global L_8f0932
L_8f0932:
	mov_s r2,0x101412c
L_8f0938:
	mov_s r0,0xd
L_8f093a:
	mov_s r1,0x2
L_8f093c:
	ld_s r3,[sp,0x0]
L_8f093e:
	mov r4,r16
L_8f0942:
	bl.d L_8ee034
L_8f0946:
	mov r5,r16
L_8f094a:
	ldw r4,[sp]
L_8f094e:
	mov_s r0,r17
L_8f0950:
	mov_s r1,r19
L_8f0952:
	mov_s r2,0x1
L_8f0954:
	mov_s r3,r16
L_8f0956:
	mov r5,r18
L_8f095a:
	bl.d L_8e0c44
L_8f095e:
	mov r6,0x2
L_8f0962:
	mov_s r0,0x0
L_8f0964:
	b.d L_8c030c
L_8f0968:
	add_s sp,sp,0x4
	.global L_8f096a
L_8f096a:
	mov_s r0,blink
L_8f096c:
	mov_s r2,0x101411c
L_8f0972:
	mov_s r1,0x1252
L_8f0978:
	bl.d L_8c82c0
L_8f097c:
	mov_s r3,0x4b
L_8f097e:
	b_s L_8f0932
