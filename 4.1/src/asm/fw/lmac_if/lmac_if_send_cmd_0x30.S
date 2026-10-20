/* lmac_if_send_cmd_0x30 @ 0x8d852c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_sysapi_force_mcs
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x30,"ax",@progbits
	.global lmac_if_send_cmd_0x30
lmac_if_send_cmd_0x30:
	.global L_8d852c
L_8d852c:
	push_s blink
L_8d852e:
	bl L_8c02c0
L_8d8532:
	mov_s r14,r0
L_8d8534:
	mov_s r13,r1
L_8d8536:
	bl.d L_8c2b0c
L_8d853a:
	mov_s r15,r2
L_8d853c:
	stb_s r14,[r0]
L_8d853e:
	stb_s r13,[r0,0x1]
L_8d8540:
	stb_s r15,[r0,0x2]
L_8d8542:
	mov_s r1,0x30
L_8d8544:
	mov_s r2,0x3
L_8d8546:
	bl.d L_8e0694
L_8d854a:
	mov_s r3,0x0
L_8d854c:
	b L_8c032c
