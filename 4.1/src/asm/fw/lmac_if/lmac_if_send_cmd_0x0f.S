/* lmac_if_send_cmd_0x0f @ 0x8d8a5c, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: disassoc_done, maintain_sm__on_start_maintain
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x0f,"ax",@progbits
	.global lmac_if_send_cmd_0x0f
lmac_if_send_cmd_0x0f:
	.global L_8d8a5c
L_8d8a5c:
	push_s blink
L_8d8a5e:
	bl L_8c02c4
L_8d8a62:
	mov_s r14,r0
L_8d8a64:
	bl.d L_8c2b0c
L_8d8a68:
	mov_s r13,r1
L_8d8a6a:
	st_s r14,[r0]
L_8d8a6c:
	stw_s r13,[r0,0x4]
L_8d8a6e:
	mov_s r1,0xf
L_8d8a70:
	mov_s r2,0x8
L_8d8a72:
	bl.d L_8e0694
L_8d8a76:
	mov_s r3,0x0
L_8d8a78:
	b L_8c0334
