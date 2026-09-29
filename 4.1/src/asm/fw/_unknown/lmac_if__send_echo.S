/* lmac_if__send_echo @ 0x8c719c, 28 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r13_ret, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.lmac_if__send_echo,"ax",@progbits
	.global lmac_if__send_echo
lmac_if__send_echo:
	.global L_8c719c
L_8c719c:
	push_s blink
L_8c719e:
	push_s r13
L_8c71a0:
	bl.d L_8c2b0c
L_8c71a4:
	mov_s r13,r1
L_8c71a6:
	st_s r13,[r0]
L_8c71a8:
	mov_s r1,0x2
L_8c71aa:
	mov_s r2,0x4
L_8c71ac:
	bl.d L_8e0694
L_8c71b0:
	mov_s r3,0x0
L_8c71b2:
	b L_8c033c
L_8c71b6:
	nop_s
