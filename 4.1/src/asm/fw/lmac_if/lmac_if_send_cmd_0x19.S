/* lmac_if_send_cmd_0x19 @ 0x8d8800, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: lmac_if__lmac_ready_evt
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x19,"ax",@progbits
	.global lmac_if_send_cmd_0x19
lmac_if_send_cmd_0x19:
	.global L_8d8800
L_8d8800:
	push_s blink
L_8d8802:
	bl L_8c02c0
L_8d8806:
	mov_s r14,r0
L_8d8808:
	mov_s r13,r1
L_8d880a:
	bl.d L_8c2b0c
L_8d880e:
	mov_s r15,r2
L_8d8810:
	stb_s r14,[r0]
L_8d8812:
	stw_s r13,[r0,0x2]
L_8d8814:
	st_s r15,[r0,0x4]
L_8d8816:
	mov_s r1,0x19
L_8d8818:
	mov_s r2,0x4
L_8d881a:
	bl.d L_8e0694
L_8d881e:
	mov_s r3,0x0
L_8d8820:
	b L_8c032c
