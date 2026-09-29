/* LMAC_IF__rs_started @ 0x8d8984, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   LMAC_IF::rs_started - Host - IGNORE
 *   LMAC_IF::rs_started_evt Ignored
 *   lmac_if.cpp
 * Зовут его: lmac_if__ucode_event_dispatch
 * Зовёт сам: conn_mgr__by_cid, fw_log__emit0, fw_sysassert_fatal
 */
	.section .text.LMAC_IF__rs_started,"ax",@progbits
	.global LMAC_IF__rs_started
LMAC_IF__rs_started:
	.global L_8d8984
L_8d8984:
	push_s blink
L_8d8986:
	bl.d L_8c9e44
L_8d898a:
	ld_s r0,[r0]
L_8d898c:
	breq_s r0,0,L_8d899e
L_8d898e:
	mov_s r2,0x1004370
L_8d8994:
	mov_s r0,0x0
L_8d8996:
	bl.d L_8edfb0
L_8d899a:
	mov_s r1,0x2
L_8d899c:
	b_s L_8d89c0
	.global L_8d899e
L_8d899e:
	mov_s r2,0x1004394
L_8d89a4:
	mov_s r0,0x0
L_8d89a6:
	bl.d L_8edfb0
L_8d89aa:
	mov_s r1,0x1
L_8d89ac:
	mov_s r0,blink
L_8d89ae:
	mov_s r2,0x1003e50
L_8d89b4:
	mov_s r1,0xca
L_8d89b6:
	bset_s r1,r1,0xc
L_8d89b8:
	bl.d L_8c82c0
L_8d89bc:
	mov r3,0x22d
	.global L_8d89c0
L_8d89c0:
	pop_s blink
L_8d89c2:
	j_s [blink]
