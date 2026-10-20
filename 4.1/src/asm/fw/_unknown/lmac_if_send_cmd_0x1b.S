/* lmac_if_send_cmd_0x1b @ 0x8e0718, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: tail_lmac_if_send_cmd_0x1b, tail_lmac_if_send_cmd_0x1b_8d762c, wmi_handler_bcon_ctrl
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, lmac_mbox__alloc_slot, mid__state_is_2_or_3, send_cmd2_lmac
 */
	.section .text.lmac_if_send_cmd_0x1b,"ax",@progbits
	.global lmac_if_send_cmd_0x1b
lmac_if_send_cmd_0x1b:
	.global L_8e0718
L_8e0718:
	push_s blink
L_8e071a:
	bl L_8c02c0
L_8e071e:
	mov_s r14,r1
L_8e0720:
	bl.d L_8c2b0c
L_8e0724:
	mov_s r15,r2
L_8e0726:
	mov_s r13,r0
L_8e0728:
	bl.d L_8d73c4
L_8e072c:
	mov_s r0,r15
L_8e072e:
	cmp_s r0,0x0
L_8e0730:
	mov.ne r0,0x1
L_8e0734:
	stb_s r14,[r13,0x1]
L_8e0736:
	stb_s r0,[r13]
L_8e0738:
	mov_s r0,r13
L_8e073a:
	mov_s r1,0x1b
L_8e073c:
	mov_s r2,0x3
L_8e073e:
	bl.d L_8e0694
L_8e0742:
	mov_s r3,0x0
L_8e0744:
	b L_8c032c
